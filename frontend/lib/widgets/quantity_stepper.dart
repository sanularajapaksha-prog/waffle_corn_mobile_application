import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';

/// Inline [−] count [+] stepper.
/// [onDecrement] is called even when count would reach 0 — the parent decides
/// whether to remove the item.
class QuantityStepper extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final ValueChanged<int>? onQuantitySubmitted;
  final double size;

  const QuantityStepper({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
    this.onQuantitySubmitted,
    this.size = 32,
  });

  Future<void> _editQuantity(BuildContext context) async {
    if (onQuantitySubmitted == null) return;
    final controller = TextEditingController(text: '$quantity');
    final result = await showDialog<int>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Enter quantity'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Quantity',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final value = int.tryParse(controller.text.trim());
              Navigator.pop(context, value);
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
    if (result != null && result > 0) {
      onQuantitySubmitted!(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _StepperButton(
          icon: Icons.remove_rounded,
          onTap: onDecrement,
          size: size,
          enabled: quantity > 0,
        ),
        GestureDetector(
          onTap: onQuantitySubmitted == null ? null : () => _editQuantity(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$quantity',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                if (onQuantitySubmitted != null)
                  Text(
                    'Tap to edit',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 10,
                      color: AppColors.textHint,
                    ),
                  ),
              ],
            ),
          ),
        ),
        _StepperButton(
          icon: Icons.add_rounded,
          onTap: onIncrement,
          size: size,
        ),
      ],
    );
  }
}

class _StepperButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final double size;
  final bool enabled;

  const _StepperButton({
    required this.icon,
    required this.onTap,
    required this.size,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: enabled ? AppColors.primary : AppColors.surfaceDark,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: size * 0.5,
          color: enabled ? Colors.white : AppColors.textHint,
        ),
      ),
    );
  }
}
