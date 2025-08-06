import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/sort_algorithm.dart';
import 'algorithm_chip.dart';

class AlgorithmSelector extends ConsumerWidget {
  const AlgorithmSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: SortAlgorithm.values.map((algorithm) {
          return AlgorithmChip(algorithm: algorithm);
        }).toList(),
      ),
    );
  }
}
