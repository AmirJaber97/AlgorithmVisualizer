import 'package:flutter/material.dart';

class AppColors {
  // Primary colors
  static const primary = Color(0xFF6366F1);
  static const primaryDark = Color(0xFF4F46E5);
  static const primaryLight = Color(0xFF818CF8);

  // Algorithm specific colors
  static const comparing = Color(0xFFEF4444);
  static const swapping = Color(0xFFF59E0B);
  static const sorted = Color(0xFF10B981);
  static const pivot = Color(0xFF8B5CF6);
  static const searching = Color(0xFF3B82F6);

  // Pathfinding colors
  static const wall = Color(0xFF374151);
  static const visited = Color(0xFFDDD6FE);
  static const path = Color(0xFFFBBF24);
  static const start = Color(0xFF10B981);
  static const end = Color(0xFFEF4444);

  // Neutral colors
  static const background = Color(0xFFF9FAFB);
  static const surface = Color(0xFFFFFFFF);
  static const border = Color(0xFFE5E7EB);

  // ─── Sorting‐Visualizer Palette ───────────────────
  /// Default bar color
  static const defaultBar = primary;

  /// Merging (merge‐sort) highlight
  static const merging = searching;
}
