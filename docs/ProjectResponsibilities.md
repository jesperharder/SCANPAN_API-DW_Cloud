# SCANPAN Business Central Project Responsibilities

## Purpose

This document defines which Business Central project owns each environment track and which action belongs in each project. Use it before changing dependencies, symbol setup, or API-DW code so ASIA and Denmark concerns stay separated.

## Project Map

| Project | Responsibility | Dependency Model | Correct Actions |
| --- | --- | --- | --- |
| `SCANPAN API-DW Cloud` | ASIA API-DW extension. | Depends on ASIA-specific apps such as `SCANPAN ASIA`. Must not be changed to depend on KOLLAB/Notora for Denmark. | Use for ASIA cloud symbol download, ASIA build fixes, ASIA endpoint contracts, and ASIA publishing preparation. |
| `SCANPAN API-DW OnPrem` | Denmark API-DW extension for current on-prem and future cloud migration. | May depend on Denmark base apps, including KOLLAB/Notora and SCANPAN internal codebase apps when those apps own required symbols. | Use for Denmark API-DW fixes, Denmark cloud migration work, KOLLAB/Notora alignment, and on-prem-to-cloud compatibility changes. |
| `SCANPAN ASIA` | ASIA-specific base/customization app. | Does not use KOLLAB/Notora. Owns ASIA custom symbols required by ASIA extensions. | Use when ASIA-specific custom fields, tables, or behavior must be added or fixed for ASIA API-DW. |
| `SCANPAN BC25 Domain` | Denmark domain/base project area. | Denmark-oriented dependency context. | Use for Denmark domain modeling and shared DK concepts that are not specific to API-DW. |
| `SCANPAN Internal CodeBase - BC25` | Denmark on-prem internal codebase. | May reference Notora/KOLLAB and other Denmark operational apps. | Use for production-like DK/on-prem internal functionality and dependencies that DK API-DW may consume. |
| `SCANPAN Internal CodeBase - BC25 Test` | Denmark test version of the internal codebase. | Same Denmark dependency family as `SCANPAN Internal CodeBase - BC25`, used for validation and development. | Use for testing DK internal-codebase changes before they move to production or cloud migration work. |

## API-DW Cloud Rule

`SCANPAN API-DW Cloud` means ASIA. Do not use this project to solve Denmark/KOLLAB/Notora dependency issues.

For ASIA symbols and build validation, restore ASIA dependencies in `app.json`, such as:

```json
{
  "id": "6109cdb7-e1d4-47bf-b20c-c06faf83ccd1",
  "name": "SCANPAN ASIA",
  "publisher": "SCANPAN A/S",
  "version": "<installed ASIA version>"
}
```

Add Microsoft dependencies such as `Sustainability` only when the ASIA project source references their symbols.

## API-DW Denmark Rule

`SCANPAN API-DW OnPrem` means Denmark. This is the project to use for current on-prem API-DW and the future Denmark cloud API-DW migration.

For Denmark symbols and build validation, use Denmark dependencies when they own the referenced symbols:

```json
{
  "id": "77f87193-a56f-4872-9844-63c073203c32",
  "name": "SCANPAN Base",
  "publisher": "KOLLAB",
  "version": "<installed DK version>"
}
```

```json
{
  "id": "69ac3231-c282-41ad-963a-6fcf8a96c55d",
  "name": "SCANPAN CODEBASE Internal Development",
  "publisher": "SCANPAN",
  "version": "<installed DK version>"
}
```

These Denmark dependencies do not belong in `SCANPAN API-DW Cloud` unless the project responsibility is explicitly changed.

## Decision Rules

- If the task mentions ASIA cloud, ASIA symbols, or `SCANPAN ASIA`, work in `SCANPAN API-DW Cloud` or `SCANPAN ASIA`.
- If the task mentions Denmark, DK, on-prem, KOLLAB, Notora, or internal codebase dependencies, work in `SCANPAN API-DW OnPrem`, `SCANPAN Internal CodeBase - BC25`, or `SCANPAN Internal CodeBase - BC25 Test`.
- If an API-DW field is missing during compile, first identify which base app owns the field in that environment before changing source code.
- Do not remove environment-specific dependencies to make `app.json` generic. A generic manifest is only valid when the source references only symbols that exist in all target environments.
- Do not mix ASIA and Denmark dependencies in one API-DW manifest unless the same extension is intentionally being redesigned to target both environments.

## Symbol Workflow

1. Select the project based on the environment responsibility above.
2. Set `app.json` dependencies to the apps that own the referenced symbols in that environment.
3. Download symbols from the matching Business Central environment or from a verified local/global symbol source.
4. Build the project.
5. Treat remaining compiler diagnostics as code issues only after dependency ownership is correct.
