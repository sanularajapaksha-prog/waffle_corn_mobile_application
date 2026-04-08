import 'package:flutter/material.dart';

import '../models/onboarding_slide.dart';
import 'app_colors.dart';

class OnboardingMockData {
  OnboardingMockData._();

  static const slides = <OnboardingSlide>[
    OnboardingSlide(
      eyebrow: 'Browse',
      title: 'Discover your favorite waffle cones',
      description:
          'Explore signature cones, premium finishes, biscuits, and flavour add-ons prepared for quick ordering.',
      icon: Icons.icecream_outlined,
      illustrationColors: [
        AppColors.accentOrangeSoft,
        Color(0xFFFFD29B),
        Color(0xFFF7B35E),
      ],
    ),
    OnboardingSlide(
      eyebrow: 'Customize',
      title: 'Customize toppings and flavours',
      description:
          'Select cone type, choose flavour finishes, add tint options, and review your price before checkout.',
      icon: Icons.tune_rounded,
      illustrationColors: [
        Color(0xFFFFF1DD),
        Color(0xFFD8B48E),
        Color(0xFF8B5E3C),
      ],
    ),
    OnboardingSlide(
      eyebrow: 'Order',
      title: 'Fast delivery and easy ordering',
      description:
          'Checkout in a few taps, upload transfer slips when needed, and track every order from confirmation to delivery.',
      icon: Icons.delivery_dining_rounded,
      illustrationColors: [
        Color(0xFFE9ECFF),
        Color(0xFFB9C2FF),
        Color(0xFF232642),
      ],
    ),
  ];
}
