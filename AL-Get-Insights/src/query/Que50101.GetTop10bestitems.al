query 50101 "AIR Get Top 10 best items"
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
            column(menu_item; menu_item)
            {

            }
            column(orders; orders)
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
