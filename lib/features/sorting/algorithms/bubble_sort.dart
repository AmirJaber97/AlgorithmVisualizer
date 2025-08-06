import '../models/sort_step.dart';

class BubbleSort {
  static List<SortStep> generateSteps(List<int> values) {
    final steps = <SortStep>[];
    final array = List<int>.from(values);
    final n = array.length;

    // Initial state
    steps.add(
      SortStep(
        array: List.from(array),
        comparingIndices: [],
        swappingIndices: [],
        sortedIndices: [],
        description: 'Starting Bubble Sort',
      ),
    );

    for (int i = 0; i < n - 1; i++) {
      bool swapped = false;

      for (int j = 0; j < n - i - 1; j++) {
        // Comparing step
        steps.add(
          SortStep(
            array: List.from(array),
            comparingIndices: [j, j + 1],
            swappingIndices: [],
            sortedIndices: List.generate(i, (index) => n - 1 - index),
            description: 'Comparing ${array[j]} and ${array[j + 1]}',
          ),
        );

        if (array[j] > array[j + 1]) {
          // Swapping step
          int temp = array[j];
          array[j] = array[j + 1];
          array[j + 1] = temp;
          swapped = true;

          steps.add(
            SortStep(
              array: List.from(array),
              comparingIndices: [],
              swappingIndices: [j, j + 1],
              sortedIndices: List.generate(i, (index) => n - 1 - index),
              description: 'Swapping ${array[j + 1]} and ${array[j]}',
            ),
          );
        }
      }

      // Mark element as sorted
      steps.add(
        SortStep(
          array: List.from(array),
          comparingIndices: [],
          swappingIndices: [],
          sortedIndices: List.generate(i + 1, (index) => n - 1 - index),
          description: 'Element ${array[n - i - 1]} is in correct position',
        ),
      );

      if (!swapped) break; // Array is already sorted
    }

    // Final sorted state
    steps.add(
      SortStep(
        array: List.from(array),
        comparingIndices: [],
        swappingIndices: [],
        sortedIndices: List.generate(n, (index) => index),
        description: 'Array is sorted!',
        isFinal: true,
      ),
    );

    return steps;
  }
}
