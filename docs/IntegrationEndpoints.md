# Integration Endpoints

## Purpose

This document describes the current integration design for the three operational OData export endpoints in `SCANPAN API-DW Cloud`:

- `AuningStockDW`
- `PerfionItemsDW`
- `PerfionPricesDW`

The document covers:

- business purpose
- technical design in Business Central
- operational behavior in BC
- publication model
- permission model
- the main calculation and filtering logic

## Scope

The current OData endpoints are:

1. `page 50233 "AuningStockOData"` published as `AuningStockDW`
2. `page 50226 "PerfionItemsOData"` published as `PerfionItemsDW`
3. `page 50228 "PerfionPricesOData"` published as `PerfionPricesDW`

The repo also retains two custom API pages:

- `page 50211 "PerfionItemsAPI"`
- `page 50225 "PerfionPricesAPI"`

These custom API pages still exist in the extension, while the operational publication for the DW-facing service layer is handled through the OData pages.

## Architecture Summary

The solution uses three related patterns.

### AUNING stock: snapshot export

- stock is calculated by Job Queue
- calculated values are stored on `Item`
- OData only exposes the stored snapshot

This is the performance-oriented pattern.

### Perfion items: direct OData over `Item`

- the page reads directly from `Item`
- additional values are computed in `OnAfterGetRecord()`
- the page exposes a flattened export contract

### Perfion prices: temporary curated dataset

- the page uses `SourceTableTemporary = true`
- the dataset is rebuilt on page open
- only the preferred valid price rows are kept

## Endpoint 1: AUNING Stock

### Business purpose

`AuningStockDW` provides a compact stock snapshot for eCommerce and downstream integrations.

### Scope

The dataset is scoped to:

- location `AUNING`
- inventory items only
- `Gen. Prod. Posting Group = INTERN|EKSTERN|BRUND`

### Exposed fields

- `itemNo`
- `description`
- `auningStockOnHand`
- `auningStockAvailable`
- `auningStockUpdatedAt`

### Data model

The snapshot is stored on `Item` by:

- [DWItemAuningStock.TableExt.al](/c:/Users/jespe/OneDrive%20-%20Scanpan/Scanpan%20(7.1.2015)/Development/SCANPAN%20API-DW%20Cloud/src/table/DWItemAuningStock.TableExt.al:1)

Fields:

- `AUNING Stock On Hand`
- `AUNING Stock Available`
- `AUNING Stock Updated At`

### Calculation model

The snapshot is populated by:

- [AuningStockUpdate.Codeunit.al](/c:/Users/jespe/OneDrive%20-%20Scanpan/Scanpan%20(7.1.2015)/Development/SCANPAN%20API-DW%20Cloud/src/codeunit/AuningStockUpdate.Codeunit.al:1)

The codeunit:

- is Job Queue enabled
- resolves location `AUNING`
- filters inventory items by product posting group
- calculates blank variant and item variants
- rounds quantities down to integers
- prevents negative results
- stores a single timestamp for the run

### Stock definitions

`AUNING Stock On Hand`

- based on `Item.Inventory`
- filtered by location and variant
- summed across variants
- rounded down to a whole number
- clamped to `0`

`AUNING Stock Available`

- based on `Warehouse Availability Mgt.`
- calculated per variant and summed
- optionally reduced by percentage
- rounded down to a whole number
- clamped to `0`

### Job Queue parameters

Supported parameter tokens:

- `GenProdPostingGroupFilter`
- `AvailableReductionPct`

Examples:

```text
GenProdPostingGroupFilter=INTERN|EKSTERN|BRUND
```

```text
GenProdPostingGroupFilter=INTERN|EKSTERN|BRUND;AvailableReductionPct=10
```

Interpretation:

- `AvailableReductionPct=0` means no extra reduction
- `AvailableReductionPct=10` means 10% reduction of calculated available stock

### BC operational layer

The snapshot is visible on the Item Card through:

- [AuningStockFactBox.Page.al](/c:/Users/jespe/OneDrive%20-%20Scanpan/Scanpan%20(7.1.2015)/Development/SCANPAN%20API-DW%20Cloud/src/page/AuningStockFactBox.Page.al:1)
- [DWItemCardAuningStock.PageExt.al](/c:/Users/jespe/OneDrive%20-%20Scanpan/Scanpan%20(7.1.2015)/Development/SCANPAN%20API-DW%20Cloud/src/page/DWItemCardAuningStock.PageExt.al:1)

When the codeunit is run manually with UI access:

- total items are shown
- processed items are shown
- current item number is shown

When run in background Job Queue:

- no dialog is shown

## Endpoint 2: Perfion Items

### Business purpose

`PerfionItemsDW` exposes a curated item master dataset for Perfion-related integration.

### Operational page

- [PerfionItemsOData.Page.al](/c:/Users/jespe/OneDrive%20-%20Scanpan/Scanpan%20(7.1.2015)/Development/SCANPAN%20API-DW%20Cloud/src/page/PerfionItemsOData.Page.al:1)

Published as:

- `PerfionItemsDW`

### Retained custom API page

- [PerfionItemsAPI.Page.al](/c:/Users/jespe/OneDrive%20-%20Scanpan/Scanpan%20(7.1.2015)/Development/SCANPAN%20API-DW%20Cloud/src/page/PerfionItemsAPI.Page.al:1)

### Base filter

- `Gen. Prod. Posting Group = INTERN|EKSTERN|BRUND`
- `ABCD Category <> E and <> D`
- `Product Usage <> PRODUCTION and <> MARKETING`
- `Prod. Group Code <> RÅVARE`

### Enrichment logic

The page enriches each record with:

- item type as integer and text
- barcodes for `STK`, `INNER`, `MASTER`
- translated descriptions in multiple languages
- fallback from Danish translation to `Item.Description`
- UoM dimensions and weights for `STK`, `INNER`, `MASTER`

### Source tables

- `Item`
- `Item Reference`
- `Item Translation`
- `Item Unit of Measure`

## Endpoint 3: Perfion Prices

### Business purpose

`PerfionPricesDW` exposes a curated pricing dataset for today.

### Operational page

- [PerfionPricesOData.Page.al](/c:/Users/jespe/OneDrive%20-%20Scanpan/Scanpan%20(7.1.2015)/Development/SCANPAN%20API-DW%20Cloud/src/page/PerfionPricesOData.Page.al:1)

Published as:

- `PerfionPricesDW`

### Retained custom API page

- [PerfionPricesAPI.Page.al](/c:/Users/jespe/OneDrive%20-%20Scanpan/Scanpan%20(7.1.2015)/Development/SCANPAN%20API-DW%20Cloud/src/page/PerfionPricesAPI.Page.al:1)

### Dataset construction

The page uses a temporary `Price List Line` dataset.

Flow:

1. clear temporary rows
2. load active rows valid for today
3. apply incoming OData filters where relevant
4. keep one preferred row per combination of:
   `Asset No. + Source No. + Currency Code + Unit of Measure Code`
5. prefer latest `Starting Date`
6. if dates are equal, prefer lowest `Unit Price`

### Important cloud-specific note

The campaign matching code is currently disabled in this repo.

In practice this means:

- `campaignPrice` remains `0`
- `campaignId` remains blank

The page structure still contains the fields and helper methods, but the matching block against `Campaign."Customer Price Group NOTO"` is commented out.

### Source tables

- `Price List Line`
- `Campaign`

### Design note

The current deduplication key does not include `Minimum Quantity`.

That means the endpoint returns one preferred row per item/sales code/currency/UoM combination, not a full tier-price breakdown.

## Publication Model

Publication is handled centrally by:

- [DWWSRegistrar.Codeunit.al](/c:/Users/jespe/OneDrive%20-%20Scanpan/Scanpan%20(7.1.2015)/Development/SCANPAN%20API-DW%20Cloud/src/codeunit/DWWSRegistrar.Codeunit.al:1)

Relevant service names:

- `AuningStockDW`
- `PerfionItemsDW`
- `PerfionPricesDW`

The registrar removes old web service rows and inserts one canonical published row per page.

## Permissions

Relevant permission sets:

- [AUNINGSTOCKREAD.PermissionSet.al](/c:/Users/jespe/OneDrive%20-%20Scanpan/Scanpan%20(7.1.2015)/Development/SCANPAN%20API-DW%20Cloud/src/permissionset/AUNINGSTOCKREAD.PermissionSet.al:1)
- [PERFIONAPIREAD.PermissionSet.al](/c:/Users/jespe/OneDrive%20-%20Scanpan/Scanpan%20(7.1.2015)/Development/SCANPAN%20API-DW%20Cloud/src/permissionset/PERFIONAPIREAD.PermissionSet.al:1)

Operationally, the integration user must be able to:

- execute the published page
- read the underlying data tables
- authenticate in the environment

## Code Example and Explanation

Stock normalization:

```al
local procedure NormalizeAvailableQuantity(AvailableQuantity: Decimal; AvailableReductionPct: Decimal): Decimal
var
    ReducedAvailableQuantity: Decimal;
begin
    ReducedAvailableQuantity := AvailableQuantity;
    if AvailableReductionPct > 0 then
        ReducedAvailableQuantity := ReducedAvailableQuantity * (100 - AvailableReductionPct) / 100;

    exit(NormalizeQuantity(ReducedAvailableQuantity));
end;
```

This means:

- percentage reduction is optional
- output is normalized to a non-negative whole number

Price selection:

```al
if SP."Starting Date" > Existing."Starting Date" then
    ReplaceExisting := true
else
    if SP."Starting Date" = Existing."Starting Date" then begin
        if (SP."Unit Price" <> 0) and (Existing."Unit Price" <> 0) then begin
            if SP."Unit Price" < Existing."Unit Price" then
                ReplaceExisting := true;
        end else
            if (Existing."Unit Price" = 0) and (SP."Unit Price" <> 0) then
                ReplaceExisting := true;
    end;
```

This means:

- later valid start date wins
- lower price wins on identical start date
- only one preferred line is kept per logical combination

## Files

Main implementation files:

- [AuningStockUpdate.Codeunit.al](/c:/Users/jespe/OneDrive%20-%20Scanpan/Scanpan%20(7.1.2015)/Development/SCANPAN%20API-DW%20Cloud/src/codeunit/AuningStockUpdate.Codeunit.al:1)
- [DWItemAuningStock.TableExt.al](/c:/Users/jespe/OneDrive%20-%20Scanpan/Scanpan%20(7.1.2015)/Development/SCANPAN%20API-DW%20Cloud/src/table/DWItemAuningStock.TableExt.al:1)
- [AuningStockOData.Page.al](/c:/Users/jespe/OneDrive%20-%20Scanpan/Scanpan%20(7.1.2015)/Development/SCANPAN%20API-DW%20Cloud/src/page/AuningStockOData.Page.al:1)
- [AuningStockFactBox.Page.al](/c:/Users/jespe/OneDrive%20-%20Scanpan/Scanpan%20(7.1.2015)/Development/SCANPAN%20API-DW%20Cloud/src/page/AuningStockFactBox.Page.al:1)
- [DWItemCardAuningStock.PageExt.al](/c:/Users/jespe/OneDrive%20-%20Scanpan/Scanpan (7.1.2015)/Development/SCANPAN%20API-DW%20Cloud/src/page/DWItemCardAuningStock.PageExt.al:1)
- [PerfionItemsOData.Page.al](/c:/Users/jespe/OneDrive%20-%20Scanpan/Scanpan%20(7.1.2015)/Development/SCANPAN%20API-DW%20Cloud/src/page/PerfionItemsOData.Page.al:1)
- [PerfionPricesOData.Page.al](/c:/Users/jespe/OneDrive%20-%20Scanpan/Scanpan%20(7.1.2015)/Development/SCANPAN%20API-DW%20Cloud/src/page/PerfionPricesOData.Page.al:1)
- [PerfionItemsAPI.Page.al](/c:/Users/jespe/OneDrive%20-%20Scanpan/Scanpan%20(7.1.2015)/Development/SCANPAN%20API-DW%20Cloud/src/page/PerfionItemsAPI.Page.al:1)
- [PerfionPricesAPI.Page.al](/c:/Users/jespe/OneDrive%20-%20Scanpan/Scanpan%20(7.1.2015)/Development/SCANPAN%20API-DW%20Cloud/src/page/PerfionPricesAPI.Page.al:1)
- [DWWSRegistrar.Codeunit.al](/c:/Users/jespe/OneDrive%20-%20Scanpan/Scanpan%20(7.1.2015)/Development/SCANPAN%20API-DW%20Cloud/src/codeunit/DWWSRegistrar.Codeunit.al:1)
