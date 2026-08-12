import 'package:flutter/material.dart';

class AccessibilityUtils {
  AccessibilityUtils._();

  static double getScaledSpacing(BuildContext context, double base) {
    final scale = MediaQuery.textScalerOf(context).scale(base);
    return scale.clamp(base, base * 1.5);
  }

  static String formatTimeForScreenReader(String start, String end) {
    return 'from $start to $end';
  }
}
