enum SortAlgorithm {
  bubbleSort('Bubble Sort'),
  quickSort('Quick Sort'),
  mergeSort('Merge Sort'),
  heapSort('Heap Sort'),
  insertionSort('Insertion Sort'),
  selectionSort('Selection Sort');

  final String displayName;

  const SortAlgorithm(this.displayName);
}
