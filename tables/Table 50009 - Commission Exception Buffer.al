table 50009 "Commission Exception Buffer"
{

    fields
    {
        field(1;"Dimension Value";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Dimension Code"=FILTER('PRODGRP'));
        }
        field(2;"Commission Exception Type";Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Customer,Salesperson;
        }
        field(3;"Commission Exception Code";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF ("Commission Exception Type"=CONST(Customer)) Customer."No."
                            ELSE IF ("Commission Exception Type"=CONST(Salesperson)) "Salesperson/Purchaser".Code;
        }
        field(4;"Commission Exception Rate";Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Dimension Value")
        {
        }
    }

    fieldgroups
    {
    }
}

