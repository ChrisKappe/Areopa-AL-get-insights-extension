codeunit 50101 "AIR AL Insights Mgt."
{
    procedure GetTop10ItemsInsight()
    var
        TopTenDaysFilter: text;
        ItemBuff: Record "Name/Value Buffer" temporary;
        StartExecutionTime: Time;
    begin
        StartExecutionTime := System.Time;

        SetDayOfTheWeekOnAllTransactions(); //new step

        GetTop10BestSellingDays(TopTenDaysFilter);
        GetTop10BestSellingItemsOnTop10BestSellingDays(TopTenDaysFilter, ItemBuff);
        ShowTotalExecutionTime(StartExecutionTime, System.Time);

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

    local procedure SetDayOfTheWeekOnAllTransactions()
    var
        RestSalesEntry: Record "AIR RestSalesEntry";
    begin
        with RestSalesEntry do begin
            if FindSet() then
                repeat
                    s_day_of_the_week := getDayOfTheWeek(date);
                    Modify();
                until next = 0;
            Commit;
        end;
    end;

    local procedure getDayOfTheWeek(SalesDate: Date): Text
    var
        date: Record date;
    begin
        date.Get(date."Period Type"::Date, SalesDate);
        exit(date."Period Name");
    end;

    local procedure GetTop10BestSellingItemsOnTop10BestSellingDays(TopTenDaysFilter: Text; var ItemBuff: Record "Name/Value Buffer" temporary)
    var
        Top10BestSellingItemsWD: Query "AIR Get Top 10 best items WD";
    begin
        Top10BestSellingItemsWD.SetFilter(date, TopTenDaysFilter);
        Top10BestSellingItemsWD.Open();
        while Top10BestSellingItemsWD.Read() do begin
            AddNewEntryToBuffer(Top10BestSellingItemsWD.s_day_of_the_week, Top10BestSellingItemsWD.menu_item, format(Top10BestSellingItemsWD.orders), ItemBuff);
        end;
        Top10BestSellingItemsWD.Close;
    end;

    local procedure AddNewEntryToBuffer(NewName: text; NewLongName: Text; NewValue: Text; var ItemBuff: Record "Name/Value Buffer" temporary)
    begin
        ItemBuff.AddNewEntry(NewName, NewValue);
        ItemBuff."Value Long" := NewLongName;
        ItemBuff.Modify();
    end;

    local procedure ShowTop10BestSellingItemsOnTop10BestSellingDays(var ItemBuff: Record "Name/Value Buffer" temporary)
    var
    begin
        Page.RunModal(Page::"AIR Top 10 Items WD", ItemBuff);
    end;

    local procedure ShowTotalExecutionTime(StartTime: time; EndTime: time)
    begin
        Message('Execution time is %1 sec', (EndTime - StartTime) / 1000);
    end;

}