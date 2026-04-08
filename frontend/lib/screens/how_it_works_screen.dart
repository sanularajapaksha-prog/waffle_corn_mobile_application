import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_colors.dart';

class HowItWorksScreen extends StatelessWidget {
  const HowItWorksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final steps = [
      '1. Choose one of the five waffle cone categories.',
      '2. Open the item detail page and select product type, size, tint, and quantity.',
      '3. Review the live rupee amount and add the item to cart.',
      '4. Complete checkout using cash, card UI, or account transfer.',
      '5. If you use account transfer, upload a slip and track the Pending Verification status.',
    ];
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('How It Works')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(18)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Application guide', style: GoogleFonts.fraunces(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
              const SizedBox(height: 12),
              for (final step in steps)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(step, style: GoogleFonts.plusJakartaSans(height: 1.6, color: AppColors.textSecondary)),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
