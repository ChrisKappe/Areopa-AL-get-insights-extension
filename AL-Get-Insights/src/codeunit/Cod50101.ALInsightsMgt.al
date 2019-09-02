codeunit 50101 "AIR AL Insights Mgt."
{
    procedure GetTop10ItemsInsight()
    var
        TopTenDaysFilter: text;
        ItemBuff: Record "Name/Value Buffer" temporary;
    begin
        GetTop10BestSellingDays(TopTenDaysFilter);
        GetTop10BestSellingItemsOnTop10BestSellingDays(TopTenDaysFilter, ItemBuff);
        ShowTop10BestSellingItemsOnTop10BestSellingDays(ItemBuff);
    end;

    local procedure GetTop10BestSellingDays(var TopTenDaysFilter: Text)
    var
        Top10BestSellingDays: Query "AIR Get Top 10 best days";
    begin
        Top10BestSellingDays.Open();
        while Top10BestSellingDays.Read() do
            AddDateToTheFilter(Top10BestSellingDays.date, TopTenDaysFilter);
        Top10BestSellingDays.Close();
    end;

    local procedure AddDateToTheFilter(TopDate: Date; var TopTenDaysFilter: Text)
    begin
        if TopTenDaysFilter = '' then
            TopTenDaysFilter := Format(TopDate)
        else
            TopTenDaysFilter := TopTenDaysFilter + '|' + Format(TopDate);
    end;

    local procedure GetTop10BestSellingItemsOnTop10BestSellingDays(TopTenDaysFilter: Text; ItemBuff: Record "Name/Value Buffer" temporary)
    var
        Top10BestSellingItems: Query "AIR Get Top 10 best items";
    begin
        Top10BestSellingItems.SetFilter(date, TopTenDaysFilter);
        Top10BestSellingItems.Open();
        while Top10BestSellingItems.Read() do
            ItemBuff.AddNewEntry(Top10BestSellingItems.menu_item, format(Top10BestSellingItems.orders));
        Top10BestSellingItems.Close;
    end;

    local procedure ShowTop10BestSellingItemsOnTop10BestSellingDays(ItemBuff: Record "Name/Value Buffer" temporary)
    var
        Top10Items: Page "AIR Top 10 Items";
    begin
        Top10Items.SetTableView(ItemBuff);
        Top10Items.Run();
    end;

}