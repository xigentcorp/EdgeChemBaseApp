xmlport 50029 "Import Sales Prices"
{
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Sales Price Worksheet"; "Sales Price Worksheet")
            {
                AutoSave = false;
                RequestFilterFields = "Item No.", "Sales Code", "Starting Date";
                RequestFilterHeading = 'Item No.,Sales Code,Starting Date';
                XmlName = 'SalesPrice';
                SourceTableView = SORTING("Item No.", "Sales Type", "Sales Code", "Starting Date", "Currency Code", "Variant Code", "Unit of Measure Code", "Minimum Quantity") ORDER(Ascending);
                UseTemporary = true;
                fieldattribute(ItemNo; "Sales Price Worksheet"."Item No.")
                {
                }
                fieldattribute(SalesCode; "Sales Price Worksheet"."Sales Code")
                {
                }
                fieldattribute(UnitPrice; "Sales Price Worksheet"."New Unit Price")
                {
                }
                fieldattribute(UnitOfMeas; "Sales Price Worksheet"."Unit of Measure Code")
                {
                }
                trigger OnPreXmlItem()
                begin
                    EVALUATE(StartDate, "Sales Price Worksheet".GETFILTER("Starting Date"));

                end;

                trigger OnAfterInsertRecord()
                begin
                    with "Sales Price Worksheet" do begin
                        if Item.Get("Item No.") then begin
                            SP.Init;
                            //Determine the Sales Type to use for the transaction type
                            if cpg.Get("Sales Code") then
                                SP."Sales Type" := SP."Sales Type"::"Customer Price Group";

                            if cust.Get("Sales Code") then
                                SP."Sales Type" := SP."Sales Type"::Customer;

                            if "Sales Code" = '' then
                                SP."Sales Type" := SP."Sales Type"::"All Customers";

                            sp2.Reset;
                            sp2.SetRange("Item No.", "Item No.");
                            sp2.SetRange("Sales Code", "Sales Code");
                            sp2.SetRange("Unit of Measure Code", "Unit of Measure Code");
                            if sp2.FindSet then
                                repeat
                                    if sp2."Ending Date" = 0D then begin
                                        sp2."Ending Date" := StartDate - 1;
                                        sp2.Modify;
                                    end;
                                until sp2.Next = 0;

                            SP."Sales Code" := "Sales Code";
                            SP."Item No." := "Item No.";
                            SP."Unit of Measure Code" := "Unit of Measure Code";
                            SP."Starting Date" := StartDate;
                            SP.Validate("New Unit Price", "New Unit Price");

                            SP.Insert(true);

                            if "Sales Code" = 'DIST' then begin
                                Item.Validate("Unit Price", "New Unit Price");
                                Item.Modify;
                            end;

                        end;
                    end;
                end;
            }
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


    trigger OnPreXmlPort()
    begin
        Evaluate(StartDate, "Sales Price Worksheet".GetFilter("Starting Date"));
    end;



    var
        Item: Record Item;
        SP: Record "Sales Price Worksheet";
        sp2: Record "Sales Price";
        cust: Record Customer;
        cpg: Record "Customer Price Group";

        StartDate: Date;

}

