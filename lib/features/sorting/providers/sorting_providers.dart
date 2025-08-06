import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/sort_algorithm.dart';
import '../models/sorting_state.dart';
import 'sorting_controller.dart';

final sortingControllerProvider = StateNotifierProvider<SortingController, SortingState>((ref) {
  return SortingController();
});

final animationSpeedProvider = StateProvider<double>((ref) => 0.5);

final arraySizeProvider = StateProvider<int>((ref) => 50);

final selectedAlgorithmProvider = StateProvider<SortAlgorithm>((ref) {
  return SortAlgorithm.bubbleSort;
});
