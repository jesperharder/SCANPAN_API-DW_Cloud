permissionset 50223 "API_DW"
{
    Caption = 'Scanpan API DataWarehouse';
    Assignable = true;

    Permissions =
        // GL ↔ Item reconciliation
        tabledata "G/L - Item Ledger Relation" = R,
        page "GLItemLedgerRelationAPI" = X,

    // Fix for ItemDW permission chain
    tabledata "Sustainability Setup" = R;

}
