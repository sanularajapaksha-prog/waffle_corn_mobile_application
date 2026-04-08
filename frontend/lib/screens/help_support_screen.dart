import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_colors.dart';
import '../utils/app_routes.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final faqs = [
      ('How do I place an order?', 'Select a category, configure the item, add it to cart, then complete checkout.'),
      ('How does bank transfer work?', 'Choose Account Transfer, send payment, upload the slip, and wait for verification.'),
      ('Can I edit my address?', 'Yes. Use Saved Address from the profile section to add or remove delivery locations.'),
    ];
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Help and Support')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          ...faqs.map((faq) => Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(18)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(faq.$1, style: GoogleFonts.fraunces(fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                    const SizedBox(height: 6),
                    Text(faq.$2, style: GoogleFonts.plusJakartaSans(color: AppColors.textSecondary)),
                  ],
                ),
              )),
          ListTile(
            tileColor: AppColors.surface,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            title: const Text('Rules and Regulations'),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () => Navigator.pushNamed(context, AppRoutes.rules),
          ),
          const SizedBox(height: 12),
          ListTile(
            tileColor: AppColors.surface,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            title: const Text('How It Works'),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () => Navigator.pushNamed(context, AppRoutes.howItWorks),
          ),
        ],
      ),
    );
  }
}
