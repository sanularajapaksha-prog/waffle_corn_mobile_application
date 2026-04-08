import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/cart_item.dart';
import '../providers/cart_provider.dart';
import '../utils/app_colors.dart';
import '../utils/app_formatters.dart';
import 'quantity_stepper.dart';

class CartItemTile extends StatelessWidget {
  final CartItem item;
  final int index;

  const CartItemTile({super.key, required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    final cart = context.read<CartProvider>();
    final gradient = AppColors.categoryGradient(item.cone.category);
    return Dismissible(
      key: ValueKey(item.cartKey),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(color: AppColors.error, borderRadius: BorderRadius.circular(16)),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete_outline_rounded, color: Colors.white),
      ),
      onDismissed: (_) => cart.removeItem(index),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 360;
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: compact
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          _thumb(gradient),
                          const SizedBox(width: 12),
                          Expanded(child: _info()),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Consumer<CartProvider>(
                          builder: (_, cartState, __) => QuantityStepper(
                            quantity: item.quantity,
                            size: 28,
                            onIncrement: () => cartState.incrementItem(index),
                            onDecrement: () => cartState.decrementItem(index),
                            onQuantitySubmitted: (value) => cartState.setItemQuantity(index, value),
                          ),
                        ),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      _thumb(gradient),
                      const SizedBox(width: 12),
                      Expanded(child: _info()),
                      const SizedBox(width: 12),
                      Consumer<CartProvider>(
                        builder: (_, cartState, __) => QuantityStepper(
                          quantity: item.quantity,
                          size: 28,
                          onIncrement: () => cartState.incrementItem(index),
                          onDecrement: () => cartState.decrementItem(index),
                          onQuantitySubmitted: (value) => cartState.setItemQuantity(index, value),
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }

  Widget _thumb(List<Color> gradient) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: 68,
        height: 68,
        child: Image.network(
          item.cone.imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            decoration: BoxDecoration(gradient: LinearGradient(colors: gradient)),
            child: const Icon(Icons.icecream_outlined, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _info() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.cone.name,
          style: GoogleFonts.fraunces(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Text(
          item.customizationSummary,
          style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.textSecondary),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),
        Text(AppFormatters.currency(item.totalPrice), style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700, color: AppColors.primary)),
      ],
    );
  }
}
