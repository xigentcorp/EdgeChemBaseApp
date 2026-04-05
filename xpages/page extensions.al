pageextension 50022 pgExtLocationList extends "Location List"
{
    layout
    {
        addafter(Name)

        {
            field("Store Dimension"; rec."Store Dimension")
            {
                ApplicationArea = All;
            }
            field("Bal. Account Type"; rec."Bal. Account Type")

            {
                ApplicationArea = All;
            }
            field("Bal. Account No."; rec."Bal. Account No.")
            {
                ApplicationArea = All;
            }

            field("Last Document No."; rec."Last Document No.")
            {
                ApplicationArea = All;
            }
            field("Last Payment Entry No."; rec."Last Payment Entry No.")
            {
                ApplicationArea = All;
            }
            field("Last Refund Payment Entry No."; rec."Last Refund Payment Entry No.")
            {
                ApplicationArea = All;
            }
        }

    }
}

pageextension 50002 pgExtCustomerCard extends "Customer Card"
{
    layout
    {
        addafter("Disable Search by Name")

        {

            field("POS Cust ID"; rec."POS Cust ID")

            {
                Editable = false;
                ApplicationArea = All;
            }
            field("POS Default"; rec."POS Default")
            {
                ApplicationArea = All;
            }
        }
        addafter("Salesperson Code")
        {

            field("Commission Exception"; rec."Commission Exception")
            {
                ApplicationArea = All;
            }

        }
    }
}


pageextension 50023 pgExtCustomerList extends "Customer List"
{
    layout
    {
        addafter("No.")

        {

            field("POS Cust ID"; rec."POS Cust ID")

            {
                Editable = false;
                ApplicationArea = All;
            }
            field("POS Default"; rec."POS Default")
            {
                ApplicationArea = All;
            }
        }
        addafter("Salesperson Code")
        {

            field("Commission Exception"; rec."Commission Exception")
            {
                ApplicationArea = All;
            }

        }
    }
}


pageextension 50003 pgExtCustomerLedger extends "Customer Ledger Entries"
{
    layout
    {
        addafter("Bal. Account No.")

        {

            field("POS Transaction"; rec."POS Transaction")

            {
                ApplicationArea = All;
            }
            field(NSF; rec.NSF)
            {
                ApplicationArea = All;
            }

            field("POS Entry No."; rec."POS Entry No.")
            {
                ApplicationArea = All;
            }

        }
    }
}


pageextension 50005 pgExtItemCard extends "Item Card"
{

    layout
    {
        addafter("Costs & Posting")

        {

            group("Point Of Sale")

            {

                field("POS Item ID"; rec."POS Item ID")

                {
                    Editable = false;
                    ApplicationArea = All;
                }

                field(Ingredient; rec.Ingredient)

                {
                    ApplicationArea = All;
                }


                field("POS Enabled"; rec."POS Enabled")

                {
                    ApplicationArea = All;
                }

                field("Allow Returns"; rec."Allow Returns")

                {
                    ApplicationArea = All;
                }

            }

            field("Global Dimension 2 Code"; rec."Global Dimension 2 Code")
            {
                ApplicationArea = All;

            }
        }
    }
}
pageextension 50024 pgExtItemList extends "Item List"
{
    layout
    {
        addafter("No.")

        {


            field("POS Item ID"; rec."POS Item ID")

            {
                Editable = false;
                ApplicationArea = All;
            }

            field(Ingredient; rec.Ingredient)

            {
                ApplicationArea = All;
            }


            field("POS Enabled"; rec."POS Enabled")

            {
                ApplicationArea = All;
            }

            field("Allow Returns"; rec."Allow Returns")

            {
                ApplicationArea = All;
            }


            field("Global Dimension 2 Code"; rec."Global Dimension 2 Code")
            {
                ApplicationArea = All;

            }
        }
    }
}


pageextension 50006 pgExtItemLedgerEntry extends "Item Ledger Entries"
{
    layout
    {
        addafter("Entry No.")

        {


            field("POS Transaction"; rec."POS Transaction")

            {
                ApplicationArea = All;
            }

            field("POS Entry No."; rec."POS Entry No.")

            {
                ApplicationArea = All;
            }
        }
    }
}


pageextension 50057 pgExtSalesQuote extends "Sales Quote"
{

    actions
    {

        addafter(MakeOrder)
        {

            action("MakeBlanketOrder")
            {
                ApplicationArea = Suite;
                Caption = 'Make Blanket Order';
                Image = MakeOrder;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction();
                var
                    ccuMgt: codeunit "Custom Codeunit Management";
                begin
                    ccuMgt.CreateBlanketOrderYesNo(Rec);
                end;

            }

        }
    }

}


pageextension 50007 pgExtSalesOrderHdr extends "Sales Order"
{

    layout
    {

        addafter(Status)

        {

            field("Reason Code"; rec."Reason Code")
            {
                ApplicationArea = All;
            }

            field("POS Transaction"; rec."POS Transaction")

            {
                Editable = false;
                ApplicationArea = All;
            }

            field("Over Limit"; rec."Over Limit")

            {
                Editable = False;
                ApplicationArea = All;
            }



        }
    }
}



pageextension 50025 pgExtSalesInvoiceHdr extends "Sales Invoice"
{

    layout
    {
        addafter(Status)

        {

            field("POS Transaction"; rec."POS Transaction")

            {
                Editable = false;
                ApplicationArea = All;
            }

            field("Over Limit"; rec."Over Limit")

            {
                Editable = False;
                ApplicationArea = All;
            }

        }
    }
}



pageextension 50026 pgExtSalesCrMemoHdr extends "Sales Credit Memo"
{

    layout
    {
        addafter(Status)

        {

            field("POS Transaction"; rec."POS Transaction")

            {
                Editable = false;
                ApplicationArea = All;
            }

        }

    }

    actions
    {
        // Adds the action called "My Actions" to the Action menu 


        addafter("CancelApprovalRequest")
        {
            action("Reassign Request")
            {
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    Message('Hello World');
                end;
            }
        }

    }
}

pageextension 50029 pgExtPurchOrderHdr extends "Purchase Order"
{

    layout
    {
        addafter("Buy-from Contact")

        {

            field("Phone No."; rec."Phone No.")

            {
                ApplicationArea = All;
            }

            field("Fax No."; rec."Fax No.")

            {
                Editable = False;
                ApplicationArea = All;
            }

        }
    }
}

pageextension 50032 pgExtPostedSalesShptHdr extends "Posted Sales Shipment"
{

    layout
    {
        addafter("Responsibility Center")

        {

            field("POS Transaction"; rec."POS Transaction")

            {
                ApplicationArea = All;
            }

        }
    }
}


pageextension 50033 pgExtPostedSalesInvoHdr extends "Posted Sales Invoice"
{

    layout
    {
        addafter("Responsibility Center")

        {

            field("POS Transaction"; rec."POS Transaction")

            {
                ApplicationArea = All;
            }


        }
    }
}

pageextension 50034 pgExtPostedSalesCrMemoHdr extends "Posted Sales Credit Memo"
{

    layout
    {
        addafter("Responsibility Center")

        {

            field("POS Transaction"; rec."POS Transaction")

            {
                Editable = false;
                ApplicationArea = All;
            }


        }
    }
}

pageextension 50040 pgExtUnitOfMeasure extends "Units of Measure"
{
    layout
    {
        addafter("Code")

        {

            field("Gallon UOM"; rec."Gallon UOM")
            {
                ApplicationArea = All;
            }

        }

    }
}

pageextension 50030 pgExtCashRecptJnl extends "Cash Receipt Journal"
{
    layout
    {
        addafter("Document No.")

        {

            field("POS Transaction"; rec."POS Transaction")

            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Location Code"; rec."Location Code")
            {
                Editable = false;
                ApplicationArea = All;
            }

            field(NSF; rec.NSF)
            {
                ApplicationArea = All;
            }

        }

    }
}



pageextension 50039 pgExtJnlBatch extends "Item Journal Batches"
{
    layout
    {
        addafter("Reason Code")

        {

            field("Gen. Bus. Posting Group"; rec."Gen. Bus. Posting Group")

            {

                ApplicationArea = All;
            }

        }

    }
}


pageextension 50035 pgExtSalesRecvSetup extends "Sales & Receivables Setup"
{
    layout
    {

        addafter("General")

        {

            group("Point Of Sale")

            {

                field("CutOff Period"; rec."CutOff Period")

                {
                    ApplicationArea = All;
                }
                field("Commission Chargeback Rate"; rec."Commission Chargeback Rate")
                {
                    ApplicationArea = All;
                }

                field("Cash Receipt Journal Name"; rec."Cash Receipt Journal Name")
                {
                    ApplicationArea = All;
                }
                field("POS Jnl. Name"; rec."POS Jnl. Name")
                {
                    ApplicationArea = All;
                }

                field("Default Tax Code"; rec."Default Tax Code")
                {
                    ApplicationArea = All;
                }

                field("POS Rounding Account"; rec."POS Rounding Account")
                {
                    ApplicationArea = All;
                }
            }

        }
    }
}


pageextension 50036 pgExtInventorySetup extends "Inventory Setup"
{

    layout
    {
        addafter("Item Group Dimension Code")

        {


            field("Transfer Gen. Bus. Group"; rec."Transfer Gen. Bus. Group")

            {
                ApplicationArea = All;
            }
        }
    }
}

pageextension 50038 pgExtDimensionValue extends "Dimension Values"
{
    layout
    {
        addafter("Name")

        {

            field("Commission Rate"; rec."Commission Rate")

            {

                ApplicationArea = All;
            }

        }
    }
}

pageextension 50045 pgExtApprovalEntries extends "Approval Entries"
{
    layout
    {
        addafter("Amount (LCY)")

        {
            field("Bal. On Order"; rec."Bal. On Order")

            {
                ApplicationArea = All;
            }
        }
    }
}


pageextension 50001 pgExtSalespersonCard extends "Salesperson/Purchaser Card"
{
    layout
    {
        // Add changes to page layout here
        addafter("Commission %")
        {

            field("Commission Exception"; rec."Commission Exception")
            {
                ApplicationArea = All;
            }


        }


    }
}

pageextension 50037 pgExtItemUnit extends "Item Units of Measure"
{
    layout
    {
        addafter("Code")

        {
            field(Ingredient; rec.Ingredient)

            {
                ApplicationArea = All;
            }

        }
    }
}


pageextension 50000 pgExtLocation extends "Location Card"
{
    layout
    {
        addafter("Bin Policies")

        {

            group("Point Of Sale")

            {
                field("Store Dimension"; rec."Store Dimension")
                {
                    Caption = 'Business Unit';
                    ApplicationArea = All;
                }

                field("Posted Invoice No. Series"; rec."Posted Invoice No. Series")
                {
                    ApplicationArea = All;
                }

                field("Posted Cr. Memo No. Series"; rec."Posted Cr. Memo No. Series")
                {
                    ApplicationArea = All;
                }

                field("Bal. Account Type"; rec."Bal. Account Type")

                {
                    ApplicationArea = All;
                }
                field("Bal. Account No."; rec."Bal. Account No.")
                {
                    ApplicationArea = All;
                }

                field("Last Document No."; rec."Last Document No.")
                {
                    ApplicationArea = All;
                }
                field("Last Payment Entry No."; rec."Last Payment Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Last Refund Payment Entry No."; rec."Last Refund Payment Entry No.")
                {
                    ApplicationArea = All;
                }
            }

        }
    }
}


pageextension 50042 pgExtTransferOrderLine extends "Transfer Order Subform"
{
    layout
    {
        addafter(Description)

        {
            field("Gen. Bus. Posting Group"; rec."Gen. Bus. Posting Group")

            {
                ApplicationArea = All;
            }
        }
    }
}


pageextension 50043 pgExtPostedTransShpmntLine extends "Posted Transfer Shpt. Subform"
{
    layout
    {
        addafter(Description)

        {
            field("Gen. Bus. Posting Group"; rec."Gen. Bus. Posting Group")

            {
                ApplicationArea = All;
            }
        }
    }
}

pageextension 50044 pgExtPostedTransRecptLine extends "Posted Transfer Rcpt. Subform"
{
    layout
    {
        addafter(Description)

        {
            field("Gen. Bus. Posting Group"; rec."Gen. Bus. Posting Group")

            {
                ApplicationArea = All;
            }
        }
    }
}

pageextension 50041 pgExtPurchasePrice extends "Purchase Prices"
{
    layout
    {
        addafter("item No.")

        {
            field(Description; rec.Description)

            {
                Editable = false;
                ApplicationArea = All;
            }
        }
    }
}

pageextension 50028 pgExtSalesOderList extends "Sales Order List"
{

    layout
    {
        addafter(Status)

        {

            field("POS Transaction"; rec."POS Transaction")

            {
                Editable = false;
                ApplicationArea = All;
            }


        }


    }
}

pageextension 50027 pgExtSalesInvList extends "Sales Invoice List"
{

    layout
    {
        addafter(Status)

        {

            field("POS Transaction"; rec."POS Transaction")

            {
                Editable = false;
                ApplicationArea = All;
            }


        }
    }
}

pageextension 50046 pgExtDepositSubForm extends "Bank Deposit Subform"
{

    layout
    {
        addafter("Account No.")

        {

            field(NSF; rec.NSF)

            {
                ApplicationArea = All;
            }


        }
    }
}



pageextension 50050 pgSalesPriceWkShtExt extends "Sales Price Worksheet"
{

    actions
    {

        addafter("Suggest &Item Price on Wksh.")
        {

            action(ImportSalesPrice)
            {
                // ApplicationArea = Suite;
                Caption = 'Import Sales Prices';
                Image = Import;
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                PromotedCategory = Process;

                trigger OnAction();
                var
                    SalesPriceImport: XmlPort "Import Sales Prices";
                begin
                    Clear(SalesPriceImport);
                    SalesPriceImport.Run;
                    CurrPage.Update();
                end;

            }



        }
    }



}

