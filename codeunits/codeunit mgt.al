codeunit 50002 "Custom Codeunit Management"
{
    trigger OnRun();
    begin
    end;

    var
        SalesQuoteLine: Record "Sales Line";
        SalesOrderHeader: Record "Sales Header";
        SalesOrderLine: Record "Sales Line";
        SalesSetup: Record "Sales & Receivables Setup";

        SalesOrderToQuoteMgt: Codeunit "Sales-Quote to Order";


    //Create Blanket Order from Sales Quote Yes/No
    procedure CreateBlanketOrderYesNo(VAR SalesQuoteHeader: Record "Sales Header")
    var
        ConfirmConvertToOrderQst: TextConst ENU = 'Do you want to convert the quote to a blanket order?';
        SalesHeader2: Record "Sales Header";
        OfficeMgt: Codeunit "Office Management";
        OpenPage: Boolean;
        BlanketSalesOrder: Page "Blanket Sales Order";
        OpenNewInvoiceQst: TextConst ENU = 'The quote has been converted to order %1. Do you want to open the new blanket order?';
    begin
        IF IsOnRunHandled(SalesQuoteHeader) THEN
            EXIT;

        SalesQuoteHeader.TESTFIELD("Document Type", SalesQuoteHeader."Document Type"::Quote);
        IF GUIALLOWED THEN
            IF NOT CONFIRM(ConfirmConvertToOrderQst, FALSE) THEN
                EXIT;

        if SalesHeader2.IsEmpty then
            exit;

        SalesQuoteToOrder(SalesQuoteHeader);
        COMMIT;

        OnAfterSalesQuoteToOrderRun(SalesHeader2);
        if GuiAllowed then
            if OfficeMgt.AttachAvailable then
                OpenPage := true
            else
                OpenPage := Confirm(StrSubstNo(OpenNewInvoiceQst, SalesHeader2."No."), true);

        IF OpenPage THEN BEGIN
            CLEAR(BlanketSalesOrder);
            //BlanketSalesOrder.CheckNotificationsOnce;
            BlanketSalesOrder.SETRECORD(SalesOrderHeader);
            BlanketSalesOrder.RUN;
        END;
    end;
    //Create Sales Blanket Order from Sales Quote
    local procedure SalesQuoteToOrder(VAR SalesQuoteHeader: Record "Sales Header")
    var
        Cust: Record Customer;
        SalesCommentLine: Record "Sales Comment Line";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ArchiveManagement: Codeunit "ArchiveManagement";
        SalesCalcDiscountByType: Codeunit "Sales - Calc Discount By Type";
        RecordLinkManagement: Codeunit "Record Link Management";
        ShouldRedistributeInvoiceAmount: Boolean;
        IsHandled: Boolean;
    begin
        with SalesQuoteHeader do begin
            OnBeforeOnRun(SalesQuoteHeader);

            SalesQuoteHeader.TESTFIELD("Document Type", SalesQuoteHeader."Document Type"::Quote);
            ShouldRedistributeInvoiceAmount := SalesCalcDiscountByType.ShouldRedistributeInvoiceDiscountAmount(SalesQuoteHeader);

            Cust.GET(SalesQuoteHeader."Sell-to Customer No.");
            Cust.CheckBlockedCustOnDocs(Cust, SalesQuoteHeader."Document Type"::Order, TRUE, FALSE);
            IF SalesQuoteHeader."Sell-to Customer No." <> SalesQuoteHeader."Bill-to Customer No." THEN BEGIN
                Cust.GET(SalesQuoteHeader."Bill-to Customer No.");
                Cust.CheckBlockedCustOnDocs(Cust, SalesQuoteHeader."Document Type"::"Blanket Order", TRUE, FALSE);
            END;
            SalesQuoteHeader.CALCFIELDS("Amount Including VAT", "Work Description");

            SalesQuoteHeader.ValidateSalesPersonOnSalesHeader(SalesQuoteHeader, TRUE, FALSE);

            //SalesQuoteHeader.CheckForBlockedLines();
            CreateSalesHeader(SalesQuoteHeader, Cust."Prepayment %");

            TransferQuoteToOrderLines(SalesQuoteLine, SalesQuoteHeader, SalesOrderLine, SalesOrderHeader, Cust);
            OnAfterInsertAllSalesOrderLines(SalesOrderLine, SalesQuoteHeader);

            SalesSetup.GET;
            CASE SalesSetup."Archive Quotes" OF
                SalesSetup."Archive Quotes"::Always:
                    ArchiveManagement.ArchSalesDocumentNoConfirm(SalesQuoteHeader);
                SalesSetup."Archive Quotes"::Question:
                    ArchiveManagement.ArchiveSalesDocument(SalesQuoteHeader);
            END;

            IF SalesSetup."Default Posting Date" = SalesSetup."Default Posting Date"::"No Date" THEN BEGIN
                SalesOrderHeader."Posting Date" := 0D;
                SalesOrderHeader.MODIFY;
            END;

            SalesCommentLine.CopyComments("Document Type", SalesOrderHeader."Document Type", "No.", SalesOrderHeader."No.");
            RecordLinkManagement.CopyLinks(SalesQuoteHeader, SalesOrderHeader);
            ApprovalsMgmt.CopyApprovalEntryQuoteToOrder(RECORDID, SalesOrderHeader."No.", SalesOrderHeader.RECORDID);
            IsHandled := FALSE;
            OnBeforeDeleteSalesQuote(SalesQuoteHeader, SalesOrderHeader, IsHandled, SalesQuoteLine);

            IF NOT IsHandled THEN BEGIN
                ApprovalsMgmt.DeleteApprovalEntries(RECORDID);
                DELETELINKS;
                DELETE;
                SalesQuoteLine.DELETEALL;
            END;

            IF NOT ShouldRedistributeInvoiceAmount THEN
                SalesCalcDiscountByType.ResetRecalculateInvoiceDisc(SalesOrderHeader);

            OnAfterOnRun(SalesQuoteHeader, SalesOrderHeader);
        end;
    end;

    local procedure CreateSalesHeader(var SalesHeader: Record "Sales Header"; PrepmtPercent: Decimal)
    VAR
    begin
        OnBeforeCreateSalesHeader(SalesHeader);

        SalesOrderHeader := SalesHeader;
        SalesOrderHeader."Document Type" := SalesOrderHeader."Document Type"::"Blanket Order";
        SalesOrderHeader."No. Printed" := 0;
        SalesOrderHeader.Status := SalesOrderHeader.Status::Open;
        SalesOrderHeader."No." := '';
        SalesOrderHeader."Quote No." := SalesHeader."No.";
        SalesOrderLine.LOCKTABLE;
        OnBeforeInsertSalesOrderHeader(SalesOrderHeader, SalesHeader);
        SalesOrderHeader.INSERT(TRUE);

        SalesOrderHeader."Order Date" := SalesHeader."Order Date";
        IF SalesHeader."Posting Date" <> 0D THEN
            SalesOrderHeader."Posting Date" := SalesHeader."Posting Date";

        SalesOrderHeader.InitFromSalesHeader(SalesHeader);
        SalesOrderHeader."Outbound Whse. Handling Time" := SalesHeader."Outbound Whse. Handling Time";
        SalesOrderHeader.Reserve := SalesHeader.Reserve;

        SalesOrderHeader."Prepayment %" := PrepmtPercent;
        IF SalesOrderHeader."Posting Date" = 0D THEN
            SalesOrderHeader."Posting Date" := WORKDATE;
        SalesHeader.CALCFIELDS("Work Description");
        SalesOrderHeader."Work Description" := SalesHeader."Work Description";
        OnBeforeModifySalesOrderHeader(SalesOrderHeader, SalesHeader);
        SalesOrderHeader.MODIFY;
    end;

    local procedure IsOnRunHandled(SalesHeader: Record "Sales Header") IsHandled: Boolean
    begin
        IsHandled := FALSE;
        OnBeforeRun(Salesheader, IsHandled);
        Exit(IsHandled);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterSalesQuoteToOrderRun(var SalesHeader2: Record "Sales Header")
    begin
    end;

    [IntegrationEvent(false, false)]

    local procedure OnBeforeRun(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCreateSalesHeader(var SalesHeader: Record "Sales Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeDeleteSalesQuote(var QuoteSalesHeader: Record "Sales Header"; var OrderSalesHeader: Record "Sales Header"; var IsHandled: Boolean; var SalesQuoteLine: Record "Sales Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeInsertSalesOrderHeader(var SalesOrderHeader: Record "Sales Header"; var SalesQuoteHeader: Record "Sales Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeModifySalesOrderHeader(var SalesOrderHeader: Record "Sales Header"; SalesQuoteHeader: Record "Sales Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterInsertSalesOrderLine(var SalesOrderLine: Record "Sales Line"; SalesOrderHeader: Record "Sales Header"; SalesQuoteLine: Record "Sales Line"; SalesQuoteHeader: Record "Sales Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterInsertSalesOrderHeader(var SalesOrderHeader: Record "Sales Header"; SalesQuoteHeader: Record "Sales Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterInsertAllSalesOrderLines(var SalesOrderLine: Record "Sales Line"; SalesQuoteHeader: Record "Sales Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnRun(var SalesHeader: Record "Sales Header"; var SalesOrderHeader: Record "Sales Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeArchiveSalesQuote(var SalesQuoteHeader: Record "Sales Header"; var SalesOrderHeader: Record "Sales Header"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeAssignItemCharges(FromDocType: Option; FromDocNo: Code[20]; ToDocType: Option; ToDocNo: Code[20]; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCopyApprovalEntryQuoteToOrder(var QuoteSalesHeader: Record "Sales Header"; var OrderSalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeInsertSalesOrderLine(var SalesOrderLine: Record "Sales Line"; SalesOrderHeader: Record "Sales Header"; SalesQuoteLine: Record "Sales Line"; SalesQuoteHeader: Record "Sales Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnRun(var SalesHeader: Record "Sales Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeTempOpportunityEntryInsert(var TempOpportunityEntry: Record "Opportunity Entry" temporary)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeTransferQuoteLineToOrderLineLoop(var SalesQuoteLine: Record "Sales Line"; var SalesQuoteHeader: Record "Sales Header"; var SalesOrderHeader: Record "Sales Header"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnTransferQuoteToOrderLinesOnAfterSetFilters(var SalesQuoteLine: Record "Sales Line"; var SalesQuoteHeader: Record "Sales Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCreateSalesHeader(var SalesOrderHeader: Record "Sales Header"; SalesHeader: Record "Sales Header")
    begin
    end;


    local procedure TransferQuoteToOrderLines(
        var SalesQuoteLine: Record "Sales Line"; SalesQuoteHeader: Record "Sales Header"; SalesOrderLine: Record "Sales Line"; SalesOrderHeader: Record "Sales Header"; Customer: Record Customer)
    var
        IsHandled: Boolean;
        ATOLink: Record "Assemble-to-Order Link";
        PrepmtMgt: Codeunit "Prepayment Mgt.";
        SalesLineReserve: Codeunit "Sales Line-Reserve";
    begin
        SalesQuoteLine.RESET;
        SalesQuoteLine.SETRANGE("Document Type", SalesQuoteHeader."Document Type");
        SalesQuoteLine.SETRANGE("Document No.", SalesQuoteHeader."No.");
        OnTransferQuoteToOrderLinesOnAfterSetFilters(SalesQuoteLine, SalesQuoteHeader);
        IF SalesQuoteLine.FINDSET THEN
            REPEAT
                IsHandled := FALSE;
                OnBeforeTransferQuoteLineToOrderLineLoop(SalesQuoteLine, SalesQuoteHeader, SalesOrderHeader, IsHandled);
                IF NOT IsHandled THEN BEGIN
                    SalesOrderLine := SalesQuoteLine;
                    SalesOrderLine."Document Type" := SalesOrderHeader."Document Type";
                    SalesOrderLine."Document No." := SalesOrderHeader."No.";
                    SalesOrderLine."Shortcut Dimension 1 Code" := SalesQuoteLine."Shortcut Dimension 1 Code";
                    SalesOrderLine."Shortcut Dimension 2 Code" := SalesQuoteLine."Shortcut Dimension 2 Code";
                    SalesOrderLine."Dimension Set ID" := SalesQuoteLine."Dimension Set ID";
                    IF Customer."Prepayment %" <> 0 THEN
                        SalesOrderLine."Prepayment %" := Customer."Prepayment %";
                    PrepmtMgt.SetSalesPrepaymentPct(SalesOrderLine, SalesOrderHeader."Posting Date");
                    SalesOrderLine.VALIDATE("Prepayment %");
                    IF SalesOrderLine."No." <> '' THEN
                        SalesOrderLine.DefaultDeferralCode;
                    OnBeforeInsertSalesOrderLine(SalesOrderLine, SalesOrderHeader, SalesQuoteLine, SalesQuoteHeader);
                    SalesOrderLine.INSERT;
                    OnAfterInsertSalesOrderLine(SalesOrderLine, SalesOrderHeader, SalesQuoteLine, SalesQuoteHeader);
                    ATOLink.MakeAsmOrderLinkedToSalesOrderLine(SalesQuoteLine, SalesOrderLine);
                    SalesLineReserve.TransferSaleLineToSalesLine(
                      SalesQuoteLine, SalesOrderLine, SalesQuoteLine."Outstanding Qty. (Base)");
                    SalesLineReserve.VerifyQuantity(SalesOrderLine, SalesQuoteLine);
                    IF SalesOrderLine.Reserve = SalesOrderLine.Reserve::Always THEN
                        SalesOrderLine.AutoReserve;
                END;
            UNTIL SalesQuoteLine.NEXT = 0;
    end;


    procedure GetSalesOrderHeader(var SalesHeader2: Record "Sales Header")
    begin
        SalesHeader2 := SalesOrderHeader;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnBeforeCheckAsmToOrder, '', false, false)]
    local procedure "Sales Line_OnBeforeCheckAsmToOrder"(var SalesLine: Record "Sales Line"; AsmHeader: Record "Assembly Header"; var IsHandled: Boolean)
    var
        Text045: Label 'cannot be more than %1';
    begin

        IF SalesLine."Document Type" = SalesLine."Document Type"::Invoice then begin

            SalesLine.TestField("Qty. to Assemble to Order", AsmHeader.Quantity);
            Salesline.TestField(Type, SalesLine.Type::Item);
            Salesline.TestField("No.", AsmHeader."Item No.");
            Salesline.TestField("Location Code", AsmHeader."Location Code");
            Salesline.TestField("Unit of Measure Code", AsmHeader."Unit of Measure Code");
            Salesline.TestField("Variant Code", AsmHeader."Variant Code");
            Salesline.TestField("Shipment Date", AsmHeader."Due Date");
            //     if Salesline."Document Type" in [Salesline."Document Type"::Order, Salesline."Document Type"::Invoice] then begin
            //          AsmHeader.CalcFields("Reserved Qty. (Base)");
            //          AsmHeader.TestField("Reserved Qty. (Base)", AsmHeader."Remaining Quantity (Base)");
            // end;
            Salesline.TestField("Qty. to Asm. to Order (Base)", AsmHeader."Quantity (Base)");
            if Salesline."Outstanding Qty. (Base)" < AsmHeader."Remaining Quantity (Base)" then
                AsmHeader.FieldError("Remaining Quantity (Base)", StrSubstNo(Text045, AsmHeader."Remaining Quantity (Base)"));
            IsHandled := true;
        end;

    end;



}