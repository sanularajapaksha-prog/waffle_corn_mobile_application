import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_colors.dart';
import '../utils/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  static const _splashDuration = Duration(milliseconds: 5000);

  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<double> _scale;
  late final Animation<double> _blur;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: _splashDuration,
    );
    _opacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.08, 0.58, curve: Curves.easeOut),
    );
    _scale = Tween<double>(begin: 0.94, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.12, 0.72, curve: Curves.easeOutCubic),
      ),
    );
    _blur = Tween<double>(begin: 18, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOutCubic),
      ),
    );

    _controller.forward();

    Future.delayed(_splashDuration, () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.onboarding);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            fit: StackFit.expand,
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFF8F1E8),
                      Color(0xFFF3ECE5),
                      Color(0xFFF9F6F2),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: -60,
                right: -30,
                child: _GlowOrb(
                  size: 220,
                  color: const Color(0xFFD7B38B).withOpacity(0.42),
                ),
              ),
              Positioned(
                left: -50,
                bottom: 80,
                child: _GlowOrb(
                  size: 180,
                  color: const Color(0xFFC99A6A).withOpacity(0.26),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: _blur.value,
                  sigmaY: _blur.value,
                ),
                child: Container(color: Colors.white.withOpacity(0.04)),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Center(
                    child: FadeTransition(
                      opacity: _opacity,
                      child: ScaleTransition(
                        scale: _scale,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 96,
                              height: 96,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(28),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary.withOpacity(0.22),
                                    blurRadius: 24,
                                    offset: const Offset(0, 14),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.icecream_outlined,
                                color: Colors.white,
                                size: 42,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Text(
                              'Puffy Woffle',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.fraunces(
                                fontSize: 38,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Professional waffle cone ordering',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 14,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _GlowOrb extends StatelessWidget {
  final double size;
  final Color color;

  const _GlowOrb({
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              color,
              color.withOpacity(0),
            ],
          ),
        ),
      ),
    );
  }
}
