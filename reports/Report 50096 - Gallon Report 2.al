report 50096 "Item Sales by Gallon"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Gallon Report 2.rdlc';
    ApplicationArea = Basic, Suite, "Sales & Marketing";
    Caption = 'Item Sales by Gallon';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            CalcFields = "Sales Amount (Actual)";
            DataItemTableView = SORTING("Location Code", "Global Dimension 2 Code", "Item No.") WHERE("Entry Type" = FILTER(Sale));
            RequestFilterFields = "Location Code", "Global Dimension 2 Code", "Item No.", "Posting Date";
            column(LocationCode; "Location Code")
            {
            }
            column(ProdGroup; "Global Dimension 2 Code")
            {
            }
            column(ItemNo; "Item No.")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(EntryType; "Entry Type")
            {
            }
            column(QtyGallon; QtybyProdGrp)
            {
            }
            column(UnitOfMeas; "Unit of Measure Code")
            {
            }
            column(SalesAmount; "Sales Amount (Actual)")
            {
            }
            column(Description; Item.Description)
            {
            }
            column(Quantity; Quantity)
            {
            }

            trigger OnAfterGetRecord()
            var
                SalesInvHdr: Record "Sales Invoice Header";
                SalesCrMemoHdr: Record "Sales Cr.Memo Header";
                SalesShpHdr: Record "Sales Shipment Header";
            begin


                Clear(UnitOfMeas);
                if "Item No." <> Item."No." then begin
                    PKSize := 0;
                    Clear(Item);
                    if Item.Get("Item No.") then;
                    if UnitOfMeas.Get(Item."Base Unit of Measure") then
                        PKSize := UnitOfMeas."Gallon UOM";
                end;

                if UnitOfMeas.Get("Unit of Measure Code") then
                    CvtQty := Quantity * PKSize;

                QtybyProdGrp := CvtQty;

            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        TotalFor: Label 'Total for ';
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        Item: Record Item;
        UnitOfMeas: Record "Unit of Measure";
        CvtQty: Decimal;
        QtybyItemGrp: Decimal;
        QtybyProdGrp: Decimal;
        QtybyLocGrp: Decimal;
        TotQtybyProdGrp: Decimal;
        PKSize: Decimal;
        FilterString: Text[250];
}

