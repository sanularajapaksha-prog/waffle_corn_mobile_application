import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_colors.dart';
import '../utils/app_routes.dart';
import '../widgets/custom_button.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Text('Sign in', style: GoogleFonts.fraunces(fontSize: 34, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
              const SizedBox(height: 8),
              Text('Access your cone orders, saved addresses, and payment flow.', style: GoogleFonts.plusJakartaSans(fontSize: 14, color: AppColors.textSecondary)),
              const SizedBox(height: 32),
              const TextField(decoration: InputDecoration(labelText: 'Email or phone')),
              const SizedBox(height: 16),
              const TextField(obscureText: true, decoration: InputDecoration(labelText: 'Password')),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.pushNamed(context, AppRoutes.forgotPassword),
                  child: const Text('Forgot password?'),
                ),
              ),
              const SizedBox(height: 12),
              PrimaryButton(
                label: 'Sign in',
                onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.home),
              ),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('New here?', style: GoogleFonts.plusJakartaSans(color: AppColors.textSecondary)),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, AppRoutes.signUp),
                    child: const Text('Create account'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
