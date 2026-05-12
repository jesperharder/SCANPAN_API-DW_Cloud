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

Perfion integrations are exposed only through the OData pages.

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

### Dataset construction

The page uses a temporary `Price List Line` dataset and exposes one row per item.

Flow:

1. clear temporary rows
2. load active customer price group rows valid for today
3. restrict rows to the exposed source/currency/UoM price combinations
4. apply incoming item filter where relevant
5. keep one item row where the source price line has the lowest `Minimum Quantity`
6. populate fixed pivot fields for each of the 20 configured source/currency/UoM combinations

`WEB_NO` is read from company `SCANPAN Norge`. The other price combinations are read from the current company.

For each combination the page exposes:

- `price*`
- `recommendedPrice*`
- `campaignPrice*`

Recommended price is read from NOTO/KOLLAB `Price List Line` field 51003 through `RecordRef`.

Campaign price matching reads NOTO/KOLLAB `Campaign` field 51001 through `RecordRef` and compares it to the customer price group.

### Source tables

- `Price List Line`
- `Campaign`

### Design note

The endpoint deliberately does not expose tier-price rows. It returns the active line with the lowest `Minimum Quantity` for each item and pivoted price combination.

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
if Candidate."Minimum Quantity" <> Existing."Minimum Quantity" then
    exit(Candidate."Minimum Quantity" < Existing."Minimum Quantity");

if Candidate."Starting Date" <> Existing."Starting Date" then
    exit(Candidate."Starting Date" > Existing."Starting Date");

if Existing."Unit Price" = 0 then
    exit(Candidate."Unit Price" <> 0);
if Candidate."Unit Price" = 0 then
    exit(false);

exit(Candidate."Unit Price" < Existing."Unit Price");
```

This means:

- lowest minimum quantity wins
- later valid start date wins when minimum quantity is identical
- lower nonzero price wins on identical minimum quantity and start date

## Files

Main implementation files:

- [AuningStockUpdate.Codeunit.al](/c:/Users/jespe/OneDrive%20-%20Scanpan/Scanpan%20(7.1.2015)/Development/SCANPAN%20API-DW%20Cloud/src/codeunit/AuningStockUpdate.Codeunit.al:1)
- [DWItemAuningStock.TableExt.al](/c:/Users/jespe/OneDrive%20-%20Scanpan/Scanpan%20(7.1.2015)/Development/SCANPAN%20API-DW%20Cloud/src/table/DWItemAuningStock.TableExt.al:1)
- [AuningStockOData.Page.al](/c:/Users/jespe/OneDrive%20-%20Scanpan/Scanpan%20(7.1.2015)/Development/SCANPAN%20API-DW%20Cloud/src/page/AuningStockOData.Page.al:1)
- [AuningStockFactBox.Page.al](/c:/Users/jespe/OneDrive%20-%20Scanpan/Scanpan%20(7.1.2015)/Development/SCANPAN%20API-DW%20Cloud/src/page/AuningStockFactBox.Page.al:1)
- [DWItemCardAuningStock.PageExt.al](/c:/Users/jespe/OneDrive%20-%20Scanpan/Scanpan (7.1.2015)/Development/SCANPAN%20API-DW%20Cloud/src/page/DWItemCardAuningStock.PageExt.al:1)
- [PerfionItemsOData.Page.al](/c:/Users/jespe/OneDrive%20-%20Scanpan/Scanpan%20(7.1.2015)/Development/SCANPAN%20API-DW%20Cloud/src/page/PerfionItemsOData.Page.al:1)
- [PerfionPricesOData.Page.al](/c:/Users/jespe/OneDrive%20-%20Scanpan/Scanpan%20(7.1.2015)/Development/SCANPAN%20API-DW%20Cloud/src/page/PerfionPricesOData.Page.al:1)
- [PerfionPriceFields.md](/c:/Users/jespe/OneDrive%20-%20Scanpan/Scanpan%20(7.1.2015)/Development/SCANPAN%20API-DW%20Cloud/docs/PerfionPriceFields.md:1)
- [DWWSRegistrar.Codeunit.al](/c:/Users/jespe/OneDrive%20-%20Scanpan/Scanpan%20(7.1.2015)/Development/SCANPAN%20API-DW%20Cloud/src/codeunit/DWWSRegistrar.Codeunit.al:1)
