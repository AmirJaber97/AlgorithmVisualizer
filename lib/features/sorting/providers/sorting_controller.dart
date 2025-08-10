import 'dart:async';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../algorithms/bubble_sort.dart';
import '../algorithms/heap_sort.dart';
import '../algorithms/insertion_sort.dart';
import '../algorithms/merge_sort.dart';
import '../algorithms/quick_sort.dart';
import '../algorithms/selection_sort.dart';
import '../models/sort_algorithm.dart';
import '../models/sort_element.dart';
import '../models/sort_step.dart';
import '../models/sorting_state.dart';

class SortingController extends StateNotifier<SortingState> {
  Timer? _timer;
  List<SortStep> _steps = [];
  int _currentStepIndex = 0;
  double _currentSpeed = 0.5;
  SortAlgorithm _currentAlgorithm = SortAlgorithm.bubbleSort;
  List<int> _originalValues = [];

  SortingController() : super(const SortingState()) {
    generateRandomArray(50);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void generateRandomArray(int size) {
    final random = Random();
    final values = List.generate(size, (index) => random.nextInt(100) + 1);
    _originalValues = List.from(values);
    final elements = values.asMap().entries.map((entry) {
      return SortElement(value: entry.value, index: entry.key);
    }).toList();

    state = state.copyWith(
      elements: elements,
      isSorted: false,
      currentStep: 0,
      totalComparisons: 0,
      totalSwaps: 0,
      highlightedIndices: [],
      pivotIndex: null,
      currentOperation: 'Array generated',
    );

    _generateSteps();
  }

  void _generateSteps() {
    final values = List<int>.from(_originalValues);
    _steps = switch (_currentAlgorithm) {
      SortAlgorithm.bubbleSort => BubbleSort.generateSteps(values),
      SortAlgorithm.quickSort => QuickSort.generateSteps(values),
      SortAlgorithm.mergeSort => MergeSort.generateSteps(values),
      SortAlgorithm.heapSort => HeapSort.generateSteps(values),
      SortAlgorithm.insertionSort => InsertionSort.generateSteps(values),
      SortAlgorithm.selectionSort => SelectionSort.generateSteps(values),
    };
    _currentStepIndex = 0;
  }

  void play() {
    if (state.isSorted) {
      reset();
      return;
    }
    state = state.copyWith(isPlaying: true);
    _startAnimation();
  }

  void _startAnimation() {
    _timer?.cancel();
    final delayMs = _calculateDelay(_currentSpeed);
    _timer = Timer.periodic(Duration(milliseconds: delayMs), (timer) {
      if (_currentStepIndex >= _steps.length - 1) {
        pause();
        state = state.copyWith(isSorted: true);
        return;
      }
      _currentStepIndex++;
      _applyStep(_steps[_currentStepIndex]);
    });
  }

  int _calculateDelay(double speed) {
    final s = speed.clamp(0.0, 1.0);
    if (s < 0.5) {
      return (2000 - (s * 2 * 1500)).toInt();
    } else {
      return (500 - ((s - 0.5) * 2 * 450)).toInt();
    }
  }

  void _applyStep(SortStep step) {
    final compSet = step.comparingIndices.toSet();
    final swapSet = step.swappingIndices.toSet();
    final mergeSet = step.mergingIndices.toSet();
    final sortedSet = step.sortedIndices.toSet();
    final pivotSet = step.pivotIndices.toSet();

    final elements = step.array.asMap().entries.map((entry) {
      final idx = entry.key;
      final val = entry.value;
      return SortElement(
        value: val,
        index: idx,
        isComparing: compSet.contains(idx),
        isSwapping: swapSet.contains(idx),
        isMerging: mergeSet.contains(idx),
        isSorted: sortedSet.contains(idx) || step.isFinal,
        isPivot: pivotSet.contains(idx),
      );
    }).toList();

    var comparisons = state.totalComparisons + (compSet.isNotEmpty ? 1 : 0);
    var swaps = state.totalSwaps + (swapSet.isNotEmpty ? 1 : 0);

    state = state.copyWith(
      elements: elements,
      currentStep: _currentStepIndex,
      totalComparisons: comparisons,
      totalSwaps: swaps,
      currentOperation: step.description,
      highlightedIndices: [...compSet, ...swapSet, ...mergeSet],
      pivotIndex: pivotSet.isNotEmpty ? pivotSet.first : null,
    );
  }

  void pause() {
    _timer?.cancel();
    state = state.copyWith(isPlaying: false);
  }

  void reset() {
    _timer?.cancel();
    _currentStepIndex = 0;
    if (_steps.isNotEmpty) {
      _applyStep(_steps[0]);
    }
    state = state.copyWith(
      isPlaying: false,
      isSorted: false,
      currentStep: 0,
      totalComparisons: 0,
      totalSwaps: 0,
      pivotIndex: null,
      highlightedIndices: [],
    );
  }

  void shuffle() => generateRandomArray(state.elements.length);

  void stepForward() {
    if (_currentStepIndex < _steps.length - 1) _applyStep(_steps[++_currentStepIndex]);
  }

  void stepBackward() {
    if (_currentStepIndex > 0) _applyStep(_steps[--_currentStepIndex]);
  }

  void setSpeed(double s) {
    _currentSpeed = s;
    if (state.isPlaying) _startAnimation();
  }

  void setArraySize(int s) {
    pause();
    generateRandomArray(s);
  }

  void setAlgorithm(SortAlgorithm algo) {
    pause();
    _currentAlgorithm = algo;
    _generateSteps();
    reset();
  }

  int get totalSteps => _steps.length;

  double get progress => _steps.isEmpty ? 0 : _currentStepIndex / _steps.length;
}
