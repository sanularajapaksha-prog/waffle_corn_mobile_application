import 'package:flutter/material.dart';

class OnboardingSlide {
  final String title;
  final String description;
  final String eyebrow;
  final IconData icon;
  final List<Color> illustrationColors;

  const OnboardingSlide({
    required this.title,
    required this.description,
    required this.eyebrow,
    required this.icon,
    required this.illustrationColors,
  });
}
