page 50101 "AIR Top 10 Items"
{

    PageType = List;
    SourceTable = "Name/Value Buffer";
    Caption = 'Top 10 Items';

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Name; Name)
                {
                    ApplicationArea = All;
                }
                field(Value; Value)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}
