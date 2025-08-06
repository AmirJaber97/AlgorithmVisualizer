import 'dart:async';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../algorithms/bubble_sort.dart';
import '../algorithms/merge_sort.dart';
import '../algorithms/quick_sort.dart';
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
      currentOperation: 'Array generated',
    );

    _generateSteps();
  }

  void _generateSteps() {
    final values = state.elements.map((e) => e.value).toList();

    _steps = switch (_currentAlgorithm) {
      SortAlgorithm.bubbleSort => BubbleSort.generateSteps(values),
      SortAlgorithm.quickSort => QuickSort.generateSteps(values),
      SortAlgorithm.mergeSort => MergeSort.generateSteps(values),
      SortAlgorithm.heapSort => BubbleSort.generateSteps(values),
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

    final delay = _calculateDelay(_currentSpeed);

    _timer = Timer.periodic(Duration(milliseconds: delay), (timer) {
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
    final normalizedSpeed = speed.clamp(0.0, 1.0);

    if (normalizedSpeed < 0.5) {
      return (2000 - (normalizedSpeed * 2 * 1500)).toInt();
    } else {
      return (500 - ((normalizedSpeed - 0.5) * 2 * 450)).toInt();
    }
  }

  void _applyStep(SortStep step) {
    final elements = step.array.asMap().entries.map((entry) {
      final index = entry.key;
      final value = entry.value;

      return SortElement(
        value: value,
        index: index,
        isComparing: step.comparingIndices.contains(index),
        isSwapping: step.swappingIndices.contains(index),
        isSorted: step.sortedIndices.contains(index),
        isPivot: step.pivotIndex == index,
      );
    }).toList();

    int comparisons = state.totalComparisons;
    int swaps = state.totalSwaps;

    if (step.comparingIndices.isNotEmpty) comparisons++;
    if (step.swappingIndices.isNotEmpty) swaps++;

    state = state.copyWith(
      elements: elements,
      currentStep: _currentStepIndex,
      totalComparisons: comparisons,
      totalSwaps: swaps,
      currentOperation: step.description,
      highlightedIndices: [...step.comparingIndices, ...step.swappingIndices],
      pivotIndex: step.pivotIndex,
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
    state = state.copyWith(isPlaying: false, isSorted: false, currentStep: 0, totalComparisons: 0, totalSwaps: 0);
  }

  void shuffle() {
    generateRandomArray(state.elements.length);
  }

  void stepForward() {
    if (_currentStepIndex < _steps.length - 1) {
      _currentStepIndex++;
      _applyStep(_steps[_currentStepIndex]);
    }
  }

  void stepBackward() {
    if (_currentStepIndex > 0) {
      _currentStepIndex--;
      _applyStep(_steps[_currentStepIndex]);
    }
  }

  void setSpeed(double speed) {
    _currentSpeed = speed;
    if (state.isPlaying) {
      _startAnimation();
    }
  }

  void setArraySize(int size) {
    pause();
    generateRandomArray(size);
  }

  void setAlgorithm(SortAlgorithm algorithm) {
    pause();
    _currentAlgorithm = algorithm;
    reset();
    _generateSteps();
  }

  int get totalSteps => _steps.length;

  double get progress => _steps.isEmpty ? 0 : _currentStepIndex / _steps.length;
}
