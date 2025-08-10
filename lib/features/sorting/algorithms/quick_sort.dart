import '../models/sort_step.dart';

class QuickSort {
  static List<SortStep> generateSteps(List<int> values) {
    final steps = <SortStep>[];
    final array = List<int>.from(values);

    // Initial state
    steps.add(SortStep(array: List.from(array), description: 'Starting Quick Sort'));

    _quickSortHelper(array, 0, array.length - 1, steps, []);

    // Final sorted state
    steps.add(
      SortStep(
        array: List.from(array),
        sortedIndices: List.generate(array.length, (i) => i),
        description: 'Array is sorted!',
        isFinal: true,
      ),
    );

    return steps;
  }

  static void _quickSortHelper(List<int> array, int low, int high, List<SortStep> steps, List<int> sortedIndices) {
    if (low < high) {
      final pivotIndex = _partition(array, low, high, steps, sortedIndices);
      sortedIndices.add(pivotIndex);

      _quickSortHelper(array, low, pivotIndex - 1, steps, sortedIndices);
      _quickSortHelper(array, pivotIndex + 1, high, steps, sortedIndices);
    }
  }

  static int _partition(List<int> array, int low, int high, List<SortStep> steps, List<int> sortedIndices) {
    final pivot = array[high];
    var i = low - 1;

    // Show pivot selection
    steps.add(
      SortStep(
        array: List.from(array),
        sortedIndices: List.from(sortedIndices),
        pivotIndices: [high],
        description: 'Pivot selected: $pivot',
      ),
    );

    for (var j = low; j < high; j++) {
      // Comparing with pivot
      steps.add(
        SortStep(
          array: List.from(array),
          comparingIndices: [j, high],
          sortedIndices: List.from(sortedIndices),
          pivotIndices: [high],
          description: 'Comparing ${array[j]} with pivot $pivot',
        ),
      );

      if (array[j] < pivot) {
        i++;
        array.swap(i, j);

        if (i != j) {
          steps.add(
            SortStep(
              array: List.from(array),
              swappingIndices: [i, j],
              sortedIndices: List.from(sortedIndices),
              pivotIndices: [high],
              description: 'Swapping ${array[i]} and ${array[j]}',
            ),
          );
        }
      }
    }

    // Place pivot in correct position
    i++;
    array.swap(i, high);

    steps.add(
      SortStep(
        array: List.from(array),
        swappingIndices: [i, high],
        sortedIndices: List.from(sortedIndices),
        pivotIndices: [i],
        description: 'Pivot placed at position $i',
      ),
    );

    return i;
  }
}

extension _ListSwap on List<int> {
  void swap(int a, int b) {
    final tmp = this[a];
    this[a] = this[b];
    this[b] = tmp;
  }
}
