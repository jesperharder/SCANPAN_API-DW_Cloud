permissionset 50230 "PERFION API READ"
{
    Caption = 'Perfion API - Read';
    Assignable = true;

    Permissions =
        page "PerfionItemsAPI" = X,
        page "PerfionItemsOData" = X,
        page "PerfionPricesAPI" = X,
        page "PerfionPricesOData" = X,
        tabledata Item = R,
        tabledata "Item Reference" = R,
        tabledata "Item Translation" = R,
        tabledata "Item Unit of Measure" = R,
        tabledata "Price List Line" = R,
        tabledata Campaign = R;
}
