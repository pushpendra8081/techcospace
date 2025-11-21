# Personal Health Insights App

## Architecture

- Clean structure under `lib/core`, `lib/data`, `lib/logic`, `lib/presentation`.
- Riverpod providers in `lib/logic/providers` manage metrics, filters, and theme.
- Data loaded from `assets/data/metrics.json` and persisted via `SharedPreferences`.
- UI built with small, pure widgets and animated route transitions.

## Design Decisions

- `flutter_riverpod` without codegen for simpler setup.
- `SharedPreferences` for persistence to avoid Hive adapters.
- `fl_chart` for lightweight line charts and `CustomPainter` for circular indicator.
- Status colors use green, orange, red with adaptive tints in dark mode.

## Assumptions

- Trend is computed from the last two history points.
- Accessibility through `Semantics`, large tap targets, and readable themes.


## Next Features

- Add more metrics and units handling.
- Integrate remote sync.
- Add detailed accessibility audit with Focus traversal.

## Video


https://github.com/user-attachments/assets/c0b92503-32fd-456c-9aa7-524c2e77b58e


