import 'package:flutter/material.dart';

class AppColors {
  static const Color green = Color(0xFF2EB872);
  static const Color orange = Color(0xFFF59E0B);
  static const Color red = Color(0xFFEF4444);
  static const Color surfaceLight = Color(0xFFF7FAFC);
  static const Color surfaceDark = Color(0xFF121212);
}

class AppSpacing {
  static const double xxs = 4;
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
}

class AppRadius {
  static const BorderRadius soft = BorderRadius.all(Radius.circular(14));
}

class AppDurations {
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 250);
  static const Duration slow = Duration(milliseconds: 400);
}