# PNGTuber-Plus (Entrak Fork)

This is a maintained fork of PNGTuber-Plus focused on general stability, cleanup, and quality-of-life improvements while keeping the original workflow.

- Original project: https://github.com/kaiakairos/PNGTuber-Plus
- This fork: https://github.com/Entrak/PNGTuber-Plus

## What's Different in This Fork

- General codebase modernization and cleanup.
- Improved save/settings reliability with backward compatibility.
- Better startup/runtime safety and reduced warning noise.
- Added lightweight smoke-test tooling for validation.

## Requirements

- Godot 4.x (4.6.x recommended).
- Optional: VS Code + `godot-tools`.

## Quick Start

1. Clone the repository.
2. Open the project in Godot.
3. Run the main scene.
4. On first run, a default avatar is loaded automatically.

## Basic Usage

1. Use Add to import PNG parts.
2. Arrange and tune sprites in edit mode.
3. Use Save to export an avatar file.
4. Use Load to reopen an existing avatar.
5. Use Settings to customize behavior and appearance.

## Data and Recovery

- App settings are saved to `user://settings.pngtp`.
- Session recovery data is saved to `user://session.pngtp`.

## Validation

Smoke tests are included under `test/` and can be run from VS Code tasks or manually:

```powershell
pwsh -NoProfile -ExecutionPolicy Bypass -File "test/integration_smoke.ps1"
```

## Credits

- Original project: kaiakairos
- Fork maintenance: Entrak
