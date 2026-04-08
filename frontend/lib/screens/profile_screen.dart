import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_colors.dart';
import '../utils/app_routes.dart';
import '../widgets/custom_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      ('My Orders', AppRoutes.myOrders, Icons.receipt_long_rounded),
      ('Saved Address', AppRoutes.addresses, Icons.location_on_outlined),
      ('Payment Methods', AppRoutes.paymentMethods, Icons.payment_outlined),
      ('Notifications', AppRoutes.notifications, Icons.notifications_none_rounded),
      ('Help and Support', AppRoutes.help, Icons.help_outline_rounded),
      ('Edit Profile', AppRoutes.editProfile, Icons.edit_outlined),
      ('Rules and Regulations', AppRoutes.rules, Icons.gavel_rounded),
      ('How It Works', AppRoutes.howItWorks, Icons.play_circle_outline_rounded),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text('Profile', style: GoogleFonts.fraunces(fontSize: 28, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(20)),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.10), borderRadius: BorderRadius.circular(18)),
                    child: const Icon(Icons.person_outline_rounded, color: AppColors.primary),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nadeesha Perera',
                          style: GoogleFonts.fraunces(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'nadeesha.perera@puffywoffle.lk',
                          style: GoogleFonts.plusJakartaSans(color: AppColors.textSecondary),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ...items.map((item) => _menuTile(context, item.$1, item.$2, item.$3)),
            const SizedBox(height: 12),
            OutlinedPillButton(
              label: 'Logout',
              onPressed: () => Navigator.pushNamedAndRemoveUntil(context, AppRoutes.signIn, (route) => false),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuTile(BuildContext context, String title, String route, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(title, style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
        trailing: const Icon(Icons.chevron_right_rounded),
        onTap: () => Navigator.pushNamed(context, route),
      ),
    );
  }
}
