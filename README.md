# PNGTuber-Plus (Entrak Fork)

This repository is a modernization fork of the original PNGTuber-Plus project by kaiakairos.

- Original project: https://github.com/kaiakairos/PNGTuber-Plus
- This fork: https://github.com/Entrak/PNGTuber-Plus

## What This Fork Changes

This fork keeps the original behavior and workflow, while improving project reliability and maintainability.

### 1) Save and Settings Modernization
- Added structured save payloads with schema versioning for safer future migrations.
- Added backward compatibility for older avatar files and legacy settings formats.
- Migrated fragile `var_to_str` settings fields (window size and background color) to structured JSON-style data.

### 2) Runtime Safety Improvements
- Added null-safety guards around main scene references used during startup/headless paths.
- Fixed startup-sensitive behavior in sprite setup to reduce initialization issues.
- Reduced shader warnings by removing unused uniforms/locals.

### 3) Testing and Validation Tooling
- Added script smoke testing and integration smoke testing support.
- Added VS Code tasks for quick validation runs.
- Added automated startup error checks for script compilation/runtime startup failures.

### 4) Quality and Architecture Cleanup
- Added centralized constants for magic numbers.
- Improved error handling for save/write paths and file operations.
- Improved settings serialization helpers and migration behavior.

### 5) Extended Behavior in This Fork
- Added periodic session auto-save infrastructure (60 second interval).
- Added configurable costume layer sizing helpers (while preserving compatibility).

## Engine Version

- Recommended: Godot 4.6.x
- Project compatibility target remains Godot 4.x.

If you use VS Code with `godot-tools`, set your Godot executable path in `.vscode/settings.json`.

## Quick Start

1. Clone the repository.
2. Open the project folder in Godot.
3. Run the main scene.
4. On first launch, the app loads the default avatar automatically.

## Basic Usage

1. Add PNG parts:
	- Use the Add button to import sprite images.
2. Arrange your avatar:
	- Drag parts into place.
	- Adjust layering, wobble, blink/talk visibility, and other per-sprite options.
3. Save your avatar:
	- Use Save to write a `.pngtp` avatar file.
4. Load an avatar:
	- Use Load to reopen a previously saved `.pngtp` file.
5. Configure app settings:
	- Open Settings to adjust FPS, background color, filtering, bounce, blink behavior, and costume keys.

## Session and Persistence Notes

- Settings are stored in `user://settings.pngtp`.
- A session recovery save is written periodically to `user://session.pngtp`.
- Avatar saves use schema-aware serialization and still load older formats.

## Validation / Smoke Tests

This fork includes smoke tests under `test/`.

From VS Code tasks (recommended):
- Godot: Script Smoke Test
- Godot: Headless Startup Smoke
- Godot: Integration Smoke Test

Or run integration smoke directly:

```powershell
pwsh -NoProfile -ExecutionPolicy Bypass -File "test/integration_smoke.ps1"
```

## Repository Hygiene

The `.gitignore` in this fork excludes generated files such as:
- Godot cache/export folders
- Generated metadata (`*.uid`)
- Temporary local logs (`test/*.log`)
- Temporary local binaries (`*~lib*.dll`)

## Credits

- Original project and concept: kaiakairos
- Fork modernization and maintenance: Entrak
