tableextension 50036 tabDepositHeaderExt extends "Bank Deposit Header"
{
    fields
    {
        field(50000; "POS Bank Account"; Code[20])
        {
            Caption = 'POS Bank Account';
            TableRelation = "Bank Account"."No.";
        }
    }

}


// version NAVW114.00,NAVNA14.00
tableextension 50013 tabSalesShipmentHeaderExt extends "Sales Shipment Header"
{
    fields
    {
        field(50000; "POS Transaction"; Boolean)
        {
            Caption = 'POS Transaction';
            Editable = false;
        }
        field(50001; "POS Entry No."; Text[40])
        {
            Caption = 'POS Entry No.';
            Editable = false;
        }
        field(50002; "POS Notes"; Text[40])
        {
            Caption = 'POS Notes';
            Editable = false;
        }
        field(50006; "No. of POS Sales Lines"; Integer)
        {
            Caption = 'No. of POS Sales Lines';
            Editable = false;
        }
    }
}
tableextension 50014 tabSalesShipmentLineExt extends "Sales Shipment Line"
{

    // version NAVW114.00,NAVNA14.00

    // POSi2.00 - Added fields 50000, 50001, 50002, 50003, 50004, and 50005
    // <changelog>
    //   <add id="NA0001" dev="ELYNCH" date="2006-02-09" area="ORDERENTRY" feature="607"
    //     releaseversion="NAVUS3.10.01">Added field, key and code for Package Tracking</add>
    // </changelog>

    fields
    {
        field(50000; "POS Transaction"; Boolean)
        {
            Editable = false;
        }
        field(50001; "POS Entry No."; Text[40])
        {
            Editable = false;
        }
    }

}

tableextension 50015 tabSalesInvoiceHeaderExt extends "Sales Invoice Header"
{
    // version NAVW114.00,NAVNA14.00


    fields
    {
        field(50000; "POS Transaction"; Boolean)
        {
            Caption = 'POS Transaction';
            Editable = false;
        }
        field(50001; "POS Entry No."; Text[40])
        {
            Caption = 'POS Entry';
            Editable = false;
        }
        field(50002; "POS Notes"; Text[40])
        {
            Caption = 'POS Notes';
            Editable = false;
        }
        field(50003; "POS Total Including VAT"; Decimal)
        {
            Caption = 'POS Total Including VAT';
            Editable = false;
        }
        field(50005; "Payment Collected"; Decimal)
        {
            Caption = 'Payment Collected';
        }
        field(50006; "No. of POS Sales Lines"; Integer)
        {
            Caption = 'No. of POS Sales Lines';
            Editable = false;
        }

    }
}

tableextension 50016 tabSalesInvoiceLineExt extends "Sales Invoice Line"
{
    // version NAVW114.00,NAVNA14.00

    // POSi2.00 - Added fields 50000, 50001, 50002, 50003, 50004, and 50005
    // <changelog>
    //   <add id="NA0001" dev="ELYNCH" date="2006-02-09" area="ORDERENTRY" feature="607"
    //     releaseversion="NAVUS3.01">Added field for Package Tracking</add>
    // </changelog>
    fields
    {

        field(50000; "POS Transaction"; Boolean)
        {
            Caption = 'POS Transaction';
            Editable = false;
        }
        field(50001; "POS Entry No."; Text[40])
        {
            Caption = 'POS Entry No.';
            Editable = false;
        }
        field(50002; "POS Notes"; Text[40])
        {
            Caption = 'POS Notes';
            Editable = false;
        }
        field(50003; "Payment Method Code"; Code[20])
        {
            Caption = 'Payment Method Codwe';
            Editable = false;
        }
        field(50004; "Discount Reason"; Text[50])
        {
            Caption = 'Discount Reason';
            Editable = false;
        }
        field(50005; "Return Reason"; Text[50])
        {
            Caption = 'Return Reason';
            Editable = false;
        }
    }

}

tableextension 50017 tabSalesCrMemoHeaderExt extends "Sales Cr.Memo Header"
{
    // version NAVW114.00,NAVNA14.00

    fields
    {
        field(50000; "POS Transaction"; Boolean)
        {
            Caption = 'POS Transaction';
            Editable = false;
        }
        field(50001; "POS Entry No."; Text[40])
        {
            Caption = 'POS Entry No.';
            Editable = false;
        }
        field(50002; "POS Notes"; Text[40])
        {
            Caption = 'POS Notes';
            Editable = false;
        }
        field(50003; "POS Total Including VAT"; Decimal)
        {
            Caption = 'POS TOtal Including VAT';
            Editable = false;
        }
        field(50005; "Payment Refunded"; Decimal)
        {
            Caption = 'Payment Refund';
        }
        field(50006; "No. of POS Sales Lines"; Integer)
        {
            Caption = 'No of POS Sales Lines';
            Editable = false;
        }
    }

}



tableextension 50018 tabSalesCrMemoLineExt extends "Sales Cr.Memo Line"
{
    // version NAVW114.00,NAVNA14.00

    fields
    {
        field(50000; "POS Transaction"; Boolean)
        {
            Caption = 'POS Traznsaction';
            Editable = false;
        }
        field(50001; "POS Entry No."; Text[40])
        {
            Caption = 'POS Entry No.';
            Editable = false;
        }
        field(50002; "POS Notes"; Text[40])
        {
            Caption = 'POS Notes';
            Editable = false;
        }
        field(50003; "Payment Method Code"; Code[20])
        {
            Caption = 'Payment Method Code';
            Editable = false;
        }
        field(50004; "Discount Reason"; Text[50])
        {
            Caption = 'Discount Reason';
            Editable = false;
        }
        field(50005; "Return Reason"; Text[50])
        {
            Caption = 'Return Reason';
            Editable = false;
        }
    }
}
tableextension 50019 tabPurchRecptHeaderExt extends "Purch. Rcpt. Header"
{
    // version NAVW114.00,NAVNA14.00

    fields
    {

        field(50000; "POS Transaction"; Boolean)
        {
            Caption = 'POS Trasnsaction';
        }
    }

}


tableextension 50020 tabPurchRcptineExt extends "Purch. Rcpt. Line"
{
    // version NAVW114.00

    fields
    {
        field(50000; "POS Transaction"; Boolean)
        {
            Caption = 'POS Transaction';
        }
    }

}
tableextension 50021 tabPurchInvHeaderExt extends "Purch. Inv. Header"
{
    // version NAVW114.00,NAVNA14.00

    fields
    {
        field(50000; "POS Transaction"; Boolean)
        {
            Caption = 'POS Transaction';
        }
    }

}

tableextension 50022 tabPurchInvLineExt extends "Purch. Inv. Line"
{
    // version NAVW114.00,NAVNA14.00

    fields
    {

        field(50000; "POS Transaction"; Boolean)
        {
            Caption = 'POS Description';
        }
    }

}
tableextension 50023 tabPurchCrMemoHeaderExt extends "Purch. Cr. Memo Hdr."
{
    // version NAVW114.00,NAVNA14.00

    fields
    {
        field(50000; "POS Transaction"; Boolean)
        {
            Caption = 'POS Transaction';
        }
    }
}


tableextension 50024 tabPurchCrMemoLineExt extends "Purch. Cr. Memo Line"

{
    // version NAVW114.00,NAVNA14.00
    fields
    {
        field(50000; "POS Transaction"; Boolean)
        {
            Caption = 'POS Transaction';
        }
    }

}

tableextension 50001 tabSalespersonExt extends "Salesperson/Purchaser"
{
    fields
    {


        // POSi2.00 Modifications OnInsert(), OnModify(), OnDelete(), OnRename()

        field(50000; "Commission Exception"; Boolean)
        {
            Caption = 'Commission Exception';
        }
    }


}

tableextension 50000 tabLocationExt extends Location
{
    fields
    {
        // version NAVW114.00,NAVNA14.00
        field(50000; "Store Dimension"; Code[10])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50001; "Posted Invoice No. Series"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50002; "Posted Cr. Memo No. Series"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50003; "Bal. Account No."; Code[20])
        {
            TableRelation = IF ("Bal. Account Type" = CONST("G/L Account")) "G/L Account"
            ELSE
            IF ("Bal. Account Type" = CONST("Bank Account")) "Bank Account";
        }
        field(50004; "Bal. Account Type"; Option)
        {
            OptionCaption = 'G/L Account,Bank Account';
            OptionMembers = "G/L Account","Bank Account";
        }
        field(50005; "POSI Connection"; Text[250])
        {
        }
        field(50006; "Last Document No."; Code[50])
        {
        }
        field(50007; "Last Payment Entry No."; Code[50])
        {
        }
        field(50008; "Last Refund Document No."; Code[50])
        {
        }
        field(50009; "Last Refund Payment Entry No."; Code[50])
        {
        }
    }
}
tableextension 50002 tabCustomerExt extends Customer
{
    fields
    {
        field(50001; "Commission Exception"; Boolean)
        {
            Caption = 'Commision Exception';
        }
        field(50002; "POS Default"; Boolean)
        {
            Caption = 'POS DEfault';
        }
        field(50003; "POS Cust ID"; BigInteger)
        {
            Caption = 'POS Cust ID';
            //AutoIncrement = true;
        }

    }

}


tableextension 50025 tabUnitOfMeasExt extends "Unit of Measure"

{
    // version NAVW114.00,NAVNA14.00

    fields
    {

        field(50000; "Gallon UOM"; Decimal)
        {
            Caption = 'Gal. Unit OF Meas.';
        }
    }
}


tableextension 50003 tabCustLedgerEntryExt extends "Cust. Ledger Entry"
{
    // version NAVW114.00,NAVNA14.00

    fields
    {
        field(50000; "POS Transaction"; Boolean)
        {
            Caption = 'POS Transaction';
        }
        field(50001; "POS Entry No."; Text[40])
        {
            Caption = 'POS Entry No.';
        }

        field(50002; NSF; Boolean)
        {
            Caption = 'NSF';
        }
        field(50003; "Aged Recv Date"; Date)
        {
            Caption = 'Aged Recv Date';
        }
        field(50004; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
        }
    }

}



tableextension 50026 tabItemJnlBatchExt extends "Item Journal Batch"
{
    // version NAVW114.00


    fields
    {
        field(50000; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group".Code;
        }
    }

}

tableextension 50005 tabItemExt extends Item
{
    // version NAVW114.00,NAVNA14.00

    // POSi2.00 Modifications OnInsert(), OnModify(), OnDelete(), OnRename()
    // POSi2.00 - Added field 50003
    // <changelog>
    //   <add id="NA0001" dev="JNOZZI" date="2006-03-01" area="REPORTS IC" feature="615"
    //     releaseversion="NAVNA4.00.01">Add Flowfields to be used in Inventory Reports, related to Manufacturing. Add
    //     Duty Class field.</add>
    // </changelog>

    fields
    {
        field(50000; "POS Item ID"; BigInteger)
        {
            Caption = 'POS Item ID';
            //AutoIncrement = true;
        }
        field(50002; "POS Enabled"; Boolean)
        {
            Caption = 'POS Enabled';
        }
        field(50003; "Allow Returns"; Boolean)
        {
            Caption = 'Allow Returns';
        }
        field(50004; Ingredient; Boolean)
        {
            Caption = 'Ingredents';
        }
    }

}





tableextension 50027 tabSalesandReceivableExt extends "Sales & Receivables Setup"
{
    // version NAVW114.00,NAVNA14.00


    fields
    {
        field(50000; "CutOff Period"; Integer)
        {
            Caption = 'CutOff Period';
        }
        field(50001; "Commission Chargeback Rate"; Decimal)
        {
            Caption = 'Commission Chargeback Rate';
        }
        field(50002; "Cash Receipt Journal Name"; Code[20])
        {
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = CONST('CASH RECEI'));
            Caption = 'Cash Receipt Journal Name';
        }
        field(50003; "POS Jnl. Name"; code[20])
        {
            Caption = 'POS Jnl. Nazme';
            TableRelation = "Gen. Journal Template".Name;
        }
        field(50004; "POS Jnl. Batch Name"; Code[20])
        {
            Caption = 'POS Jnl. Batch Name';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = field("POS Jnl. Name"));

        }
        field(50005; "Default Tax Code"; Code[20])
        {
            Caption = 'POS Jnl. Batch Name';

            TableRelation = "Tax Group".Code;
        }
        field(50006; "POS Rounding Account"; Code[20])
        {
            Caption = 'POS Rounding Account';
            TableRelation = "G/L Account"."No.";
        }
    }

}
tableextension 50028 tabInvenotrySetupExt extends "Inventory Setup"
{
    // version NAVW114.00

    fields
    {

        field(50000; "Transfer Gen. Bus. Group"; Code[10])
        {
            TableRelation = "Gen. Business Posting Group".Code;
        }
    }

}


tableextension 50006 tabItemLedgentryExt extends "Item Ledger Entry"
{
    fields
    {
        // version NAVW114.00,NAVNA14.00

        field(50000; "POS Transaction"; Boolean)
        {
            Caption = 'POS transaction';
        }
        field(50001; "POS Entry No."; Text[40])
        {
            Caption = 'POS Entry No.';
        }
    }
}


tableextension 50029 tabDimensionValueExt extends "Dimension Value"
{
    // version NAVW113.00

    fields
    {
        field(50000; "Commission Rate"; Decimal)
        {
            Caption = 'Commission Rate';
        }
    }


}


tableextension 50007 tabSalesHeaderExt extends "Sales Header"
{



    // version NAVW114.00,NAVNA14.00

    // POSi2.00 - Added fields 50000, 50001, and 50002
    // Initials    Date      Comments
    // =======================================================================================
    // MSC       08/26/11    Prevent users from entering transactions against the designated POS account
    // <changelog>
    //   <add id="NA0001" dev="ELYNCH" date="2004-03-26" area="NASALESTAX" feature="617"
    //     releaseversion="NAVUS3.70.00.44">Added field and code for NA Sales Tax</add>
    // #4..12
    //   <change id="NA0008" dev="ELYNCH" date="2008-05-14" area="NASALESTAX" feature="36490"
    //     baseversion="NAVNA5.00.02" releaseversion="NAVNA6.00">Tax Exemption No. was not populated from cust.</change>
    // </changelog>
    fields
    {

        field(50000; "POS Transaction"; Boolean)
        {
            Caption = 'POS Transaction';
            Editable = false;
        }
        field(50001; "POS Entry No."; Text[40])
        {
            Caption = 'POS Entry';
            Editable = false;
        }
        field(50002; "POS Notes"; Text[40])
        {
            Caption = 'POS Notes';
            Editable = false;
        }
        field(50003; "POS Total Including VAT"; Decimal)
        {
            Caption = 'POS Total Invluding VAT';
            Editable = false;
        }
        field(50004; "Over Limit"; Boolean)
        {
            Caption = 'Over Limit';
            trigger OnValidate();
            begin
                /*IF UserSetup.GET(USERID) THEN
                  BEGIN
                    IF NOT UserSetup."Credit Approval" THEN
                      ERROR(Text50000);
                  END ELSE BEGIN
                     ERROR(Text50000);
                  END;
                 */// MSCC TEMP

            end;
        }
        field(50005; "Payment Collected"; Decimal)
        {
            Caption = 'Payment Collected';
        }
        field(50006; "No. of POS Sales Lines"; Integer)
        {
            Caption = 'No. of POS Sales Lines';
            Editable = false;
        }

        field(50010; "Credit Hold Description"; Text[60])
        {
            Caption = 'Credit Hold Desc';
        }
    }


}

tableextension 50008 tabSalesLineExt extends "Sales Line"
{

    fields
    {
        // version NAVW114.00,NAVNA14.00

        // POSi2.00 - Added fields 50000, 50001, 50002, 50003, 50004, and 50005
        // <changelog>
        //   <add id="NA0001" dev="ELYNCH" date="2006-02-10" area="NASALESTAX" feature="617"
        //     releaseversion="NAVUS3.70.01">Added functions and code for NA Sales Tax</add>
        // #4..19
        //     You can get an error saying "You must reopen the document since this will affect Sales Tax"
        //     when creating a Sales Line in NA even though the order is open</change>
        // </changelog>

        field(50000; "POS Transaction"; Boolean)
        {
            Caption = 'POS Transaction';
            Editable = false;
        }
        field(50001; "POS Entry No."; Text[40])
        {
            Caption = 'POS Entry No.';
            Editable = false;
        }
        field(50008; "Parent Line No."; Code[50])
        {
            Caption = 'Parent Line No.';
        }
    }

}
tableextension 50009 tabPurhaseHeaderExt extends "Purchase Header"
{
    // version NAVW114.00,NAVNA14.00

    // POSi2.00 - Added field 50000
    // <changelog>
    //   <add id="NA0000" dev="ELYNCH" date="2006-03-24" area="1099" feature="601"
    //     releaseversion="NAVUS3.70.00.27">Added field 10020</add>
    // #4..22
    //     baseversion="NA5.00.01" releaseversion="NA7.00"> Tax Liable on the Purchase line
    //     is no longer updated automatically with 2009 SP1 when the header field is changed </change>
    // </changelog>

    fields
    {
        field(50001; "Phone No."; Code[20])
        {
            Caption = 'Phone No.';
        }
        field(50002; "Fax No."; Code[20])
        {
            Caption = 'Fax No.';
        }
    }

}

tableextension 50010 tabPurchaseLineExt extends "Purchase Line"
{
    fields
    {
        field(50001; "Alternate Item No."; Code[20])
        {
            Caption = 'Alternate Item No.';
        }
    }

}
tableextension 50030 tabApprovalEntryExt extends "Approval entry"
{
    // version NAVW114.00

    fields
    {

        field(50001; "Bal. On Order"; Decimal)
        {
            Caption = 'Bal. On Order';
        }
    }
}

tableextension 50037 tabInvtPostingBufferExt extends "Invt. Posting Buffer"
{
    fields
    {
        field(50001; "Description"; Code[50])
        {
            Caption = 'Description';
        }
    }

}
tableextension 50038 tabInvPostBufferExt extends "Invoice Post. Buffer"
{
    fields
    {
        field(50001; "Description"; Code[50])
        {
            Caption = 'Description';
        }
    }

}
tableextension 50031 tabItemUnitOFMeasExt extends "Item Unit of Measure"
{
    fields
    {
        field(50000; Ingredient; Boolean)
        {
            Caption = 'Ingredent';
        }
    }
}

tableextension 50032 tabTransferLineExt extends "Transfer Line"
{
    // version NAVW114.00

    fields
    {

        field(50000; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
        }
    }
}

tableextension 50033 tabTransferShipmentLineExt extends "Transfer Shipment Line"


{
    // version NAVW114.00

    fields
    {
        field(50000; "Gen. Bus. Posting Group"; Code[10])
        {

            Caption = 'Gen. Bus. Posting Group';

            TableRelation = "Gen. Business Posting Group";

        }
    }

}

tableextension 50034 tabTransferReceiptLineExt extends "Transfer Receipt Line"
{
    // version NAVW114.00

    fields
    {
        field(50000; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";


        }
    }

}


tableextension 50035 tabPurchasePriceExt extends "Purchase Price"

{
    // version NAVW114.00
    fields
    {
        field(50000; Description; Text[50])
        {
            Caption = 'Description';
        }
    }

}


tableextension 50011 tabGenJnlLineExt extends "Gen. Journal Line"
{

    // version NAVW114.00,NAVNA14.00

    fields
    {
        field(50000; "POS Transaction"; Boolean)
        {
            Caption = 'POS Transaction';
        }
        field(50001; "POS Entry No."; Text[40])
        {
            Caption = 'POS Entry No.';
        }
        field(50003; "Location Code"; Code[10])
        {
            Caption = 'Location Code';

        }
        field(50004; "Payment Type"; Code[15])
        {
            Caption = 'Payment Type';

        }
        field(50005; "Method of Payment"; Code[20])
        {
            Caption = 'Method of Payment';
        }
        field(50006; Comments; Text[30])
        {
            Caption = 'Comments';
        }
        field(50008; "Income/Balance"; Option)
        {
            Caption = 'Income/Balance';
            OptionMembers = "Income Statement","Balance Sheet";
        }
        field(50009; NSF; Boolean)
        {
            Caption = 'NSF';
        }
    }

}


tableextension 50012 tabItemJnlLineExt extends "Item Journal Line"
{


    fields
    {
        field(50000; "POS Transaction"; Boolean)
        {
            Caption = 'POS Transaction';
        }
        field(50001; "POS Entry No."; Text[40])
        {
            Caption = 'POS Entry No.';
        }
    }
}
