import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class SortElement {
  final int value;
  final int index;
  final bool isComparing;
  final bool isSwapping;
  final bool isSorted;
  final bool isPivot;
  final bool isMerging;

  const SortElement({
    required this.value,
    required this.index,
    this.isComparing = false,
    this.isSwapping = false,
    this.isSorted = false,
    this.isPivot = false,
    this.isMerging = false,
  });

  SortElement copyWith({
    int? value,
    int? index,
    bool? isComparing,
    bool? isSwapping,
    bool? isSorted,
    bool? isPivot,
    bool? isMerging,
  }) {
    return SortElement(
      value: value ?? this.value,
      index: index ?? this.index,
      isComparing: isComparing ?? this.isComparing,
      isSwapping: isSwapping ?? this.isSwapping,
      isSorted: isSorted ?? this.isSorted,
      isPivot: isPivot ?? this.isPivot,
      isMerging: isMerging ?? this.isMerging,
    );
  }

  Color get color {
    if (isSorted) return AppColors.sorted;
    if (isPivot) return AppColors.pivot;
    if (isSwapping) return AppColors.swapping;
    if (isComparing) return AppColors.comparing;
    if (isMerging) return AppColors.searching;
    return AppColors.primary;
  }
}
