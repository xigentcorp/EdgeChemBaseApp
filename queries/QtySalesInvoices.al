query 50000 qrySalesInvoices
{
    Caption = 'ECqrySalesInvoicesDetail';
    QueryType = Normal;


    elements
    {
        dataitem(SalesInvoiceHeader; "Sales Invoice Header")
        {
            column(SelltoCustomerNo; "Sell-to Customer No.")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(SalespersonCode; "Salesperson Code")
            {
            }
            column(Currency_Code; "Currency Code")
            {
            }
            column(Currency_Factor; "Currency Factor")
            {

            }

            dataitem(SalesInvLine; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = SalesInvoiceHeader."No.";
                column(Type; Type)
                {

                }

                column(No; "No.")
                {

                }

                column(Location; "Location Code")
                {

                }
                column(Quantity; Quantity)
                {
                }

                column(QuantityBase; "Quantity (Base)")
                {
                }

                column(UnitofMeasure; "Unit of Measure Code")
                {
                }

                column(QtyperUnitofMeasure; "Qty. per Unit of Measure")
                {
                }

                column(LineDiscountAmount; "Line Discount Amount")
                {
                    Method = Sum;
                }

                column(InvDiscountAmount; "Inv. Discount Amount")
                {

                    Method = Sum;
                }

                column(LineAmount; "Line Amount")
                {
                    Method = Sum;
                }

                column(AmountIncludingVAT; "Amount Including VAT")
                {
                    Method = Sum;
                }




                filter(PostingDateFilter; "Posting Date")
                {
                    Caption = 'Posting Date Filter';

                }

            }

        }
    }
    trigger OnBeforeOpen()
    begin

    end;
}


query 50001 qrySalesCMDetails
{
    Caption = 'ECqrySalesCMDetail';
    QueryType = Normal;

    elements
    {
        dataitem(SalesCMHeader; "Sales Cr.Memo Header")
        {
            column(SelltoCustomerNo; "Sell-to Customer No.")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(SalespersonCode; "Salesperson Code")
            {
            }
            column(Currency_Code; "Currency Code")
            {
            }
            column(Currency_Factor; "Currency Factor")
            {

            }

            dataitem(SalesCMLine; "Sales Cr.Memo Line")
            {
                DataItemLink = "Document No." = SalesCMHeader."No.";
                column(Type; Type)
                {

                }

                column(No; "No.")
                {

                }

                column(Location; "Location Code")
                {

                }
                column(Quantity; Quantity)
                {
                }

                column(QuantityBase; "Quantity (Base)")
                {
                }

                column(UnitofMeasure; "Unit of Measure Code")
                {
                }

                column(QtyperUnitofMeasure; "Qty. per Unit of Measure")
                {
                }

                column(LineDiscountAmount; "Line Discount Amount")
                {
                    Method = Sum;
                }

                column(InvDiscountAmount; "Inv. Discount Amount")
                {

                    Method = Sum;
                }

                column(LineAmount; "Line Amount")
                {
                    Method = Sum;
                }

                column(AmountIncludingVAT; "Amount Including VAT")
                {
                    Method = Sum;
                }

                column(CMLineDiscCode; "Line Discount Amount")
                {

                }

                column(CreditMemoDiscAmount; "Inv. Discount Amount")
                {
                    Method = Sum;
                }


                filter(PostingDateFilter; "Posting Date")
                {
                    Caption = 'Posting Date Filter';

                }

            }

        }
    }
    trigger OnBeforeOpen()
    begin

    end;
}


query 50002 qrySalesOrderDetails
{
    Caption = 'ECqrySalesOrderDetail';
    QueryType = Normal;

    elements
    {
        dataitem(SalesOrdHeader; "Sales Header")
        {
            column(SelltoCustomerNo; "Sell-to Customer No.")
            {
            }
            column(OrderDate; "Order Date")
            {
            }
            column(SalespersonCode; "Salesperson Code")
            {
            }
            column(Currency_Code; "Currency Code")
            {
            }
            column(Currency_Factor; "Currency Factor")
            {

            }

            dataitem(SalesLine; "Sales Line")
            {
                DataItemLink = "Document No." = SalesOrdHeader."No.";
                column(Type; Type)
                {

                }

                column(No; "No.")
                {

                }
                column(Quantity; Quantity)
                {
                }

                column(Location; "Location Code")
                {

                }

                column(OutsQty; "Outstanding Quantity")
                {
                }

                column(UnitofMeasure; "Unit of Measure Code")
                {
                }

                column(QtyperUnitofMeasure; "Qty. per Unit of Measure")
                {
                }

                column(LineAmount; "Line Amount")
                {
                    Method = Sum;
                }

                column(OutAmtLCY; "Outstanding Amount (LCY)")
                {

                    Method = Sum;
                }

                column(OutAmount; "Outstanding Amount")
                {
                    Method = Sum;
                }


                column(AmtShipNotInvLCY; "Shipped Not Invoiced (LCY)")
                {
                    Method = Sum;
                }

                column(AmtShipNotInv; "Shipped Not Invoiced")
                {
                    Method = Sum;
                }

                column(CreditMemoDiscAmount; "Inv. Discount Amount")
                {
                    Method = Sum;
                }


                /*   filter(OrdergDateFilter; "Order Date")
                   {
                       Caption = 'Posting Date Filter';

                   }*/

            }

        }
    }
    trigger OnBeforeOpen()
    begin

    end;
}
