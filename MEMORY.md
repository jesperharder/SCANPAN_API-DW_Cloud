# Workspace Memory

## Purpose
- Keep the current-state notes for `SCANPAN API-DW Cloud`.
- Capture project-specific integration and object-governance decisions.

## Integration Endpoints
- Operational OData endpoints in this repo currently include:
  - `AuningStockDW`
  - `PerfionItemsDW`
  - `PerfionPricesDW`
- Perfion custom API pages are retained alongside the OData pages:
  - `PerfionItemsAPI`
  - `PerfionPricesAPI`
- Publication is handled through `src\codeunit\DWWSRegistrar.Codeunit.al`.

## AUNING Stock
- AUNING stock snapshot is implemented in this repo with:
  - `tableextension 50231 "DW Item Auning Stock"`
  - `codeunit 50293 "Auning Stock Update"`
  - `page 50233 "AuningStockOData"`
  - `page 50237 "AuningStockFactBox"`
  - `pageextension 50232 "DW Item Card Auning Stock"`
  - `permissionset 50231 "AUNING STOCK READ"`
- Stock snapshot is scoped to:
  - location `AUNING`
  - inventory items
  - `Gen. Prod. Posting Group = INTERN|EKSTERN|BRUND`
- Job Queue parameters:
  - `GenProdPostingGroupFilter=INTERN|EKSTERN|BRUND`
  - `AvailableReductionPct=<decimal>`
- Quantities are rounded down to whole numbers and clamped to `0`.

## Perfion
- `PerfionItemsDW` is a direct OData export over `Item` with enrichment from:
  - `Item Reference`
  - `Item Translation`
  - `Item Unit of Measure`
- `PerfionPricesDW` builds a temporary curated dataset from `Price List Line`.
- In this cloud repo, the campaign matching code in `PerfionPricesOData` is currently commented out.
  - Result: `campaignPrice` stays `0`
  - Result: `campaignId` stays blank

## Documentation
- System and operational documentation for the three OData endpoints lives in:
  - `docs\IntegrationEndpoints.md`
  - `docs\IntegrationEndpoints.Readable.html`
  - `docs\IntegrationEndpoints.pdf`
