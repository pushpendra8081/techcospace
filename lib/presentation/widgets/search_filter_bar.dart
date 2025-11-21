import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/utils/constants.dart';
import '../../data/models/metric.dart';
import '../../logic/providers/metrics_providers.dart';

class SearchFilterBar extends ConsumerWidget {
  const SearchFilterBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(searchQueryProvider);
    final stats = ref.watch(metricsStatsProvider);
    final statusSet = ref.watch(statusFilterProvider);
    final range = ref.watch(valueRangeFilterProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: 'Search metrics',
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.4),
            border: OutlineInputBorder(borderRadius: AppRadius.soft, borderSide: BorderSide.none),
          ),
          onChanged: (v) => ref.read(searchQueryProvider.notifier).state = v,
        ),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.xs,
          runSpacing: AppSpacing.xs,
          children: [
            _FilterChip(
              label: 'Low',
              selected: statusSet.contains(MetricStatus.low),
              onSelected: (s) {
                final set = {...statusSet};
                s ? set.add(MetricStatus.low) : set.remove(MetricStatus.low);
                ref.read(statusFilterProvider.notifier).state = set;
              },
            ),
            _FilterChip(
              label: 'Normal',
              selected: statusSet.contains(MetricStatus.normal),
              onSelected: (s) {
                final set = {...statusSet};
                s ? set.add(MetricStatus.normal) : set.remove(MetricStatus.normal);
                ref.read(statusFilterProvider.notifier).state = set;
              },
            ),
            _FilterChip(
              label: 'High',
              selected: statusSet.contains(MetricStatus.high),
              onSelected: (s) {
                final set = {...statusSet};
                s ? set.add(MetricStatus.high) : set.remove(MetricStatus.high);
                ref.read(statusFilterProvider.notifier).state = set;
              },
            ),
          ],
        ),
        if (stats != null) ...[
          const SizedBox(height: AppSpacing.sm),
          // AnimatedSize(
          //   duration: AppDurations.normal,
          //   child: Container(
          //     padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
          //     decoration: BoxDecoration(
          //       color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
          //       borderRadius: AppRadius.soft,
          //     ),
          //     child: Row(
          //       children: [
          //         Expanded(
          //           child: RangeSlider(
          //             min: stats.$1,
          //             max: stats.$2,
          //             values: RangeValues(
          //               range?.$1 ?? stats.$1,
          //               range?.$2 ?? stats.$2,
          //             ),
          //             onChanged: (v) => ref.read(valueRangeFilterProvider.notifier).state = (v.start, v.end),
          //           ),
          //         ),
          //         IconButton(
          //           onPressed: () {
          //             ref.read(searchQueryProvider.notifier).state = '';
          //             ref.read(statusFilterProvider.notifier).state = {};
          //             ref.read(valueRangeFilterProvider.notifier).state = null;
          //           },
          //           icon: const Icon(Icons.clear_all),
          //           tooltip: 'Reset',
          //         )
          //       ],
          //     ),
          //   ),
          // )
        ]
      ],
    );
  }
}

class _FilterChip extends StatefulWidget {
  final String label;
  final bool selected;
  final ValueChanged<bool> onSelected;
  const _FilterChip({required this.label, required this.selected, required this.onSelected});

  @override
  State<_FilterChip> createState() => _FilterChipState();
}

class _FilterChipState extends State<_FilterChip> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: AppDurations.fast);
    _scale = Tween(begin: 1.0, end: 0.96).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapCancel: () => _controller.reverse(),
      onTapUp: (_) => _controller.reverse(),
      onTap: () => widget.onSelected(!widget.selected),
      child: ScaleTransition(
        scale: _scale,
        child: FilterChip(
          label: Text(widget.label),
          selected: widget.selected,
          onSelected: widget.onSelected,
          showCheckmark: false,
        ),
      ),
    );
  }
}