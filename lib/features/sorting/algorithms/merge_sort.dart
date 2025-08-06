import '../models/sort_step.dart';

class MergeSort {
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
        description: 'Starting Merge Sort',
      ),
    );

    _mergeSortHelper(array, 0, array.length - 1, steps);

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

  static void _mergeSortHelper(List<int> array, int left, int right, List<SortStep> steps) {
    if (left < right) {
      int mid = (left + right) ~/ 2;

      _mergeSortHelper(array, left, mid, steps);
      _mergeSortHelper(array, mid + 1, right, steps);
      _merge(array, left, mid, right, steps);
    }
  }

  static void _merge(List<int> array, int left, int mid, int right, List<SortStep> steps) {
    List<int> leftArray = array.sublist(left, mid + 1);
    List<int> rightArray = array.sublist(mid + 1, right + 1);

    int i = 0, j = 0, k = left;

    while (i < leftArray.length && j < rightArray.length) {
      // Show comparison
      steps.add(
        SortStep(
          array: List.from(array),
          comparingIndices: [k],
          swappingIndices: [],
          sortedIndices: [],
          description: 'Merging: comparing ${leftArray[i]} and ${rightArray[j]}',
        ),
      );

      if (leftArray[i] <= rightArray[j]) {
        array[k] = leftArray[i];
        i++;
      } else {
        array[k] = rightArray[j];
        j++;
      }
      k++;
    }

    while (i < leftArray.length) {
      array[k] = leftArray[i];
      i++;
      k++;
    }

    while (j < rightArray.length) {
      array[k] = rightArray[j];
      j++;
      k++;
    }

    // Show merged section
    steps.add(
      SortStep(
        array: List.from(array),
        comparingIndices: [],
        swappingIndices: List.generate(right - left + 1, (i) => left + i),
        sortedIndices: [],
        description: 'Merged section from index $left to $right',
      ),
    );
  }
}
