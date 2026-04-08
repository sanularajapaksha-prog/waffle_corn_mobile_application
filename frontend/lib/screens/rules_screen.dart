import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_colors.dart';

class RulesScreen extends StatelessWidget {
  const RulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sections = [
      ('Delivery policy', 'Orders are dispatched after confirmation and routed to the saved delivery address supplied at checkout.'),
      ('Order policy', 'Configured cone items are prepared against the submitted specification. Changes should be requested before payment confirmation.'),
      ('Payment policy', 'Cash, card UI, and account transfer are supported. Bank transfer orders remain pending until the slip is verified.'),
      ('Refund and verification', 'Refund reviews are handled for incorrect fulfillment, duplicate payment, or rejected bank transfer verification.'),
    ];
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Rules and Regulations')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          for (final section in sections)
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(18)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(section.$1, style: GoogleFonts.fraunces(fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                  const SizedBox(height: 6),
                  Text(section.$2, style: GoogleFonts.plusJakartaSans(height: 1.6, color: AppColors.textSecondary)),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
