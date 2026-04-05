report 50012 "Commission Statement"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Commission Statement.rdlc';
    ApplicationArea = Basic, Suite, "Sales & Marketing";
    UsageCategory = Tasks;
    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.", "Salesperson Code";
            PrintOnlyIfDetail = true;
            column(companyName; CompanyInfo.Name)
            {
            }
            column(commFromDate; FromDate)
            {
            }
            column(commToDate; ToDate)
            {
            }
            column(commSalesPersonCode; "Salesperson Code")
            {
            }
            column(SalespersonName; SalesPurchperson.Name)
            {

            }
            column(commCustName; Customer.Name)
            {
            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = FIELD("No.");
                DataItemTableView = SORTING("Customer No.", "Posting Date", "Currency Code") ORDER(Ascending) WHERE("Document Type" = FILTER(Invoice | "Credit Memo"));
                PrintOnlyIfDetail = false;
                column(cleDocumentNo; "Cust. Ledger Entry"."Document No.")
                {
                }
                column(clePostingDate; "Posting Date")
                {
                }
                column(cleAmount; Amount)
                {
                }
                column(cleUnder60Days; -Current)
                {
                }
                column(cleOver60Under90; -Net60Days)
                {
                }
                column(cleOver90; -AmtNotSubj)
                {
                }
                column(cleTotalPaid; -AmtNotSubj + -Current + -Net60Days)
                {
                }
                column(clePctUnder90Collected; AmountCollected)
                {
                }
                column(clePctOver90Collected; AmountCollected2)
                {
                }
                column(clePctTotallPaid; TotalAmtCollected2)
                {
                }
                column(cleSalesLCY; "Sales (LCY)")
                {
                }
                dataitem(CommissionBuffer; "Integer")
                {
                    DataItemTableView = SORTING(Number);
                    UseTemporary = false;
                    column(cbExceptionText; CommissionEntry."Comm Excpt Text")
                    {
                    }
                    column(cbDocumentNo; CommissionEntry."Document No.")
                    {
                    }
                    column(cbProdGroup; CommissionEntry."Dimension Value")
                    {
                    }
                    column(cbAmountExclTax; CommissionEntry.Amount)
                    {
                    }
                    column(cbAmountSubjtoCommission; AmtSubjecttoComm)
                    {
                    }
                    column(cbCommRate; CommissionEntry."Commission Rate" * 100)
                    {
                    }
                    column(cbCommissionDollars; CommissionEntry."Commission Rate" * AmtSubjecttoComm)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin

                        if Number = 1 then begin
                            if CommissionEntry.FindFirst then
                                ;
                        end else begin
                            CommissionEntry.Next;
                        end;

                        //CALC Subject to Commission

                        IF AmountCollected <> 0 THEN
                            AmtSubjecttoComm := CommissionEntry.Amount * (NetAmountCollected / 100)
                        ELSE
                            AmtSubjecttoComm := CommissionEntry.Amount;
                        TotalSubjToComm := TotalSubjToComm + AmtSubjecttoComm;
                        TotCustCommission := TotCustCommission + (CommissionEntry."Commission Rate" * AmtSubjecttoComm);
                        TotalCommissionable := TotalCommissionable + AmtSubjecttoComm;
                        TotalCommission := TotalCommission + (CommissionEntry."Commission Rate" * AmtSubjecttoComm);

                        //




                    end;

                    trigger OnPreDataItem()
                    begin
                        //Message(format(NoOfRec));
                        SetRange(Number, 1, NoOfRec);
                        CommissionEntry.Reset;
                        CommissionEntry.SetRange("Document No.", "Cust. Ledger Entry"."Document No.");
                        if NoOfRec = 1 then begin
                            if CommissionEntry.FindFirst then
                                ;
                        end else begin
                            if CommissionEntry.FindSet then
                                ;
                        end;

                    end;
                }

                trigger OnAfterGetRecord()
                var
                    DimValue: Record "Dimension Value";
                    EntryNo: Integer;
                    VLE: Record "Value Entry";
                    ExcptExist: Boolean;
                begin

                    NoOfRec := 0;
                    AmtSubj := 0;
                    AmtNotSubj := 0;
                    Net60Days := 0;
                    Current := 0;

                    DetCustLedg.Reset;
                    DetCustLedg.SetCurrentKey("Cust. Ledger Entry No.", "Document Type", "Posting Date");
                    DetCustLedg.SetRange("Cust. Ledger Entry No.", "Entry No.");
                    DetCustLedg.SetRange("Document Type", DetCustLedg."Initial Document Type"::Payment);
                    DetCustLedg.SetFilter("Posting Date", '%1..%2', FromDate, ToDate);
                    DetCustLedg.CalcSums(Amount);
                    if "Document Type" = "Document Type"::Invoice then
                        if DetCustLedg.Amount = 0 then
                            CurrReport.Skip;

                    if ("Document Type" = "Document Type"::"Credit Memo") and
                       ("Posting Date" < FromDate) or
                       ("Posting Date" > ToDate) then
                        CurrReport.Skip;
                    if SalesPurchperson.Get(Customer."Salesperson Code") then
                        ;
                    ZeroComm := false;

                    if DetCustLedg.FindSet then
                        repeat
                            if DetCustLedg."Posting Date" <= ("Posting Date" + SalesSetup."Cutoff Period") then begin

                                if (DetCustLedg."Posting Date" <= ("Posting Date" + 89)) and (DetCustLedg."Posting Date" >= ("Posting Date" + 61)) then begin
                                    Net60Days := DetCustLedg.Amount;
                                    AmtSubj := (DetCustLedg.Amount * 0.6) + AmtSubj;
                                end else begin
                                    Current += DetCustLedg.Amount;
                                    AmtSubj := DetCustLedg.Amount + AmtSubj;
                                end;
                            end else
                                AmtNotSubj := AmtNotSubj + DetCustLedg.Amount;
                        until DetCustLedg.Next = 0;

                    if AmtSubj <> 0 then
                        ZeroComm := false
                    else
                        ZeroComm := true;
                    DimValue.Reset;
                    DimValue.SetRange("Dimension Code", 'PRODGRP');
                    if DimValue.FindSet then
                        repeat
                            VLE.Reset;
                            VLE.SetCurrentKey("Global Dimension 2 Code", "Document No.", "Item Ledger Entry Type");
                            VLE.SetRange("Global Dimension 2 Code", DimValue.Code);
                            VLE.SetRange("Document No.", "Document No.");
                            VLE.SetRange("Item Ledger Entry Type", VLE."Item Ledger Entry Type"::Sale);
                            if VLE.FindSet then
                                repeat
                                    if SalesPurchperson."Commission Exception" then begin
                                        CommExcpt.Reset;
                                        CommExcpt.SetRange("Commission Exception Type", CommExcpt."Commission Exception Type"::Salesperson);
                                        CommExcpt.SetRange("Commission Exception Code", Customer."Salesperson Code");
                                        CommExcpt.SetRange("Dimension Value", DimValue.Code);
                                        if not CommExcpt.FindFirst then
                                            exit
                                        else
                                            CommExcpt.FindFirst;
                                    end;
                                    if Customer."Commission Exception" then begin

                                        CommExcpt.Reset;
                                        CommExcpt.SetRange("Commission Exception Type", CommExcpt."Commission Exception Type"::Customer);
                                        CommExcpt.SetRange("Commission Exception Code", Customer."No.");
                                        CommExcpt.SetRange("Dimension Value", DimValue.Code);
                                        if CommExcpt.FindFirst then
                                            ExcptExist := true
                                        else
                                            ExcptExist := false;
                                    end;

                                    CommissionEntry.Reset;
                                    CommissionEntry.SetRange("Document No.", VLE."Document No.");
                                    CommissionEntry.SetRange("Dimension Value", DimValue.Code);
                                    if not CommissionEntry.FindFirst then begin
                                        EntryNo := VLE."Entry No.";
                                        CommissionEntry."Entry No." := EntryNo;
                                        CommissionEntry."Document No." := VLE."Document No.";
                                        CommissionEntry."Dimension Value" := DimValue.Code;
                                        CommissionEntry.Amount := VLE."Sales Amount (Actual)";


                                        CommissionEntry."Entry Type" := VLE."Entry Type";
                                        if DimValue."Commission Rate" <> 0 then begin
                                            if not ExcptExist then
                                                CommissionEntry."Commission Rate" := DimValue."Commission Rate" / 100
                                            else
                                                CommissionEntry."Commission Rate" := CommExcpt."Commission Exception Rate" / 100;
                                        end else begin
                                            CommissionEntry."Commission Rate" := 0;
                                        end;
                                        if ZeroComm then begin
                                            CommissionEntry."Commission Rate" := 0;
                                            CommissionEntry."Comm Excpt Text" := '**** Over ' + Format(SalesSetup."Cutoff Period") + ' Day Old ****';
                                        end else begin
                                            CommissionEntry."Comm Excpt Text" := '';

                                        end;

                                        if SalesPurchperson."Commission Exception" then begin

                                            if CommExcpt."Commission Exception Rate" <> 0 then
                                                CommissionEntry."Commission Rate" := CommExcpt."Commission Exception Rate" / 100
                                            else
                                                CommissionEntry."Commission Rate" := 0;
                                        end;
                                        CommissionEntry.Insert;
                                        NoOfRec := NoOfRec + 1
                                    end else begin
                                        CommissionEntry.Amount := CommissionEntry.Amount + VLE."Sales Amount (Actual)";
                                        CommissionEntry.Modify;
                                    end;

                                until VLE.Next = 0;
                        until DimValue.Next = 0;

                    //----calc comm

                    IF SalesPurchperson."Commission %" <> 0 THEN
                        CommAmt := AmtSubj * (SalesPurchperson."Commission %" / 100)

                    ELSE
                        CommAmt := 0;



                    TotalSales := TotalSales + Amount;

                    //TotalPayment := TotalPayment +  -AmtSubj;

                    TotCustPayment := TotCustPayment + -Current + -Net60Days + -AmtNotSubj;

                    TotalAmtExclGCT := TotalAmtExclGCT + "Sales (LCY)";

                    TotalNetSales := TotalNetSales + "Sales (LCY)";

                    TotalAmtCollected := -AmtNotSubj + -Current + -Net60Days;

                    TotalPmtOver := TotalPmtOver + -AmtNotSubj;

                    TotalPmtUnder := TotalPmtUnder + (-Current + -Net60Days);

                    GtotUnder := GtotUnder + -Net60Days;

                    GtotCurrent := GtotCurrent + -Current;



                    GtotOver := GtotOver + -AmtNotSubj;

                    TotalPayment := GtotUnder + GtotOver + GtotCurrent;

                    //TotCustPayment +

                    IF (AmtSubj <> 0) AND

                       (Amount <> 0) THEN BEGIN

                        IF (ABS(Amount) - ABS(-AmtSubj)) = 0 THEN
                            AmountCollected := 100;



                        IF (ABS(Amount) - ABS(-AmtSubj)) <> 0 THEN
                            AmountCollected := (ABS(-Current + -Net60Days) / Amount) * 100;

                        NetAmountCollected := (ABS(-AmtSubj) / Amount) * 100;

                    END ELSE BEGIN

                        AmountCollected := 0;

                    END;


                    IF ((AmtSubj) <> 0) AND

                       (Amount <> 0) THEN BEGIN

                        IF (ABS(Amount) - ABS(AmtSubj)) = 0 THEN
                            AmountCollected2 := 100;



                        IF (ABS(Amount) - ABS(AmtSubj)) <> 0 THEN
                            AmountCollected2 := (ABS(AmtNotSubj) / Amount) * 100;

                    END ELSE BEGIN

                        AmountCollected2 := 0;

                    END;



                    IF (TotalAmtCollected <> 0) AND

                       (Amount <> 0) THEN BEGIN

                        IF (ABS(Amount) - ABS(TotalAmtCollected)) = 0 THEN
                            TotalAmtCollected2 := 100;



                        IF (ABS(Amount) - ABS(TotalAmtCollected)) <> 0 THEN
                            TotalAmtCollected2 := (ABS(TotalAmtCollected) / Amount) * 100;

                    END ELSE BEGIN

                        TotalAmtCollected2 := 0;

                    END;




                end;

            }
            dataitem(ReturnedChecks; "Integer")
            {
                UseTemporary = true;
                column(rcDocumentNo; CommissionEntry2."Document No.")
                {
                }
                column(rcAmount; CommissionEntry2.Amount)
                {
                }

                trigger OnAfterGetRecord()
                begin

                    if Number = 1 then begin
                        if CommissionEntry2.FindFirst then
                            ;
                    end else begin
                        CommissionEntry2.Next;
                    end;
                end;

                trigger OnPreDataItem()
                begin

                    SetRange(Number, 1, NoOfRec2);
                    CommissionEntry2.Reset;
                    CommissionEntry2.SetRange("Account No.", Customer."No.");
                    if NoOfRec2 = 1 then begin
                        if CommissionEntry2.FindFirst then
                            ;
                    end else begin
                        if CommissionEntry2.FindSet then
                            ;
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                NoOfRec2 := 0;
                CustLedg.Reset;
                CustLedg.SetRange("Customer No.", Customer."No.");
                CustLedg.SETFILTER("Posting Date", '%1..%2', FromDate, ToDate);
                CustLedg.SetRange(NSF, true);
                if CustLedg.FindSet then
                    repeat
                        CustLedg.CalcFields("Remaining Amount");
                        NoOfRec2 := NoOfRec2 + 1;
                        EntryNo2 := EntryNo2 + 1;
                        CommissionEntry2."Entry No." := EntryNo2;
                        CommissionEntry2."Document No." := CustLedg."Document No.";
                        CommissionEntry2.Amount := CustLedg."Remaining Amount" * -1;
                        CommissionEntry2."Account No." := CustLedg."Customer No.";
                        CommissionEntry2."Commission Rate" := SalesSetup."Commission Chargeback Rate";
                        CommissionEntry2.Insert;
                    until CustLedg.Next = 0;
            end;

            trigger OnPreDataItem()
            begin

                LastFieldNo := FieldNo("Salesperson Code");
                SalesSetup.Get();
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Commission From "; FromDate)
                {
                    ApplicationArea = All;
                }
                field("Commission To"; ToDate)
                {
                    ApplicationArea = All;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        if (FromDate = 0D) or
          (ToDate = 0D) then
            Error(Text001);
        CompanyInfo.Get;
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        FromDate: Date;
        ToDate: Date;
        DetCustLedg: Record "Detailed Cust. Ledg. Entry";
        SalesPurchperson: Record "Salesperson/Purchaser";
        CommAmt: Decimal;
        CompanyInfo: Record "Company Information";
        TotalSales: Decimal;
        TotalPayment: Decimal;
        TotalCommission: Decimal;
        TotCustPayment: Decimal;
        TotCustCommission: Decimal;
        CommissionEntry: Record "Commission Entry Buffer" temporary;
        AmountCollected: Decimal;
        AmtSubjecttoComm: Decimal;
        NoOfRec: Integer;
        TotalAmtExclGCT: Decimal;
        TotalSubjToComm: Decimal;
        TotalNetSales: Decimal;
        TotalCommissionable: Decimal;
        SalesSetup: Record "Sales & Receivables Setup";
        CommExcpt: Record "Commission Exception Buffer";
        CustLedgEntry: Record "Cust. Ledger Entry";
        CommissionEntry2: Record "Commission Entry Buffer" temporary;
        CustLedg: Record "Cust. Ledger Entry";
        EntryNo2: Integer;
        NoOfRec2: Integer;
        ZeroComm: Boolean;
        Summary: Boolean;
        AmtSubj: Decimal;
        AmtNotSubj: Decimal;
        AmountCollected2: Decimal;
        TotalCollected: Decimal;
        TotalAmtCollected: Decimal;
        TotalPmtOver: Decimal;
        TotalPmtUnder: Decimal;
        GtotOver: Decimal;
        GtotUnder: Decimal;
        TotalAmtCollected2: Decimal;
        Current: Decimal;
        Net60Days: Decimal;
        GtotCurrent: Decimal;
        NetAmountCollected: Decimal;
        NetAmtSubjecttoComm: Decimal;
        Text001: Label 'Your must enter a valid Date Range before running this report';
}

