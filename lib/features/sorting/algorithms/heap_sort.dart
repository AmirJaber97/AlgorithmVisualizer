import '../models/sort_step.dart';

class HeapSort {
  static List<SortStep> generateSteps(List<int> values) {
    final steps = <SortStep>[];
    final array = List<int>.from(values);
    final n = array.length;
    final sortedIndices = <int>[];

    // Initial state
    steps.add(
      SortStep(
        array: List.from(array),
        description: 'Starting Heap Sort',
      ),
    );

    // Build max-heap
    for (int i = n ~/ 2 - 1; i >= 0; i--) {
      _heapify(array, n, i, steps, sortedIndices);
    }

    // Extract elements from heap
    for (int i = n - 1; i > 0; i--) {
      // Swap root (max) with element at i
      steps.add(
        SortStep(
          array: List.from(array),
          swappingIndices: [0, i],
          sortedIndices: List.from(sortedIndices),
          description: 'Swap ${array[0]} and ${array[i]}',
        ),
      );
      final tmp = array[0];
      array[0] = array[i];
      array[i] = tmp;

      // Mark element at i as sorted
      sortedIndices.add(i);
      steps.add(
        SortStep(
          array: List.from(array),
          sortedIndices: List.from(sortedIndices),
          description: 'Element at index $i is now sorted',
        ),
      );

      // Heapify reduced heap
      _heapify(array, i, 0, steps, sortedIndices);
    }

    // Final sorted state (index 0)
    sortedIndices.add(0);
    steps.add(
      SortStep(
        array: List.from(array),
        sortedIndices: List.from(sortedIndices),
        description: 'Array is sorted!',
        isFinal: true,
      ),
    );

    return steps;
  }

  static void _heapify(
      List<int>      array,
      int            heapSize,
      int            rootIndex,
      List<SortStep> steps,
      List<int>      sortedIndices,
      ) {
    int largest = rootIndex;
    int left    = 2 * rootIndex + 1;
    int right   = 2 * rootIndex + 2;

    // Compare left child
    if (left < heapSize) {
      steps.add(
        SortStep(
          array: List.from(array),
          comparingIndices: [largest, left],
          sortedIndices: List.from(sortedIndices),
          description: 'Compare ${array[largest]} and ${array[left]}',
        ),
      );
      if (array[left] > array[largest]) {
        largest = left;
      }
    }

    // Compare right child
    if (right < heapSize) {
      steps.add(
        SortStep(
          array: List.from(array),
          comparingIndices: [largest, right],
          sortedIndices: List.from(sortedIndices),
          description: 'Compare ${array[largest]} and ${array[right]}',
        ),
      );
      if (array[right] > array[largest]) {
        largest = right;
      }
    }

    // Swap and recurse if needed
    if (largest != rootIndex) {
      steps.add(
        SortStep(
          array: List.from(array),
          swappingIndices: [rootIndex, largest],
          sortedIndices: List.from(sortedIndices),
          description: 'Swap ${array[rootIndex]} and ${array[largest]}',
        ),
      );
      final tmp = array[rootIndex];
      array[rootIndex] = array[largest];
      array[largest] = tmp;

      _heapify(array, heapSize, largest, steps, sortedIndices);
    }
  }
}