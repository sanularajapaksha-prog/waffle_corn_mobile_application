import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class PageIndicator extends StatelessWidget {
  final int count;
  final int currentIndex;

  const PageIndicator({
    super.key,
    required this.count,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          width: currentIndex == index ? 26 : 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: currentIndex == index
                ? AppColors.accentOrange
                : AppColors.primaryLight.withOpacity(0.45),
            borderRadius: BorderRadius.circular(999),
          ),
        ),
      ),
    );
  }
}
