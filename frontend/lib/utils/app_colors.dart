import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF8B5E3C);
  static const Color primaryLight = Color(0xFFD7B38B);
  static const Color primaryDark = Color(0xFF6D482D);
  static const Color accentOrange = Color(0xFFF28C28);
  static const Color accentOrangeSoft = Color(0xFFFFE6C7);
  static const Color cream = Color(0xFFFFFBF7);
  static const Color deepNavy = Color(0xFF17182B);
  static const Color deepNavySoft = Color(0xFF232642);
  static const Color line = Color(0xFFEEE5DB);
  static const Color background = Color(0xFFF7F3EE);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFFE7DED1);
  static const Color textPrimary = Color(0xFF231A14);
  static const Color textSecondary = Color(0xFF726459);
  static const Color textHint = Color(0xFFA29284);
  static const Color success = Color(0xFF2E8B57);
  static const Color error = Color(0xFFC84747);
  static const Color warning = Color(0xFFD68A2E);

  static List<Color> categoryGradient(String category) {
    switch (category) {
      case 'Small Cone':
        return const [Color(0xFFF2E1CC), Color(0xFFC79A6A)];
      case 'Regular Cone':
        return const [Color(0xFFEBD6BD), Color(0xFFB98250)];
      case 'Large Cone':
        return const [Color(0xFFE1C9B1), Color(0xFF9C6B46)];
      case 'Flavours':
        return const [Color(0xFFF5D9D5), Color(0xFFD68678)];
      case 'Biscuits':
        return const [Color(0xFFE7DBC7), Color(0xFF9D8458)];
      default:
        return const [surfaceDark, primaryLight];
    }
  }
}
