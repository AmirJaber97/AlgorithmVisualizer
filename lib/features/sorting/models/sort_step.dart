class SortStep {
  final List<int> array;
  final List<int> comparingIndices;
  final List<int> swappingIndices;
  final List<int> mergingIndices;
  final List<int> sortedIndices;
  final List<int> pivotIndices;
  final String description;
  final bool isFinal;

  SortStep({
    required this.array,
    this.comparingIndices = const [],
    this.swappingIndices = const [],
    this.mergingIndices = const [],
    this.sortedIndices = const [],
    this.pivotIndices = const [],
    this.description = '',
    this.isFinal = false,
  });
}
