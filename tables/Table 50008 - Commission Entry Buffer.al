table 50008 "Commission Entry Buffer"
{

    fields
    {
        field(1;"Entry No.";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2;"Entry Type";Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output;
        }
        field(3;"Dimension Value";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4;Amount;Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5;"Commission Rate";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6;"Document No.";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7;"Account No.";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8;"Comm Excpt Text";Text[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Entry No.")
        {
        }
    }

    fieldgroups
    {
    }
}

