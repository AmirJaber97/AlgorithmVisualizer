import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/sorting_providers.dart';

class SortingControls extends ConsumerWidget {
  const SortingControls({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sortingState = ref.watch(sortingControllerProvider);
    final controller = ref.read(sortingControllerProvider.notifier);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: sortingState.isPlaying ? null : controller.stepBackward,
            icon: const Icon(Icons.skip_previous),
            tooltip: 'Step Backward',
          ),
          const SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: sortingState.isPlaying
                    ? [Colors.orange.shade400, Colors.orange.shade600]
                    : [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.primaryContainer],
              ),
              boxShadow: [
                BoxShadow(
                  color: (sortingState.isPlaying ? Colors.orange : Theme.of(context).colorScheme.primary).withOpacity(
                    0.3,
                  ),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              onPressed: sortingState.isPlaying ? controller.pause : controller.play,
              icon: Icon(sortingState.isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white),
              tooltip: sortingState.isPlaying ? 'Pause' : 'Play',
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: sortingState.isPlaying ? null : controller.stepForward,
            icon: const Icon(Icons.skip_next),
            tooltip: 'Step Forward',
          ),
          const SizedBox(width: 16),
          IconButton(onPressed: controller.reset, icon: const Icon(Icons.refresh), tooltip: 'Reset'),
          IconButton(
            onPressed: sortingState.isPlaying ? null : controller.shuffle,
            icon: const Icon(Icons.shuffle),
            tooltip: 'Shuffle Array',
          ),
        ],
      ),
    );
  }
}
