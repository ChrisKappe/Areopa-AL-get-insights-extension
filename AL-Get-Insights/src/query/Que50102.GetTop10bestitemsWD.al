query 50102 "AIR Get Top 10 best items WD"
{
    QueryType = Normal;
    OrderBy = descending (orders);
    TopNumberOfRows = 10;

    elements
    {
        dataitem(AIRRestSalesEntry; "AIR RestSalesEntry")
        {
            filter(date; date)
            {
            }

            //Show different date methods here
            //column(date; date)
            //{
            //    Method = 
            //}
            column(s_day_of_the_week; s_day_of_the_week)
            {

            }

            column(menu_item; menu_item)
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
