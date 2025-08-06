class SortStep {
  final List<int> array;
  final List<int> comparingIndices;
  final List<int> swappingIndices;
  final List<int> sortedIndices;
  final int? pivotIndex;
  final String description;
  final bool isFinal;

  const SortStep({
    required this.array,
    required this.comparingIndices,
    required this.swappingIndices,
    required this.sortedIndices,
    this.pivotIndex,
    required this.description,
    this.isFinal = false,
  });
}
