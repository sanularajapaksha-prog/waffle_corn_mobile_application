import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_colors.dart';
import '../utils/app_routes.dart';
import '../widgets/auth/auth_header.dart';
import '../widgets/auth/otp_input_box.dart';
import '../widgets/custom_button.dart';

class VerificationScreen extends StatefulWidget {
  final String email;
  final bool returnToHome;

  const VerificationScreen({
    super.key,
    required this.email,
    required this.returnToHome,
  });

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final _controllers = List.generate(4, (_) => TextEditingController());
  final _focusNodes = List.generate(4, (_) => FocusNode());
  int _seconds = 24;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _handleChange(int index, String value) {
    if (value.isNotEmpty && index < _focusNodes.length - 1) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      if (_seconds == 0) {
        timer.cancel();
        return;
      }
      setState(() => _seconds -= 1);
    });
  }

  void _verify() {
    final route = widget.returnToHome ? AppRoutes.home : AppRoutes.signIn;
    Navigator.pushNamedAndRemoveUntil(context, route, (_) => false);
  }

  void _resendCode() {
    if (_seconds > 0) return;
    setState(() => _seconds = 24);
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SingleChildScrollView(
          child: Column(
            children: [
              AuthHeader(
                title: 'Verification',
                subtitle:
                    'Enter the secure code sent to ${widget.email.isEmpty ? 'your email' : widget.email}.',
              ),
              Transform.translate(
                offset: const Offset(0, -24),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 24,
                          offset: const Offset(0, 14),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Code',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            GestureDetector(
                              onTap: _resendCode,
                              child: Text(
                                _seconds > 0
                                    ? 'Resend in 0:${_seconds.toString().padLeft(2, '0')}'
                                    : 'Resend code',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: _seconds > 0
                                      ? AppColors.textSecondary
                                      : AppColors.accentOrange,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            4,
                            (index) => OtpInputBox(
                              controller: _controllers[index],
                              focusNode: _focusNodes[index],
                              onChanged: (value) => _handleChange(index, value),
                            ),
                          ),
                        ),
                        const SizedBox(height: 26),
                        PrimaryButton(
                          label: 'Verify',
                          onPressed: _verify,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
