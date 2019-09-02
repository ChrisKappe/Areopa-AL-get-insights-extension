query 50100 "AIR Get Top 10 best days"
{
    QueryType = Normal;
    OrderBy = descending (orders);
    TopNumberOfRows = 10;


    elements
    {
        dataitem(AIRRestSalesEntry; "AIR RestSalesEntry")
        {
            column(date; date)
            {
            }
            column(orders; orders)
            {
                Method = Sum;
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
