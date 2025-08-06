import 'sort_element.dart';

class SortingState {
  final List<SortElement> elements;
  final bool isPlaying;
  final bool isSorted;
  final int currentStep;
  final int totalComparisons;
  final int totalSwaps;
  final List<int> highlightedIndices;
  final int? pivotIndex;
  final String currentOperation;

  const SortingState({
    this.elements = const [],
    this.isPlaying = false,
    this.isSorted = false,
    this.currentStep = 0,
    this.totalComparisons = 0,
    this.totalSwaps = 0,
    this.highlightedIndices = const [],
    this.pivotIndex,
    this.currentOperation = '',
  });

  SortingState copyWith({
    List<SortElement>? elements,
    bool? isPlaying,
    bool? isSorted,
    int? currentStep,
    int? totalComparisons,
    int? totalSwaps,
    List<int>? highlightedIndices,
    int? pivotIndex,
    String? currentOperation,
  }) {
    return SortingState(
      elements: elements ?? this.elements,
      isPlaying: isPlaying ?? this.isPlaying,
      isSorted: isSorted ?? this.isSorted,
      currentStep: currentStep ?? this.currentStep,
      totalComparisons: totalComparisons ?? this.totalComparisons,
      totalSwaps: totalSwaps ?? this.totalSwaps,
      highlightedIndices: highlightedIndices ?? this.highlightedIndices,
      pivotIndex: pivotIndex ?? this.pivotIndex,
      currentOperation: currentOperation ?? this.currentOperation,
    );
  }
}
