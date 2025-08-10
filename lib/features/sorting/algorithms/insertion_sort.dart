import '../models/sort_step.dart';

class InsertionSort {
  static List<SortStep> generateSteps(List<int> values) {
    final steps = <SortStep>[];
    final array = List<int>.from(values);
    final sortedIndices = <int>[];

    // Initial state
    steps.add(
      SortStep(
        array: List.from(array),
        description: 'Starting Insertion Sort',
      ),
    );

    for (int i = 1; i < array.length; i++) {
      int key = array[i];
      int j = i - 1;

      // Compare key with previous elements
      while (j >= 0 && array[j] > key) {
        steps.add(
          SortStep(
            array: List.from(array),
            comparingIndices: [j, j + 1],
            description: 'Comparing ${array[j]} and $key',
          ),
        );

        // Shift element to the right
        array[j + 1] = array[j];
        steps.add(
          SortStep(
            array: List.from(array),
            swappingIndices: [j, j + 1],
            description: 'Shifting ${array[j]} to position ${j + 1}',
          ),
        );
        j--;
      }

      // Insert key at the correct position
      array[j + 1] = key;
      steps.add(
        SortStep(
          array: List.from(array),
          swappingIndices: [j + 1, i],
          description: 'Insert $key at position ${j + 1}',
        ),
      );

      // Mark this element as sorted
      sortedIndices.add(i);
      steps.add(
        SortStep(
          array: List.from(array),
          sortedIndices: List.from(sortedIndices),
          description: 'Elements up to index $i sorted',
        ),
      );
    }

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
}
