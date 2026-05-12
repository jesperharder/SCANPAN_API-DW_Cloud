permissionset 50230 "PERFION API READ"
{
    Caption = 'Perfion API - Read';
    Assignable = true;

    Permissions =
        page "PerfionItemsOData" = X,
        page "PerfionPricesOData" = X,
        tabledata Item = R,
        tabledata "Item Reference" = R,
        tabledata "Item Translation" = R,
        tabledata "Item Unit of Measure" = R,
        tabledata "Price List Line" = R,
        tabledata Campaign = R;
}
