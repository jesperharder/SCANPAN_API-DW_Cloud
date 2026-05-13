# Workspace Memory

## Current State
- `SCANPAN API-DW Cloud International` is the Business Central Cloud AL extension exposing data warehouse OData exports for USA, Singapore, China, and Japan.
- `SCANPAN API-DW Cloud` is the Denmark/Norway BC Cloud API-DW project created from the OnPrem baseline.
- `SCANPAN API-DW OnPrem` remains the on-prem API-DW project.
- `SCANPAN ASIA` is ASIA-specific and does not use KOLLAB/Notora dependencies.
- `SCANPAN Internal CodeBase - BC25` and `SCANPAN Internal CodeBase - BC25 Test` are Denmark/on-prem projects moving toward cloud and may reference Notora/KOLLAB apps.
- Permanent project responsibility and action mapping is documented in `docs\ProjectResponsibilities.md`.
- `.vscode\launch.json` contains a `SCANPAN Cloud` launch profile for the Business Central SaaS production environment `SCANPAN`.
- The project currently targets Business Central 28.0 with AL runtime 17.0.
- Workspace AL symbol downloads are isolated to `.alpackages-bc28` through `.vscode\settings.json`.
- Active operational OData endpoints are `AuningStockDW`, `PerfionItemsDW`, and `PerfionPricesDW`.
- Publication is centralized in `src\codeunit\DWWSRegistrar.Codeunit.al`.
- Endpoint system and operational documentation is maintained in:
  - `docs\IntegrationEndpoints.md`
  - `docs\IntegrationEndpoints.Readable.html`
  - `docs\IntegrationEndpoints.pdf`
- Perfion price-field contract is maintained in `docs\PerfionPriceFields.md`.

## Verified Contracts
- `AuningStockDW` is a stored item stock snapshot for location `AUNING`, inventory items, and `Gen. Prod. Posting Group = INTERN|EKSTERN|BRUND`.
- AUNING stock Job Queue parameters are `GenProdPostingGroupFilter` and `AvailableReductionPct`.
- AUNING stock quantities are rounded down to whole numbers and clamped to `0`.
- `PerfionItemsDW` is a direct OData export over `Item` enriched from item references, translations, and units of measure.
- `PerfionPricesDW` returns one temporary row per item with fixed pivot fields for 20 configured source/currency/UoM combinations.
- `WEB_NO` Perfion prices are read from company `SCANPAN Norge`; other Perfion price combinations are read from the current company.
- Perfion normal and campaign price selection uses lowest `Minimum Quantity`, then latest `Starting Date`, then lowest nonzero `Unit Price`.
- Perfion recommended price reads NOTO/KOLLAB `Price List Line` field `51003` through `RecordRef`.
- Perfion campaign matching reads NOTO/KOLLAB `Campaign` field `51001` through `RecordRef`.

## Blockers And Risks
- BC28 symbols download successfully from `SandboxDK` and from AL global NuGet sources into `.alpackages-bc28`.
- BC28 cloud symbol download currently fails server-side for Microsoft `System` and `Application` 28.0.0.0 from the `SCANPAN` and `Asia` production environments, even after successful tenant authentication.
- Current ASIA BC28 build fails after symbol download because `app.json` has `dependencies: []` while the source still references non-base ASIA symbols and `Sustainability Setup`.
- The working tree currently contains pre-existing uncommitted changes; inspect status before further edits.

## Next Checks
- Restore required ASIA BC28 dependencies for non-base symbols before treating remaining build diagnostics as code issues.
- If production symbol download still fails after dependency cleanup, use the captured request IDs for a Microsoft support case.
- Before endpoint changes, compare implementation, `DWWSRegistrar`, permissionsets, and `docs`.
- Before Perfion price changes, compare `src\page\PerfionPricesOData.Page.al` with `docs\PerfionPriceFields.md`.
- After AL object changes, refresh the central BC object inventory when practical.
