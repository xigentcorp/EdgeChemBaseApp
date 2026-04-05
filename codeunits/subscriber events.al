codeunit 50000 "CustomSubscriber Management"
{
    EventSubscriberInstance = StaticAutomatic;

    trigger OnRun();
    begin
    end;

    var
        Cust: Record Customer;
        DeptDimensionCode: Code[20];
        i: Integer;

    [EventSubscriber(ObjectType::Table, 36, 'OnBeforeValidateEvent', 'Bill-to Customer No.', false, false)]
    local procedure PreventUsingDefaultPOSCustomer(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer);
    var
        Text50001: Label 'You cannot use this Customer in standard (non POS) transactions';
    begin
        with Rec do begin
            if "Document Type" <> "Document Type"::Quote then begin
                Cust.GET("Sell-to Customer No.");
                with Rec do begin
                    Cust.GET("Sell-to Customer No.");
                    if Cust."POS Default" and not ("POS Transaction") then
                        ERROR(Text50001);
                end;
            end;
        end;
    end;

    /* [EventSubscriber(ObjectType::Table, 36, 'OnBeforeValidateEvent', 'Location Code', false, false)]
      local procedure OnValidateLocationonSalesHeader(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer);
      var
          RespCenter: Record "Responsibility Center";
      begin
          with Rec do begin
              if "Location Code" <> '' then begin
                  RespCenter.get("Location Code");
                  RespCenter.TestField("Global Dimension 1 Code");
                  CreateDim(
                            DATABASE::"Responsibility Center", rec."Location Code",
                            DATABASE::Customer, "Bill-to Customer No.",
                            DATABASE::"Salesperson/Purchaser", "Salesperson Code",
                            DATABASE::Campaign, "Campaign No.",
                            DATABASE::Template, "Bill-to Customer Template Code");
              end;
          end;
      end;*/


    [EventSubscriber(ObjectType::Table, 37, 'OnBeforeModifyEvent', '', false, false)]
    local procedure OnBeforeModifytPopulateSalesLineLocationDimension(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; RunTrigger: Boolean);
    begin
        with Rec do begin
            DeptDimensionCode := GetLocationDimension("Location Code");
            if (DeptDimensionCode <> '') and (xRec."Location Code" <> DeptDimensionCode) then begin
                VALIDATE("Shortcut Dimension 1 Code", DeptDimensionCode);
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, 83, 'OnBeforeModifyEvent', '', false, false)]
    local procedure OnBeforeModifyPopulateItemJournalWithLocationDimension(var Rec: Record "Item Journal Line"; var xRec: Record "Item Journal Line"; RunTrigger: Boolean);
    begin
        with Rec do begin
            DeptDimensionCode := GetLocationDimension("Location Code");
            if (DeptDimensionCode <> '') and (xRec."Location Code" <> DeptDimensionCode) then begin
                VALIDATE("Shortcut Dimension 1 Code", DeptDimensionCode);
            end;
        end;
    end;

    //[EventSubscriber(ObjectType::Table, 38, 'OnAfterCreateDimTableIDs', '', false, false)]
    //local procedure CreateDimensionPurchaseHeaderWithLocationDimension(var PurchaseHeader: Record "Purchase Header"; CallingFieldNo: Integer; TableID: array[10] of Integer; No: array[10] of Code[20]);
    //begin
    //    with PurchaseHeader do begin
    //         DeptDimensionCode := GetLocationDimension("Location Code");
    //        if DeptDimensionCode <> '' then begin
    //           for i := 1 to 10 do begin
    //               if TableID[i] = DATABASE::"Responsibility Center" then
    //                  No[i] := DeptDimensionCode;
    //             end;
    //       end;
    //     end;
    // end;

    [EventSubscriber(ObjectType::Table, 39, 'OnBeforeModifyEvent', '', false, false)]
    local procedure OnBeforeModifyPopulatePurchaseLineWithLocationDimension(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; RunTrigger: Boolean);
    begin
        with Rec do begin
            DeptDimensionCode := GetLocationDimension("Location Code");
            if (DeptDimensionCode <> '') and (xRec."Location Code" <> DeptDimensionCode) then
                VALIDATE("Shortcut Dimension 1 Code", DeptDimensionCode);
        end;
    end;

    [EventSubscriber(ObjectType::Table, 36, 'OnCustomerCreditLimitExceeded', '', false, false)]
    local procedure OverLimitExceededSalesHeader(var Sender: Record "Sales Header");
    begin
        with Sender do begin
            "Over Limit" := true;
            if MODIFY then;
        end;
    end;

    [EventSubscriber(ObjectType::Table, 36, 'OnCustomerCreditLimitNotExceeded', '', false, false)]
    local procedure OverLimitNotExceededSalesHeader(var Sender: Record "Sales Header");
    begin
        with Sender do begin
            "Over Limit" := false;
            if MODIFY then;
        end;
    end;

    local procedure GetLocationDimension(LocationCode: Code[20]): Code[20];
    var
        Location: Record Location;
    begin
        DeptDimensionCode := '';
        if Location.GET(LocationCode) then
            exit(Location."Store Dimension");

    end;


    [EventSubscriber(ObjectType::Table, 21, 'OnAfterCopyCustLedgerEntryFromGenJnlLine', '', false, false)]
    local procedure OnUpdateCustLedgerFronGenJnl(var CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line");
    begin
        CustLedgerEntry.NSF := GenJournalLine.NSF;
        CustLedgerEntry."POS Transaction" := GenJournalLine."POS Transaction";
    end;



    /*[EventSubscriber(ObjectType::Table, 18, 'OnBeforeInsertEvent', '', false, false)]
    local procedure PopulatedCustIDForPOS(var Rec: Record Customer; RunTrigger: Boolean)
    var
        MaxCID: Integer;
        Cust: Record Customer;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeries: Code[20];
        No: Code[20];
    begin
        with rec do begin
            if not IsTemporary then begin
                MaxCID := 0;
                NoSeries := 'POSCUSTID';
                NoSeriesMgt.InitSeries('POSCUSTID', 'POSCUSTID', Today, No, NoSeries);
                if Evaluate(MaxCID, No) then
                    "POS Cust ID" := MaxCID;

            end;
        end;
    end;
*/
    /*[EventSubscriber(ObjectType::Table, 27, 'OnBeforeInsertEvent', '', false, false)]
    local procedure PopulatedItemIDForPOS(var Rec: Record Item; RunTrigger: Boolean)
    var

        MaxCID: Integer;
        Item: Record Item;
        NoSeriesMgt: Codeunit "No. Series";
        NoSeries: Code[20];
        No: Code[20];
    begin
        with rec do begin
            if not IsTemporary then begin
                MaxCID := 0;
                NoSeries := 'POSITEMID';
                NoSeriesMgt.GetNoSeriesLine('POSITEMID', 'POSITEMID', Today, No, NoSeries);
                if Evaluate(MaxCID, No) then
                    "POS Item ID" := MaxCID;
            end;
        end;
    end;*/


    [EventSubscriber(ObjectType::Table, 36, 'OnBeforeValidateEvent', 'Location Code', false, false)]
    local procedure TestPOSInt(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    var
        Location: Record Location;
    begin
        WITH rec do begin
            Clear(Location);
            IF Location.GET("Location Code") THEN;

            if not Rec.IsTemporary then begin
                IF (Location."Posted Invoice No. Series" <> '') AND (NOT "POS Transaction") AND
                   ("Document Type" IN ["Document Type"::Order, "Document Type"::Invoice, "Document Type"::Quote]) THEN begin
                    "Posting No. Series" := Location."Posted Invoice No. Series";
                    "Posting No." := '';
                end;

                IF (Location."Posted Cr. Memo No. Series" <> '') AND (NOT "POS Transaction") AND
                   ("Document Type" = "Document Type"::"Credit Memo") THEN begin
                    "Posting No. Series" := Location."Posted Cr. Memo No. Series";
                    "Posting No." := '';
                end;


            end;

        end;

    end;

    /*  [EventSubscriber(ObjectType::Codeunit, 414, 'OnAfterManualReOpenSalesDoc', '', false, false)]
      local procedure GroupCodeApproval(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean)
      var
          ApprovalEntry: Record "Approval Entry";
      begin
          ApprovalEntry.Reset;
          ApprovalEntry.SetRange("Table ID", 36);
          ApprovalEntry.SetRange("Document No.", SalesHeader."No.");
          ApprovalEntry.SetRange("Document Type", SalesHeader."Document Type");
          ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
          if ApprovalEntry.FindSet then
              repeat
                  ApprovalEntry.Status := ApprovalEntry.Status::Canceled;
                  ApprovalEntry.Modify;
              until ApprovalEntry.Next = 0;
      end;*/

    [EventSubscriber(ObjectType::Table, 5741, 'OnAfterValidateEvent', 'Item No.', true, true)]
    local procedure UpdateGenBusCode(var Rec: Record "Transfer Line"; var xRec: Record "Transfer Line"; CurrFieldNo: Integer)

    var
        IvSetup: Record "Inventory Setup";
    begin
        IvSetup.get();
        Ivsetup.TestField("Transfer Gen. Bus. Group");
        rec."Gen. Bus. Posting Group" := IvSetup."Transfer Gen. Bus. Group";
    End;

    [EventSubscriber(ObjectType::Table, 5745, 'OnAfterCopyFromTransferLine', '', true, true)]
    local procedure SetShipmentGenBusPosting(VAR TransferShipmentLine: Record "Transfer Shipment Line"; TransferLine: Record "Transfer Line")
    begin
        TransferShipmentLine."Gen. Bus. Posting Group" := TransferLine."Gen. Bus. Posting Group";
    end;

    [EventSubscriber(ObjectType::Codeunit, 5704, 'OnAfterCreateItemJnlLine', '', true, true)]
    local procedure SetgenbusShpItemJnl(VAR ItemJournalLine: Record "Item Journal Line"; TransferLine: Record "Transfer Line"; TransferShipmentHeader: Record "Transfer Shipment Header"; TransferShipmentLine: Record "Transfer Shipment Line")
    begin
        ItemJournalLine."Gen. Bus. Posting Group" := TransferLine."Gen. Bus. Posting Group";
    end;

    [EventSubscriber(ObjectType::Table, 5747, 'OnAfterCopyFromTransferLine', '', true, true)]
    local procedure SetRecptGenBusPosting(VAR TransferReceiptLine: Record "Transfer Receipt Line"; TransferLine: Record "Transfer Line")
    begin
        TransferReceiptLine."Gen. Bus. Posting Group" := TransferLine."Gen. Bus. Posting Group";
    end;

    [EventSubscriber(ObjectType::Codeunit, 5705, 'OnBeforePostItemJournalLine', '', true, true)]
    local procedure SetgenbusRecptItemJnl(VAR ItemJournalLine: Record "Item Journal Line"; TransferLine: Record "Transfer Line"; TransferReceiptHeader: Record "Transfer Receipt Header"; TransferReceiptLine: Record "Transfer Receipt Line"; CommitIsSuppressed: Boolean)
    begin
        // Set the Business Posting Group to information on the transfer line in the G/L to the description on the transaction 
        ItemJournalLine."Gen. Bus. Posting Group" := TransferLine."Gen. Bus. Posting Group";
    end;

    /*[EventSubscriber(ObjectType::Codeunit, 90, 'OnAfterFillInvoicePostBuffer', '', true, true)]
    local procedure SetLineDesc(VAR InvoicePostBuffer: Record "Invoice Post. Buffer"; PurchLine: Record "Purchase Line"; var TempInvoicePostBuffer: Record "Invoice Post. Buffer"; CommitIsSupressed: Boolean)
    begin
        // Set the description in the G/L to the description on the transaction 
        InvoicePostBuffer.Description := PurchLine.Description;
    end;*/

    /* [EventSubscriber(ObjectType::Codeunit, 90, 'OnBeforePostInvPostBuffer', '', true, true)]
     local procedure SetglLineDescription(VAR GenJnlLine: Record "Gen. Journal Line"; VAR InvoicePostBuffer: Record "Invoice Post. Buffer"; VAR PurchHeader: Record "Purchase Header"; VAR GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; PreviewMode: Boolean; CommitIsSupressed: Boolean)
     // Set the description in the G/L to the description on the transaction 
     begin
         GenJnlLine.Description := InvoicePostBuffer.Description;
     end;*/


    // Prevent Sales Order deletion if the Reason Code is not populated 
    [EventSubscriber(ObjectType::Page, page::"Sales Order", 'OnDeleteRecordEvent', '', true, true)]
    local procedure validatereasoncodeondelete(VAR Rec: Record "Sales Header"; VAR AllowDelete: Boolean)
    begin
        rec.TestField("Reason Code");
    end;

    [EventSubscriber(ObjectType::Page, page::"Sales Order List", 'OnDeleteRecordEvent', '', true, true)]
    local procedure validatereasoncodeondeletefromlist(VAR Rec: Record "Sales Header"; VAR AllowDelete: Boolean)
    begin
        rec.TestField("Reason Code");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Assembly Header", OnBeforeValidateDates, '', false, false)]
    local procedure "Assembly Header_OnBeforeValidateDates"(var AssemblyHeader: Record "Assembly Header"; FieldNumToCalculateFrom: Integer; var DoNotValidateButJustAssign: Boolean; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Assembly Header", OnBeforeCheckIsNotAsmToOrder, '', false, false)]
    local procedure "Assembly Header_OnBeforeCheckIsNotAsmToOrder"(var AssemblyHeader: Record "Assembly Header"; var IsHandled: Boolean; xAssemblyHeader: Record "Assembly Header"; CurrentFieldNo: Integer; CallingFieldNo: Integer)
    begin
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnBeforeCheckShipmentDateBeforeWorkDate, '', false, false)]
    local procedure "Sales Line_OnBeforeCheckShipmentDateBeforeWorkDate"(var Sender: Record "Sales Line"; var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; var HasBeenShown: Boolean; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Assembly Header", OnUpdateAllLineDimOnBeforeConfirmUpdatedDimension, '', false, false)]
    local procedure "Assembly Header_OnUpdateAllLineDimOnBeforeConfirmUpdatedDimension"(var AssemblyHeader: Record "Assembly Header"; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnBeforeConfirmUpdateAllLineDim, '', false, false)]
    local procedure "Sales Header_OnBeforeConfirmUpdateAllLineDim"(var SalesHeader: Record "Sales Header"; var xSalesHeader: Record "Sales Header"; NewParentDimSetID: Integer; OldParentDimSetID: Integer; var Confirmed: Boolean; var IsHandled: Boolean)
    begin
        ishandled := true;
    end;

}

