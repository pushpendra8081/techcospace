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

- Value range slider uses dataset min/max across metrics.
- Trend is computed from the last two history points.
- Accessibility through `Semantics`, large tap targets, and readable themes.

## Testing

- Unit tests for model parsing, status mapping, and filters.
- Widget tests for card rendering, list display, search updates, and theme toggling.

## Additional Features

- Shimmer loading for dashboard list.
- Animated filter chips with scale interaction.
- Hero animations on metric cards.

## Sample UI

```
┌───────────────────────────────────────────────┐
│ Health Metrics • Alex Chen                    │
├───────────────────────────────────────────────┤
│ Last updated 2024-01-15                      │
│ [ Search metrics ..................... ]     │
│ [Low] [Normal] [High]  Slider [───●────]     │
│                                               │
│ ▣ Hemoglobin     9.5 g/dL   [Low]             │
│   Range 12 - 16                                │
│                                               │
│ ▣ Vitamin D     20 ng/mL   [Low]              │
│   Range 30 - 80                                │
│                                               │
│ ▣ Fasting Glucose 138 mg/dL [High]            │
│   Range 70 - 100                               │
└───────────────────────────────────────────────┘
```

## Next Steps

- Add more metrics and units handling.
- Integrate remote sync.
- Add detailed accessibility audit with Focus traversal.