import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/sorting_providers.dart';
import '../painters/array_bars_painter.dart';

class SortingVisualizer extends ConsumerStatefulWidget {
  const SortingVisualizer({super.key});

  @override
  ConsumerState<SortingVisualizer> createState() => _SortingVisualizerState();
}

class _SortingVisualizerState extends ConsumerState<SortingVisualizer> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sortingState = ref.watch(sortingControllerProvider);
    final controller = ref.read(sortingControllerProvider.notifier);
    final selectedAlgorithm = ref.watch(selectedAlgorithmProvider);

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
          // Stats bar
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _StatItem(
                      label: 'Algorithm',
                      value: selectedAlgorithm.displayName,
                      icon: Icons.memory,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    _StatItem(
                      label: 'Comparisons',
                      value: sortingState.totalComparisons.toString(),
                      icon: Icons.compare_arrows,
                      color: Colors.blue,
                    ),
                    _StatItem(
                      label: 'Swaps',
                      value: sortingState.totalSwaps.toString(),
                      icon: Icons.swap_horiz,
                      color: Colors.orange,
                    ),
                    _StatItem(
                      label: 'Elements',
                      value: sortingState.elements.length.toString(),
                      icon: Icons.data_array,
                      color: Colors.green,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Progress bar
                LinearProgressIndicator(
                  value: controller.progress,
                  backgroundColor: Colors.grey.shade300,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    sortingState.isSorted ? Colors.green : Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return CustomPaint(
                    painter: ArrayBarsPainter(
                      elements: sortingState.elements,
                      animationValue: _animationController.value,
                    ),
                    size: Size.infinite,
                  );
                },
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.2),
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
            ),
            child: Column(
              children: [
                Text(
                      sortingState.currentOperation,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
                    )
                    .animate(onPlay: (controller) => controller.repeat())
                    .shimmer(
                      duration: 2000.ms,
                      color: sortingState.isPlaying
                          ? Theme.of(context).colorScheme.primary.withOpacity(0.3)
                          : Colors.transparent,
                    ),
                const SizedBox(height: 4),
                Text(
                  'Step ${sortingState.currentStep} of ${controller.totalSteps}',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
          ),
        ],
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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
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
