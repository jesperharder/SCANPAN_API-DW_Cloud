# Project AGENTS.md

## Scope
- These rules apply to the full `SCANPAN API-DW Cloud International` repository.
- This project is the BC Cloud API-DW project for the international companies: USA, Singapore, China, and Japan.
- Read `MEMORY.md` before project work and update it only when current project state changes.
- Keep stable project rules in this file. Move repeated Memory rules here when they become permanent.

## Repository Structure
- `app.json` defines the Business Central extension metadata, dependencies, platform/runtime, features, and object ID range.
- `src\page` contains OData/API pages and page extensions.
- `src\codeunit` contains install/upgrade/web-service registration and operational processing codeunits.
- `src\table` contains table extensions.
- `src\permissionset` contains integration permission sets.
- `docs` contains endpoint and field-contract documentation.
- `docs\ProjectResponsibilities.md` defines which SCANPAN BC project owns ASIA, Denmark, KOLLAB/Notora, and internal-codebase work. Read it before changing dependencies, symbols, or choosing a repo for API-DW work.
- `Translations` contains generated translation artifacts.

## Business Central / AL Rules
- This is a Business Central AL extension named `SCANPAN Data Warehouse API`.
- Use object IDs only within the project range declared in `app.json`: `50200..50399`.
- Before proposing or creating new AL object IDs, read the central BC object registry files under `C:\Users\jespe\.codex\memories`.
- After AL object changes in this registered BC project, refresh the central BC object inventory with `C:\Users\jespe\.codex\memories\bc-refresh-object-inventory.ps1` when practical.
- Preserve `NoImplicitWith` compatibility and the runtime/platform constraints from `app.json`.
- Keep OData pages read-only unless a task explicitly requires write behavior.
- Publish or rename web service endpoints through `src\codeunit\DWWSRegistrar.Codeunit.al`.
- Do not change published service names, OData field names, or integration filters without updating the relevant contract documentation in `docs`.
- Keep Perfion price-field changes aligned with `docs\PerfionPriceFields.md`.
- Use explicit AL errors for missing required integration dependencies or unsupported data conditions.

## Validation
- Run the relevant AL compile/package validation when the local Business Central toolchain or container is available.
- If AL compile/package validation is not available, state that explicitly and run targeted static checks instead.
- For endpoint contract changes, verify that implementation, web-service registrar entries, permissionsets, and `docs` agree.
- For generated documentation outputs, regenerate all maintained formats together when the source contract changes.

## Git Rules
- Use non-interactive git commands.
- Use `git --no-pager diff` or `git diff | cat` for diffs.
- Inspect `git --no-pager status --short` before editing.
- Do not revert unrelated working tree changes.
- Keep commits focused on the requested project change.

## Access And Workflow
- Do not store secrets, tokens, service credentials, or temporary access notes in this repo.
- Keep environment-specific operational access details outside tracked project files.
- Treat `MEMORY.md` as current state only, not a changelog.
- Before broad cross-project or expensive context gathering, warn that the thread is becoming broad and recommend a new thread.
