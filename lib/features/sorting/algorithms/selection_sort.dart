import '../models/sort_step.dart';

class SelectionSort {
  static List<SortStep> generateSteps(List<int> values) {
    final steps = <SortStep>[];
    final array = List<int>.from(values);
    final sortedIndices = <int>[];

    // Initial state
    steps.add(
      SortStep(
        array: List.from(array),
        description: 'Starting Selection Sort',
      ),
    );

    for (int i = 0; i < array.length - 1; i++) {
      int minIndex = i;

      // Find the minimum in the unsorted portion
      for (int j = i + 1; j < array.length; j++) {
        steps.add(
          SortStep(
            array: List.from(array),
            comparingIndices: [minIndex, j],
            sortedIndices: List.from(sortedIndices),
            description: 'Comparing ${array[minIndex]} and ${array[j]}',
          ),
        );
        if (array[j] < array[minIndex]) {
          minIndex = j;
          steps.add(
            SortStep(
              array: List.from(array),
              pivotIndices: [minIndex],
              sortedIndices: List.from(sortedIndices),
              description: 'New minimum at index $minIndex',
            ),
          );
        }
      }

      // Swap the found minimum with the first element
      if (minIndex != i) {
        steps.add(
          SortStep(
            array: List.from(array),
            swappingIndices: [i, minIndex],
            sortedIndices: List.from(sortedIndices),
            description: 'Swap ${array[i]} and ${array[minIndex]}',
          ),
        );
        final temp = array[i];
        array[i] = array[minIndex];
        array[minIndex] = temp;
      }

      // Mark element i as sorted
      sortedIndices.add(i);
      steps.add(
        SortStep(
          array: List.from(array),
          sortedIndices: List.from(sortedIndices),
          description: 'Element at index $i sorted',
        ),
      );
    }

    // Final sorted state of last element
    sortedIndices.add(array.length - 1);
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
}