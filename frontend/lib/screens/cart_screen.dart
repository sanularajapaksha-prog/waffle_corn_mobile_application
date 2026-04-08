import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../utils/app_colors.dart';
import '../utils/app_formatters.dart';
import '../utils/app_routes.dart';
import '../widgets/cart_item_tile.dart';
import '../widgets/custom_button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cart, _) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Cart', style: GoogleFonts.fraunces(fontSize: 28, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                      if (!cart.isEmpty)
                        TextButton(
                          onPressed: cart.clearCart,
                          child: const Text('Clear'),
                        ),
                    ],
                  ),
                ),
                Expanded(
                  child: cart.isEmpty
                      ? _emptyState(context)
                      : Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                                itemCount: cart.items.length,
                                itemBuilder: (context, index) => CartItemTile(item: cart.items[index], index: index),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                              padding: const EdgeInsets.all(18),
                              decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(18)),
                              child: Column(
                                children: [
                                  _summary('Subtotal', AppFormatters.currency(cart.subtotal)),
                                  _summary('Delivery', AppFormatters.currency(cart.deliveryFee)),
                                  const Divider(height: 24),
                                  _summary('Total', AppFormatters.currency(cart.total), highlight: true),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 16, 20, MediaQuery.of(context).padding.bottom + 16),
                              child: PrimaryButton(
                                label: 'Proceed to checkout',
                                onPressed: () => Navigator.pushNamed(context, AppRoutes.checkout),
                              ),
                            ),
                          ],
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _emptyState(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.shopping_bag_outlined, size: 52, color: AppColors.primary),
              const SizedBox(height: 16),
              Text('Your cart is empty', style: GoogleFonts.fraunces(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
              const SizedBox(height: 8),
              Text('Add a cone item from the catalog to begin checkout.', style: GoogleFonts.plusJakartaSans(fontSize: 14, color: AppColors.textSecondary), textAlign: TextAlign.center),
              const SizedBox(height: 24),
              PrimaryButton(label: 'Browse products', onPressed: () => Navigator.pushNamed(context, AppRoutes.productListing)),
            ],
          ),
        ),
      );

  Widget _summary(String label, String value, {bool highlight = false}) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: GoogleFonts.plusJakartaSans(color: AppColors.textSecondary)),
            Text(
              value,
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w700,
                color: highlight ? AppColors.primary : AppColors.textPrimary,
              ),
            ),
          ],
        ),
      );
}
