//namespace Xigent.API.V2;   

//<Customer integration for on prem sql via power automate and data gateway>

page 50070 "apiCustomer"
{
    PageType = API;
    APIVersion = 'v3.0';
    APIPublisher = 'Xigent';
    APIGroup = 'Custom';
    EntityName = 'apicustomer';
    EntitySetName = 'apicustomer';
    DelayedInsert = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    EntityCaption = 'apicustomer';
    EntitySetCaption = 'Sync - POS Customers';
    ODataKeyFields = SystemId;
    SourceTable = "Customer";
    layout
    {
        area(Content)
        {
            repeater(group)
            {
                field(id; Rec.SystemId)
                {
                    Caption = 'Id';
                    Editable = false;
                }

                field(number; rec."No.")
                {
                    ApplicationArea = All;
                }
                field(displayname; rec.Name)
                {
                    ApplicationArea = All;
                }

                field(searchname; rec."Search Name")
                {
                    ApplicationArea = All;
                }
                field(address; rec."Address")
                {
                    ApplicationArea = All;
                }
                field(address2; rec."Address 2")
                {
                    ApplicationArea = All;
                }

                field(city; rec."City")
                {
                    ApplicationArea = All;
                }
                field(state; rec."County")
                {
                    ApplicationArea = All;
                }
                field(postcode; rec."Post Code")
                {
                    ApplicationArea = All;
                }
                field(contact; rec."Contact")
                {
                    ApplicationArea = All;
                }
                field(phoneno; rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field(creditlimitlcy; rec."Credit Limit (LCY)")
                {
                    ApplicationArea = All;
                }
                field(pricegroup; rec."Customer Price Group")
                {
                    ApplicationArea = All;
                }

                field(paymentterms; rec."Payment Terms Code")
                {
                    ApplicationArea = All;
                }

                field(salesperson; rec."Salesperson Code")
                {
                    ApplicationArea = All;
                }


                field(invdisccode; rec."Invoice Disc. Code")
                {
                    ApplicationArea = All;
                }

                field(discgroupcode; rec."Customer Disc. Group")
                {
                    ApplicationArea = All;
                }

                field(countryregion; rec."Country/Region Code")
                {
                    ApplicationArea = All;
                }

                field(blocked; rec."Blocked")
                {
                    ApplicationArea = All;
                }
                field(lastdatemodified; rec."Last Date Modified")
                {
                    ApplicationArea = All;
                }
                field(locationcoe; rec."Location Code")
                {
                    ApplicationArea = All;
                }

                field(faxno; rec."Fax No.")
                {
                    ApplicationArea = All;
                }

                field(vatregno; rec."VAT Registration No.")
                {
                    ApplicationArea = All;
                }

                field(taxexemption; rec."Tax Exemption No.")
                {
                    ApplicationArea = All;
                }
                field(email; rec."E-Mail")
                {
                    ApplicationArea = All;
                }
                field(taxliable; rec."Tax Liable")
                {
                    ApplicationArea = All;
                }
                field(vatpostgroup; rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field(primarycontactno; rec."Primary Contact No.")
                {
                    ApplicationArea = All;
                }
                field(poscustid; rec."POS Cust ID")
                {
                    ApplicationArea = All;
                }
                field(posdefault; rec."POS Default")
                {
                    ApplicationArea = All;
                }



            }

        }

    }

}



page 50071 "apiItem"
{
    APIVersion = 'v3.0';
    ChangeTrackingAllowed = true;
    DelayedInsert = true;
    DeleteAllowed = false;
    Editable = false;
    EntityName = 'apiitems';
    EntitySetName = 'apiitems';
    InsertAllowed = true;
    ModifyAllowed = true;
    ODataKeyFields = SystemId;
    APIPublisher = 'Xigent';
    APIGroup = 'Custom';
    PageType = API;
    EntityCaption = 'apiitems';
    EntitySetCaption = 'Sync - POS Items';

    SourceTable = Item;
    Extensible = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(id; rec.SystemId)
                {
                    ApplicationArea = All;
                }
                field(number; rec."No.")
                {
                    ApplicationArea = All;
                }
                field(displayname; rec.Description)
                {
                    ApplicationArea = All;
                }
                field(searchdescription; rec."Search Description")
                {
                    ApplicationArea = All;
                }
                field(baseunit; rec."Base Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field(discgroup; rec."Item Disc. Group")
                {
                    ApplicationArea = All;
                }
                field(allowinvdisc; rec."Allow Invoice Disc.")
                {
                    ApplicationArea = All;
                }
                field(unitprice; rec."Unit Price")
                {
                    ApplicationArea = All;
                }

                field(dunitcost; rec."Unit Cost")
                {
                    ApplicationArea = All;
                }

                field(leadtimecale; rec."Lead Time Calculation")
                {
                    ApplicationArea = All;
                }

                field(reorderpt; rec."Reorder Point")
                {
                    ApplicationArea = All;
                }

                field(reorderqty; rec."Reorder Quantity")
                {
                    ApplicationArea = All;
                }


                field(altnumber; rec."Alternative Item No.")
                {
                    ApplicationArea = All;
                }

                field(blocked; rec.Blocked)
                {
                    ApplicationArea = All;
                }

                field("lastdatemodified"; rec."Last DateTime Modified")
                {
                    ApplicationArea = All;
                }

                field(priceinclvat; rec."Price Includes VAT")
                {
                    ApplicationArea = All;
                }
                field(vatpostgroup; rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = All;
                }

                field(dim2code; rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }

                field(category; rec."Item Category Code")
                {
                    ApplicationArea = All;
                }

                field(posenabled; rec."POS Enabled")
                {
                    ApplicationArea = All;
                }

                field(allowrtn; rec."Allow Returns")
                {
                    ApplicationArea = All;
                }

                field(indegredent; rec.Ingredient)
                {
                    ApplicationArea = All;
                }
                field(invpstgrp; rec."Inventory Posting Group")
                {
                    ApplicationArea = All;

                }

            }
        }
    }
    actions
    {
    }
}


page 50072 "apiLocation"
{

    PageType = API;
    APIVersion = 'v3.0';
    APIPublisher = 'Xigent';
    APIGroup = 'Custom';
    EntityName = 'apilocations';
    EntitySetName = 'apilocations';
    DelayedInsert = true;
    EntityCaption = 'apilocations';
    EntitySetCaption = 'Sync - POS Locations';
    SourceTable = Location;
    ODataKeyFields = SystemId;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(id; rec.SystemId)
                {
                    ApplicationArea = All;
                }
                field(number; rec.Code)
                {
                    ApplicationArea = All;
                }
                field(displayname; rec."Name")
                {
                    ApplicationArea = All;
                }

                field(name2; rec."Name 2")
                {
                    ApplicationArea = All;

                }

                field(address; rec."Address")
                {
                    ApplicationArea = All;

                }
                field(address2; rec."Address 2")
                {
                    ApplicationArea = All;

                }
                field(city; rec."City")
                {
                    ApplicationArea = All;

                }
                field(phoneno; rec."Phone No.")
                {
                    ApplicationArea = All;

                }
                field(faxno; rec."Fax No.")
                {
                    ApplicationArea = All;

                }
                field(countryregion; rec."Country/Region Code")
                {
                    ApplicationArea = All;

                }
                field(postcode; rec."Post Code")
                {
                    ApplicationArea = All;

                }
                field(state; rec."County")
                {
                    ApplicationArea = All;

                }
                field(email; rec."E-Mail")
                {
                    ApplicationArea = All;

                }
                field(contact; rec.Contact)
                {
                    ApplicationArea = All;

                }
                field(globaldim1; rec."Store Dimension")
                {
                    ApplicationArea = All;

                }

            }
        }

    }

    actions
    {
    }
}





page 50073 "apiVATPostingGroup"
{

    PageType = API;
    APIVersion = 'v3.0';
    APIPublisher = 'Xigent';
    APIGroup = 'Custom';
    EntityName = 'apivatpostinggroup';
    EntitySetName = 'apivatpostinggroup';
    DelayedInsert = true;
    EntityCaption = 'apivatpostinggroup';
    EntitySetCaption = 'Sync - VAT Posting Groups';
    SourceTable = "VAT Posting Setup";

    ODataKeyFields = SystemId;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(id; rec.SystemId)
                {
                    ApplicationArea = All;
                }
                field(vatbusgroup; rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field(vatprodgroup; rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = Suite;
                }
                field(caltype; rec."VAT Calculation Type")
                {
                    ApplicationArea = All;
                }
                field(vatrate; rec."VAT %")
                {
                    ApplicationArea = All;
                }
            }
        }

    }

    actions
    {
    }

}

page 50074 "apiSalesPrice"
{

    PageType = API;
    APIVersion = 'v3.0';
    APIPublisher = 'Xigent';
    APIGroup = 'Custom';
    EntityName = 'apiSalesPrice';
    EntitySetName = 'apiSalesPrice';

    DelayedInsert = true;
    EntityCaption = 'apiSalesPrice';
    EntitySetCaption = 'Sync - Sales Price';
    SourceTable = "Sales Price";
    ODataKeyFields = SystemId;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(id; rec.SystemId)
                {
                    ApplicationArea = All;
                }
                field(number; rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field(salestype; rec."Sales Type")
                {
                    ApplicationArea = All;
                }
                field(salescode; rec."Sales Code")
                {
                    ApplicationArea = All;
                }
                field(startdate; rec."Starting Date")
                {
                    ApplicationArea = All;
                }
                field(currcode; rec."Currency Code")
                {
                    ApplicationArea = All;

                }
                field(uomcode; rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field(minqty; rec."Minimum Quantity")
                {
                    ApplicationArea = All;
                }
                field(salesprice; rec."Unit Price")
                {
                    ApplicationArea = All;

                }

                field(allowinvdisc; rec."Allow Invoice Disc.")
                {
                    ApplicationArea = All;

                }
                field(enddate; rec."Ending Date")
                {
                    ApplicationArea = All;

                }
                field(allowlinedodisc; rec."Allow Line Disc.")
                {
                    ApplicationArea = All;

                }

            }

        }
    }


}



page 50075 "apiSalesLineDiscount"
{

    PageType = API;
    APIVersion = 'v3.0';
    APIPublisher = 'Xigent';
    APIGroup = 'Custom';
    EntityName = 'apisaleslinediscount';
    EntitySetName = 'apisaleslinediscount';
    DelayedInsert = true;
    EntityCaption = 'aapisaleslinediscount';
    EntitySetCaption = 'Sync - Sales Line Discount';
    SourceTable = "Sales Line Discount";
    ODataKeyFields = SystemId;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(id; rec.SystemId)
                {
                    ApplicationArea = All;
                }
                field(type; rec.type)
                {
                    ApplicationArea = All;
                }
                field(number; rec.code)
                {
                    ApplicationArea = All;
                }
                field(salestype; rec."Sales Type")
                {
                    ApplicationArea = All;
                }
                field(salescode; rec."Sales Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies how you want to set up the two currencies, one of the currencies can be LCY, for which you want to register exchange rates.';
                }
                field(startdate; rec."Starting Date")
                {
                    ApplicationArea = All;
                }
                field(uomcode; rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field(minqty; rec."Minimum Quantity")
                {
                    ApplicationArea = All;
                }
                field(salesdisc; rec."Line Discount %")
                {
                    ApplicationArea = All;

                }

                field(enddate; rec."Ending Date")
                {
                    ApplicationArea = All;

                }
            }
        }

    }

    actions
    {
    }


}

page 50076 "apiPaymentTerms"
{
    APIVersion = 'v3.0';
    EntityCaption = 'apipaymentterms';
    EntitySetCaption = 'Sync - Payment Terms';
    ChangeTrackingAllowed = true;
    DelayedInsert = true;
    DeleteAllowed = false;
    Editable = true;
    EntityName = 'apipaymentterms';
    EntitySetName = 'apipaymentterms';
    InsertAllowed = true;
    ModifyAllowed = true;
    ODataKeyFields = SystemId;
    APIPublisher = 'Xigent';
    APIGroup = 'Custom';
    PageType = API;
    SourceTable = "Payment Terms";
    Extensible = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(id; rec.SystemId)
                {
                    ApplicationArea = All;
                }
                field(number; rec.Code)
                {
                    ApplicationArea = All;
                }
                field(duedatecalc; rec."Due Date Calculation")
                {
                    ApplicationArea = All;
                }
                field(discdate; rec."Discount Date Calculation")
                {
                    ApplicationArea = All;
                }
                field(discrate; rec."Discount %")
                {
                    ApplicationArea = All;
                }

                field(displayname; rec.Description)
                {
                    ApplicationArea = All;
                }

            }
        }
    }

    actions
    {
    }


}


page 50077 "apiitemunitofmeasure"
{
    APIVersion = 'v3.0';
    EntityCaption = 'apiitemunitofmeasure';
    EntitySetCaption = 'Sync - Item Unit of Measure';
    ChangeTrackingAllowed = true;
    DelayedInsert = true;
    DeleteAllowed = false;
    Editable = false;
    EntityName = 'apiitemunitofmeasure';
    EntitySetName = 'apiitemunitofmeasure';
    InsertAllowed = true;
    ModifyAllowed = true;
    ODataKeyFields = SystemId;
    APIPublisher = 'Xigent';
    APIGroup = 'Custom';
    PageType = API;
    SourceTable = "Item Unit of Measure";
    Extensible = false;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(id; rec.SystemId)
                {
                    ApplicationArea = All;
                }
                field(number; rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field(code; rec.Code)
                {
                    ApplicationArea = All;
                }
                field(qtyper; rec."Qty. per Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field(ingredient; rec.Ingredient)
                {
                    ApplicationArea = All;
                }


            }
        }
    }

    actions
    {
    }
}




page 50080 "apiitemReference"
{
    APIVersion = 'v3.0';
    EntityCaption = 'apiitemReference';
    EntitySetCaption = 'Sync - Item Reference';
    ChangeTrackingAllowed = true;
    DelayedInsert = true;
    DeleteAllowed = true;
    Editable = true;
    EntityName = 'apiitemReference';
    EntitySetName = 'apiitemReference';
    InsertAllowed = true;
    ModifyAllowed = true;
    ODataKeyFields = SystemId;
    APIPublisher = 'Xigent';
    APIGroup = 'Custom';
    PageType = API;
    SourceTable = "Item Reference";
    Extensible = false;
    //SourceTableView = where("Message" = filter('*The specified product ID conflicts with the product ID of an existing record.*'));
    //SourceTableView = where("No." = filter(13138920));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(id; rec.SystemId)
                {
                    ApplicationArea = All;
                }
                field("number"; rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("variantcode"; rec."Variant Code")
                {
                    ApplicationArea = All;
                }
                field(unitofmeasure; rec."Unit of Measure")
                {
                    ApplicationArea = All;
                }

                field(crossreftype; rec."Reference Type")
                {
                    ApplicationArea = All;
                }
                field(crossrefno; rec."Reference No.")
                {
                    ApplicationArea = All;
                }
                field(displayname; rec."Description")
                {
                    ApplicationArea = All;
                }

            }
        }
    }

    actions
    {
    }
}


page 50078 "apiSalesPeople"
{
    APIVersion = 'v3.0';
    EntityCaption = 'apisalespeople';
    EntitySetCaption = 'Sync - Item Reference';
    ChangeTrackingAllowed = true;
    DelayedInsert = true;
    DeleteAllowed = true;
    Editable = true;
    EntityName = 'apisalespeople';
    EntitySetName = 'apisalespeople';
    InsertAllowed = true;
    ModifyAllowed = true;
    ODataKeyFields = SystemId;
    APIPublisher = 'Xigent';
    APIGroup = 'Custom';
    PageType = API;
    SourceTable = "Salesperson/Purchaser";
    Extensible = false;
    //SourceTableView = where("Message" = filter('*The specified product ID conflicts with the product ID of an existing record.*'));
    //SourceTableView = where("No." = filter(13138920));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(id; rec.SystemId)
                {
                    ApplicationArea = All;
                }
                field("number"; rec."Code")
                {
                    ApplicationArea = All;
                }
                field(displayname; rec."Name")
                {
                    ApplicationArea = All;

                }
            }
        }
    }
    actions
    {
    }
}



/*
page 50073 "apicrmcustomer"
{
    APIVersion = 'v3.0';
    EntityCaption = 'apicustomer';
    EntitySetCaption = 'apicustomer';
    ChangeTrackingAllowed = true;
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    EntityName = 'apicustomer';
    EntitySetName = 'apicustomer';
    InsertAllowed = false;
    ModifyAllowed = false;
    ODataKeyFields = SystemId;
    APIPublisher = 'Xigent';
    APIGroup = 'Custom';
    PageType = API;
    SourceTable = "Customer";
    Extensible = false;
    //SourceTableView = where("Message" = filter('*The specified product ID conflicts with the product ID of an existing record.*'));
    //SourceTableView = where("No." = filter(13138920));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(number; rec.SystemId)
                {
                    ApplicationArea = All;
                }
                field("crmid"; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("iscoupled"; rec."Coupled to Dataverse")
                {
                    ApplicationArea = All;
                }
                field("classification"; rec."Customer Classification")
                {
                    ApplicationArea = All;
                }



            }
        }
    }

    actions
    {
    }
}

page 50075 "apicrmshiptoaddress"
{
    APIVersion = 'v3.0';
    EntityCaption = 'apicrmsshipotoaddress';
    EntitySetCaption = 'apicrmsshipotoaddress';
    ChangeTrackingAllowed = true;
    DelayedInsert = true;
    DeleteAllowed = false;
    Editable = true;
    EntityName = 'apicrmsshipotoaddress';
    EntitySetName = 'apicrmsshipotoaddress';
    InsertAllowed = true;
    ModifyAllowed = true;
    ODataKeyFields = SystemId;
    APIPublisher = 'Xigent';
    APIGroup = 'Custom';
    PageType = API;
    SourceTable = "Ship-to Address";
    Extensible = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(number; rec.SystemId)
                {
                    ApplicationArea = All;
                }
                field("crmsshiptoaddracctno"; Rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field("crmsshiptoaddrno"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field("crmsshiptoaddrname"; rec.name)
                {
                    ApplicationArea = All;
                }

                field("crmsshiptoaddrname2"; rec."Name 2")
                {
                    ApplicationArea = All;
                }

                field("crmsshiptoaddr"; rec.Address)
                {
                    ApplicationArea = All;
                }


                field("crmsshiptoaddr2"; rec."Address 2")
                {
                    ApplicationArea = All;
                }
                field("crmsshiptocity"; rec."City")
                {
                    ApplicationArea = All;
                }
                field("crmsshiptostate"; rec."County")
                {
                    ApplicationArea = All;
                }
                field("crmsshiptozipcode"; rec."Post Code")
                {
                    ApplicationArea = All;
                }
                field("crmsshiptocountry"; rec."Country/Region Code")
                {
                    ApplicationArea = All;
                }
                field("crmsshiptophone"; rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field("crmsshiptemail"; rec."E-Mail")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}

page 50074 "apisalesassembnotification"
{
    APIVersion = 'v3.0';
    EntityCaption = 'apisalesassembnotification';
    EntitySetCaption = 'apisalesassembnotification';
    ChangeTrackingAllowed = true;
    DelayedInsert = true;
    DeleteAllowed = false;
    Editable = true;
    EntityName = 'apisalesassembnotification';
    EntitySetName = 'apisalesassembnotification';
    InsertAllowed = true;
    ModifyAllowed = true;
    ODataKeyFields = SystemId;
    APIPublisher = 'Xigent';
    APIGroup = 'Custom';
    PageType = API;
    SourceTable = "Sales Line";
    SourceTableView = where("Document Type" = filter(Order), "Item Category Code" = filter('ASSEMBLIES'), "Quantity" = filter(> 0));
    Extensible = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(number; rec.SystemId)
                {
                    ApplicationArea = All;
                }
                field("itemno"; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("orderno"; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("customer"; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("qty"; rec.Quantity)
                {
                    ApplicationArea = All;

                }

                field("amount"; rec."Amount")
                {
                    ApplicationArea = All;
                }

                field("customerpo"; getExternalDocNo(rec."Document No."))
                {
                    ApplicationArea = All;
                }

                field("category"; rec."Item Category Code")
                {
                    ApplicationArea = All;
                }


            }

        }

    }
    actions
    {
    }

    local procedure getExternalDocNo(documentno: Code[20]): Text[100]
    var
        SalesHeader: Record "Sales Header";
    begin
        if SalesHeader.Get(SalesHeader."Document Type"::Order, documentno) then
            exit(salesheader."External Document No.");
    end;



}


page 50076 "xg_apicustomer"
{
    APIVersion = 'v3.0';
    EntityCaption = 'xg_apicustomer';
    EntitySetCaption = 'xg_apicustomer';
    ChangeTrackingAllowed = true;
    DelayedInsert = true;
    DeleteAllowed = false;
    Editable = true;
    EntityName = 'xg_apicustomer';
    EntitySetName = 'xg_apicustomer';
    InsertAllowed = true;
    ModifyAllowed = true;
    ODataKeyFields = SystemId;
    APIPublisher = 'Xigent';
    APIGroup = 'Custom';
    PageType = API;
    SourceTable = "Customer";
    Extensible = false;
    //SourceTableView = where("Message" = filter('*The specified product ID conflicts with the product ID of an existing record.*'));
    //SourceTableView = where("No." = filter(13138920));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(number; rec.SystemId)
                {
                    ApplicationArea = All;
                }

                field(accountnumber; rec."No.")
                {
                    ApplicationArea = All;
                }

                field(accountname; rec.Name)
                {
                    ApplicationArea = All;
                }
                field(accountclassification; rec."Customer Classification")
                {
                    ApplicationArea = All;
                }

                field(address1; Rec.Address)
                {
                    ApplicationArea = All;
                }
                field(address2; Rec."Address 2")
                {
                    ApplicationArea = All;
                }

                field("city"; rec.City)
                {
                    ApplicationArea = All;
                }
                field("statecode"; rec.County)
                {
                    ApplicationArea = All;

                }
                field("postcode"; rec."Post Code")
                {
                    ApplicationArea = All;
                }


                field("countrycode"; rec."Country/Region Code")
                {
                }
                field("crmemail"; rec."E-Mail")
                {
                    ApplicationArea = All;
                }
                field("mainphoneno"; rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field("mainfaxno"; Rec."Fax No.")
                {
                    ApplicationArea = All;
                }
                field(currencycode; rec."currency code")
                {
                    ApplicationArea = All;
                }
                field(paymenttermms; rec."Payment Terms Code")

                {
                    ApplicationArea = All;
                }
                field("genbuspostgroup"; rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                }


                field(custpostgroup; Rec."Customer Posting Group")
                {
                    ApplicationArea = All;
                }

                field(contactname; rec.Contact)
                {
                    ApplicationArea = All;
                }

                field(homepage; rec."Home Page")
                {
                    ApplicationArea = All;
                }
                field("shipmentmethod"; Rec."Shipment Method Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }


    actions
    {
    }
    local procedure getPaymentTerms(fortermscode: Code[100]): Code[20]
    var
        paymentTermsMapping: Record "CRM Option Mapping";
        termsCodeInt: Integer;
    begin
        if not Evaluate(termsCodeint, fortermscode) then
            exit('');
        paymentTermsMapping.Reset();
        paymentTermsMapping.SetRange("Option Value", termsCodeInt);
        paymentTermsMapping.SetRange("Table ID", Database::"Payment Terms");
        if paymentTermsMapping.FindFirst then
            exit(paymentTermsMapping."Option Value Caption")
        else
            exit('');

    end;

    local procedure setvariable()
    var
        glSetup: Record "General Ledger Setup";
    begin
        glSetup.Get();
        if glsetup."LCY Code" = rec."Currency Code" then
            rec."Currency Code" := '';
    end;

    trigger OnAfterGetRecord()
    begin
        setvariable;
    end;

    trigger OnAfterGetCurrRecord()
    begin

    end;

    trigger OnModifyRecord(): Boolean
    begin
        setvariable;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        setvariable;
    end;


}

page 50077 "apipurchasereceiptline"
{
    DelayedInsert = true;
    APIVersion = 'v3.0';
    EntityCaption = 'purchrecptline';
    EntitySetCaption = 'purchrecptline';
    APIPublisher = 'Xigent';
    APIGroup = 'Custom';
    PageType = API;
    ODataKeyFields = SystemId;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    EntityName = 'purchaseReceiptLine';
    EntitySetName = 'purchaseReceiptLines';
    SourceTable = "Purch. Rcpt. Line";
    SourceTableView = where(Type = filter(Item), Quantity = filter(> 0));

    Extensible = false;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(id; Rec.SystemId)
                {
                    Caption = 'Id';
                    Editable = false;
                }
                field(documentId; Rec."Document Id")
                {
                    Caption = 'Document Id';
                }
                field(sequence; Rec."Line No.")
                {
                    Caption = 'Sequence';
                }
                field(lineType; Rec.Type)
                {
                    Caption = 'Line Type';
                }
                field(lineObjectNumber; Rec."No.")
                {
                    Caption = 'Line Object No.';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(description2; Rec."Description 2")
                {
                    Caption = 'Description 2';
                }
                field(unitOfMeasureCode; Rec."Unit of Measure Code")
                {
                    Caption = 'Unit Of Measure Code';
                }
                field(unitCost; Rec."Direct Unit Cost")
                {
                    Caption = 'Direct Unit Cost';
                }
                field(quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                }
                field(discountPercent; Rec."Line Discount %")
                {
                    Caption = 'Discount Percent';
                }
                field(taxPercent; Rec."VAT %")
                {
                    Caption = 'Tax Percent';
                }
                field(expectedReceiptDate; Rec."Expected Receipt Date")
                {
                    Caption = 'Expected Receipt Date';
                }
                field(bl; rec."Shortcut Dimension 1 Code")
                {
                    Caption = 'Business Line';
                }


                field(pl; rec."Shortcut Dimension 2 Code")
                {
                    Caption = 'Product Line';
                }

                field(vendno; rec."Buy-from Vendor No.")
                {
                    Caption = 'Vendor No';
                }
                field(vendname; getVendorName(rec."Buy-from Vendor No."))
                {
                    Caption = 'Vendor Name';
                }

                field(docnumber; rec."Document No.")
                {
                    Caption = 'Document Number';
                }
            }
        }
    }

    local procedure getVendorName(ForVendor: Code[20]): Text[100]
    var
        Vendor: Record "Vendor";
    begin
        if Vendor.Get(ForVendor) then
            exit(Vendor.Name)
        else
            exit('');

    end;
}

   */
