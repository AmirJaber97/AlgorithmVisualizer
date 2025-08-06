import '../models/sort_step.dart';

class QuickSort {
  static List<SortStep> generateSteps(List<int> values) {
    final steps = <SortStep>[];
    final array = List<int>.from(values);

    // Initial state
    steps.add(
      SortStep(
        array: List.from(array),
        comparingIndices: [],
        swappingIndices: [],
        sortedIndices: [],
        description: 'Starting Quick Sort',
      ),
    );

    _quickSortHelper(array, 0, array.length - 1, steps, []);

    // Final sorted state
    steps.add(
      SortStep(
        array: List.from(array),
        comparingIndices: [],
        swappingIndices: [],
        sortedIndices: List.generate(array.length, (i) => i),
        description: 'Array is sorted!',
        isFinal: true,
      ),
    );

    return steps;
  }

  static void _quickSortHelper(List<int> array, int low, int high, List<SortStep> steps, List<int> sortedIndices) {
    if (low < high) {
      int pivotIndex = _partition(array, low, high, steps, sortedIndices);
      sortedIndices.add(pivotIndex);

      _quickSortHelper(array, low, pivotIndex - 1, steps, sortedIndices);
      _quickSortHelper(array, pivotIndex + 1, high, steps, sortedIndices);
    }
  }

  static int _partition(List<int> array, int low, int high, List<SortStep> steps, List<int> sortedIndices) {
    int pivot = array[high];
    int i = low - 1;

    // Show pivot selection
    steps.add(
      SortStep(
        array: List.from(array),
        comparingIndices: [],
        swappingIndices: [],
        sortedIndices: List.from(sortedIndices),
        pivotIndex: high,
        description: 'Pivot selected: $pivot',
      ),
    );

    for (int j = low; j < high; j++) {
      // Comparing with pivot
      steps.add(
        SortStep(
          array: List.from(array),
          comparingIndices: [j, high],
          swappingIndices: [],
          sortedIndices: List.from(sortedIndices),
          pivotIndex: high,
          description: 'Comparing ${array[j]} with pivot $pivot',
        ),
      );

      if (array[j] < pivot) {
        i++;
        // Swap elements
        int temp = array[i];
        array[i] = array[j];
        array[j] = temp;

        if (i != j) {
          steps.add(
            SortStep(
              array: List.from(array),
              comparingIndices: [],
              swappingIndices: [i, j],
              sortedIndices: List.from(sortedIndices),
              pivotIndex: high,
              description: 'Swapping ${array[j]} and ${array[i]}',
            ),
          );
        }
      }
    }

    // Place pivot in correct position
    i++;
    int temp = array[i];
    array[i] = array[high];
    array[high] = temp;

    steps.add(
      SortStep(
        array: List.from(array),
        comparingIndices: [],
        swappingIndices: [i, high],
        sortedIndices: List.from(sortedIndices),
        pivotIndex: i,
        description: 'Pivot placed at position $i',
      ),
    );

    return i;
  }
}
