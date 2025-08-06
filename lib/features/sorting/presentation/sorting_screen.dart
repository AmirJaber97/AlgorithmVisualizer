import 'package:algorithm_visualizer/features/sorting/presentation/widgets/array_size_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'widgets/algorithm_selector.dart';
import 'widgets/sorting_controls.dart';
import 'widgets/sorting_visualizer.dart';
import 'widgets/speed_control.dart';

class SortingScreen extends ConsumerWidget {
  const SortingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sorting Algorithms')),
      body: Column(
        children: [
          const AlgorithmSelector(),
          const Expanded(child: SortingVisualizer()),
          Container(
            padding: const EdgeInsets.all(16),
            child: const Column(
              children: [SortingControls(), SizedBox(height: 16), SpeedControl(), ArraySizeControl()],
            ),
          ),
        ],
      ),
    );
  }
}
