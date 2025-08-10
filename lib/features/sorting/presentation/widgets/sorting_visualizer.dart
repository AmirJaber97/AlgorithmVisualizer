import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../models/sort_element.dart';
import '../../providers/sorting_providers.dart';

class SortingVisualizer extends ConsumerWidget {
  const SortingVisualizer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sortingState = ref.watch(sortingControllerProvider);
    final controller = ref.read(sortingControllerProvider.notifier);
    final selectedAlgorithm = ref.watch(selectedAlgorithmProvider);
    final speed = ref.watch(animationSpeedProvider);
    final elements = sortingState.elements;
    final maxVal = elements.map((e) => e.value).reduce(max);
    final isSorted = sortingState.isSorted;

    final defaultColor = AppColors.defaultBar;
    final comparingColor = AppColors.comparing;
    final swappingColor = AppColors.swapping;
    final mergingColor = AppColors.merging;
    final sortedColor = AppColors.sorted;

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: SizedBox(
              height: 56,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: [
                    _StatItem(
                      label: 'Algorithm',
                      value: selectedAlgorithm.displayName,
                      icon: Icons.memory,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 16),
                    _StatItem(
                      label: 'Comparisons',
                      value: sortingState.totalComparisons.toString(),
                      icon: Icons.compare_arrows,
                      color: comparingColor,
                    ),
                    const SizedBox(width: 16),
                    _StatItem(
                      label: 'Swaps',
                      value: sortingState.totalSwaps.toString(),
                      icon: Icons.swap_horiz,
                      color: swappingColor,
                    ),
                    const SizedBox(width: 16),
                    _StatItem(
                      label: 'Elements',
                      value: elements.length.toString(),
                      icon: Icons.data_array,
                      color: Colors.teal,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final barWidth = constraints.maxWidth / elements.length;
                  final chartHeight = constraints.maxHeight;
                  return Stack(
                    children: [
                      for (final element in elements)
                        BarWidget(
                          element: element,
                          barWidth: barWidth,
                          maxHeight: chartHeight,
                          animationSpeed: speed,
                          maxValue: maxVal,
                          defaultColor: defaultColor,
                          comparingColor: comparingColor,
                          swappingColor: swappingColor,
                          mergingColor: mergingColor,
                          sortedColor: sortedColor,
                          isSorted: isSorted,
                        ),
                    ],
                  );
                },
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.2),
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
            ),
            child: Row(
              children: [
                Expanded(
                  child:
                      Text(
                            sortingState.currentOperation,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                          )
                          .animate(onPlay: (c) => c.repeat())
                          .shimmer(
                            duration: 2000.ms,
                            color: sortingState.isPlaying
                                ? Theme.of(context).colorScheme.primary.withOpacity(0.3)
                                : Colors.transparent,
                          ),
                ),
                Row(
                  children: [
                    Text(
                      'Step ${sortingState.currentStep} / ${controller.totalSteps}',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.help_outline, size: 20),
                      tooltip: 'Show legend',
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text('Visualization Legend'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _LegendItem(color: defaultColor, label: 'Default bar'),
                                _LegendItem(color: comparingColor, label: 'Comparing'),
                                _LegendItem(color: swappingColor, label: 'Swapping'),
                                _LegendItem(color: mergingColor, label: 'Merging'),
                                _LegendItem(color: sortedColor, label: 'Sorted'),
                              ],
                            ),
                            actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BarWidget extends StatelessWidget {
  final SortElement element;
  final double barWidth;
  final double maxHeight;
  final double animationSpeed;
  final int maxValue;
  final Color defaultColor;
  final Color comparingColor;
  final Color swappingColor;
  final Color mergingColor;
  final Color sortedColor;
  final bool isSorted;

  const BarWidget({
    super.key,
    required this.element,
    required this.barWidth,
    required this.maxHeight,
    required this.animationSpeed,
    required this.maxValue,
    required this.defaultColor,
    required this.comparingColor,
    required this.swappingColor,
    required this.mergingColor,
    required this.sortedColor,
    required this.isSorted,
  });

  @override
  Widget build(BuildContext context) {
    final height = (element.value / maxValue) * maxHeight;
    final duration = Duration(milliseconds: (300 * (1 - animationSpeed)).clamp(50, 300).toInt());

    final barColor = isSorted
        ? sortedColor
        : element.isSwapping
        ? swappingColor
        : element.isMerging
        ? mergingColor
        : element.isComparing
        ? comparingColor
        : defaultColor;

    return AnimatedPositioned(
      duration: duration,
      curve: Curves.easeInOut,
      left: element.index * barWidth,
      top: maxHeight - height,
      child: AnimatedContainer(
        duration: duration,
        curve: Curves.easeInOut,
        width: barWidth * 0.8,
        height: height,
        decoration: BoxDecoration(color: barColor, borderRadius: BorderRadius.circular(4)),
        alignment: Alignment.topCenter,
        child: barWidth > 30
            ? Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  element.value.toString(),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.bold,
                    fontSize: barWidth * 0.3,
                  ),
                ),
              )
            : null,
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatItem({required this.label, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(
                  context,
                ).textTheme.labelSmall?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
              Text(
                value,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold, color: color),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
          ),
          const SizedBox(width: 8),
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
