import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/order_result.dart';
import '../utils/app_colors.dart';
import '../utils/app_routes.dart';
import '../widgets/custom_button.dart';

class OrderConfirmationScreen extends StatefulWidget {
  final OrderResult orderResult;

  const OrderConfirmationScreen({super.key, required this.orderResult});

  @override
  State<OrderConfirmationScreen> createState() => _OrderConfirmationScreenState();
}

class _OrderConfirmationScreenState extends State<OrderConfirmationScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _heroScale;
  late final Animation<double> _heroOpacity;
  late final Animation<double> _contentOpacity;
  int _trackerStep = 0;

  bool get _isBankTransfer => widget.orderResult.isBankTransfer;

  List<(IconData, String)> get _trackerSteps => _isBankTransfer
      ? const [
          (Icons.schedule_rounded, 'Pending'),
          (Icons.verified_rounded, 'Verified'),
          (Icons.soup_kitchen_rounded, 'Preparing'),
          (Icons.home_rounded, 'Delivered'),
        ]
      : const [
          (Icons.receipt_long_rounded, 'Confirmed'),
          (Icons.soup_kitchen_rounded, 'Preparing'),
          (Icons.delivery_dining_rounded, 'On the Way'),
          (Icons.home_rounded, 'Delivered'),
        ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _heroOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0, 0.45, curve: Curves.easeIn)),
    );
    _heroScale = Tween<double>(begin: 0.5, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0, 0.55, curve: Curves.elasticOut)),
    );
    _contentOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.35, 1, curve: Curves.easeIn)),
    );
    _controller.forward();
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() => _trackerStep = 1);
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
    final heroColor = _isBankTransfer ? AppColors.warning : AppColors.success;
    final heroIcon = _isBankTransfer ? Icons.schedule_rounded : Icons.check_rounded;
    final title = _isBankTransfer ? 'Pending Verification' : 'Order Placed';
    final subtitle = _isBankTransfer
        ? 'Your slip is queued for review. Puffy Woffle will start preparing once payment is verified.'
        : 'Your waffle cone order is confirmed and moving to preparation.';

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  48,
            ),
            child: Column(
              children: [
                const SizedBox(height: 12),
                FadeTransition(
                  opacity: _heroOpacity,
                  child: ScaleTransition(
                    scale: _heroScale,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [AppColors.primaryLight, AppColors.primary],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withOpacity(0.35),
                                blurRadius: 28,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.icecream_outlined, size: 60, color: Colors.white),
                        Positioned(
                          bottom: 6,
                          right: 6,
                          child: Container(
                            width: 34,
                            height: 34,
                            decoration: BoxDecoration(
                              color: heroColor,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(heroIcon, color: Colors.white, size: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                FadeTransition(
                  opacity: _contentOpacity,
                  child: Column(
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.fraunces(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        subtitle,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 15,
                          height: 1.5,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceDark,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Order #${widget.orderResult.orderNumber}',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                FadeTransition(opacity: _contentOpacity, child: _buildMetaCard()),
                const SizedBox(height: 18),
                FadeTransition(opacity: _contentOpacity, child: _buildTracker()),
                const SizedBox(height: 28),
                FadeTransition(
                  opacity: _contentOpacity,
                  child: Column(
                    children: [
                      PrimaryButton(
                        label: _isBankTransfer ? 'Track verification' : 'Track order',
                        icon: Icons.location_on_rounded,
                        onPressed: () => Navigator.pushNamed(context, AppRoutes.myOrders),
                      ),
                      const SizedBox(height: 14),
                      GestureDetector(
                        onTap: () => Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRoutes.home,
                          (route) => false,
                        ),
                        child: Text(
                          'Back to home',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMetaCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _MetaRow('Payment', widget.orderResult.paymentMethod.label),
          if (widget.orderResult.slipFileName != null) ...[
            const SizedBox(height: 10),
            _MetaRow('Slip', widget.orderResult.slipFileName!),
          ],
        ],
      ),
    );
  }

  Widget _buildTracker() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            _isBankTransfer ? 'Verification and order status' : 'Live order status',
            style: GoogleFonts.fraunces(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: IntrinsicWidth(
              child: Row(
                children: List.generate(_trackerSteps.length * 2 - 1, (index) {
                  if (index.isOdd) {
                    final stepIndex = index ~/ 2;
                    return SizedBox(
                      width: 36,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        height: 3,
                        decoration: BoxDecoration(
                          color: stepIndex < _trackerStep
                              ? (_isBankTransfer ? AppColors.warning : AppColors.success)
                              : AppColors.surfaceDark,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    );
                  }

                  final stepIndex = index ~/ 2;
                  final done = stepIndex <= _trackerStep;
                  final activeColor = _isBankTransfer ? AppColors.warning : AppColors.success;

                  return Column(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 400),
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: done ? activeColor : AppColors.surfaceDark,
                        ),
                        child: Icon(
                          _trackerSteps[stepIndex].$1,
                          size: 18,
                          color: done ? Colors.white : AppColors.textHint,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        _trackerSteps[stepIndex].$2,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 10,
                          fontWeight: done ? FontWeight.w600 : FontWeight.w400,
                          color: done ? activeColor : AppColors.textHint,
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetaRow extends StatelessWidget {
  final String label;
  final String value;

  const _MetaRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 70,
          child: Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
