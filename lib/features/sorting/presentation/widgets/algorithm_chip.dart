import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/sort_algorithm.dart';
import '../../providers/sorting_providers.dart';

class AlgorithmChip extends ConsumerWidget {
  final SortAlgorithm algorithm;

  const AlgorithmChip({super.key, required this.algorithm});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedAlgorithm = ref.watch(selectedAlgorithmProvider);
    final controller = ref.read(sortingControllerProvider.notifier);
    final isSelected = selectedAlgorithm == algorithm;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(algorithm.displayName),
        selected: isSelected,
        onSelected: (value) {
          if (value) {
            ref.read(selectedAlgorithmProvider.notifier).state = algorithm;
            controller.setAlgorithm(algorithm);
          }
        },
        backgroundColor: isSelected ? Theme.of(context).colorScheme.primaryContainer : null,
        selectedColor: Theme.of(context).colorScheme.primaryContainer,
        checkmarkColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
