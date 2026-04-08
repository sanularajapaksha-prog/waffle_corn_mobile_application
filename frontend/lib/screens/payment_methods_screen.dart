import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_colors.dart';

class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Payment Methods')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _tile('Cash on Delivery', 'Pay when your order arrives.'),
          _tile('Card Payment', 'Front-end card entry flow for checkout UI.'),
          _tile('Account Transfer', 'Upload a slip and wait for verification before preparation starts.'),
        ],
      ),
    );
  }

  Widget _tile(String title, String subtitle) => Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(18)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: GoogleFonts.fraunces(fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            const SizedBox(height: 6),
            Text(subtitle, style: GoogleFonts.plusJakartaSans(color: AppColors.textSecondary)),
          ],
        ),
      );
}
