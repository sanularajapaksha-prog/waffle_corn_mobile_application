import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/onboarding_slide.dart';
import '../../utils/app_colors.dart';

class OnboardingPageWidget extends StatelessWidget {
  final OnboardingSlide slide;
  final int index;

  const OnboardingPageWidget({
    super.key,
    required this.slide,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(34),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 24,
                  offset: const Offset(0, 16),
                ),
              ],
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(28),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 220,
                        height: 220,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              slide.illustrationColors[0],
                              slide.illustrationColors[1],
                            ],
                          ),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 148,
                              height: 148,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.46),
                                shape: BoxShape.circle,
                              ),
                            ),
                            Transform.rotate(
                              angle: index == 1 ? -0.18 : 0.0,
                              child: Icon(
                                slide.icon,
                                size: 82,
                                color: slide.illustrationColors.last,
                              ),
                            ),
                            Positioned(
                              top: 48,
                              right: 38,
                              child: _Dot(color: slide.illustrationColors.last),
                            ),
                            Positioned(
                              bottom: 58,
                              left: 42,
                              child: _Dot(color: AppColors.accentOrange),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        slide.eyebrow.toUpperCase(),
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.0,
                          color: AppColors.accentOrange,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        slide.title,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.fraunces(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        slide.description,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 15,
                          height: 1.65,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Dot extends StatelessWidget {
  final Color color;

  const _Dot({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(999),
      ),
    );
  }
}
