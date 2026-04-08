import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/order_result.dart';
import '../providers/cart_provider.dart';
import '../providers/order_provider.dart';
import '../utils/app_colors.dart';
import '../utils/app_formatters.dart';
import '../utils/app_routes.dart';
import '../widgets/custom_button.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  PaymentMethod _method = PaymentMethod.cash;
  bool _loading = false;
  final _address = TextEditingController(text: '42 Ocean View Avenue, Colombo 03');
  String? _slipName;
  final _cardName = TextEditingController();
  final _cardNumber = TextEditingController();

  @override
  void dispose() {
    _address.dispose();
    _cardName.dispose();
    _cardNumber.dispose();
    super.dispose();
  }

  Future<void> _uploadSlip() async {
    final source = await showModalBottomSheet<String>(
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(title: const Text('Take photo'), onTap: () => Navigator.pop(context, 'camera')),
            ListTile(title: const Text('Choose from gallery'), onTap: () => Navigator.pop(context, 'gallery')),
            ListTile(title: const Text('Browse files'), onTap: () => Navigator.pop(context, 'files')),
          ],
        ),
      ),
    );
    if (source == null) return;
    setState(() => _slipName = 'slip-$source-${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}.jpg');
  }

  Future<void> _copyBankValue(String label, String value) async {
    await Clipboard.setData(ClipboardData(text: value));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$label copied.')));
  }

  Future<void> _submit() async {
    final cart = context.read<CartProvider>();
    if (cart.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Add an item to cart before checkout.')));
      return;
    }
    if (_method == PaymentMethod.card && (_cardName.text.isEmpty || _cardNumber.text.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter card details to continue.')));
      return;
    }
    if (_method == PaymentMethod.bankTransfer && _slipName == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Upload a payment slip for bank transfer.')));
      return;
    }
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    final orderId = 'CC-${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}';
    context.read<OrderProvider>().placeOrder(
          id: orderId,
          items: cart.items,
          total: cart.total,
          address: _address.text.trim(),
          paymentMethod: _method,
        );
    cart.clearCart();
    Navigator.pushReplacementNamed(
      context,
      AppRoutes.orderConfirmation,
      arguments: OrderResult(orderNumber: orderId, paymentMethod: _method, slipFileName: _slipName),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text('Checkout', style: GoogleFonts.fraunces(fontWeight: FontWeight.w700, color: AppColors.textPrimary))),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Delivery address', style: GoogleFonts.fraunces(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
              const SizedBox(height: 12),
              TextField(
                controller: _address,
                decoration: const InputDecoration(labelText: 'Address'),
              ),
              const SizedBox(height: 24),
              Text('Payment method', style: GoogleFonts.fraunces(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
              const SizedBox(height: 12),
              ...[PaymentMethod.cash, PaymentMethod.card, PaymentMethod.bankTransfer].map((method) => RadioListTile<PaymentMethod>(
                    value: method,
                    groupValue: _method,
                    onChanged: (value) => setState(() => _method = value!),
                    activeColor: AppColors.primary,
                    title: Text(method.label),
                  )),
              if (_method == PaymentMethod.card) ...[
                const SizedBox(height: 12),
                TextField(controller: _cardName, decoration: const InputDecoration(labelText: 'Cardholder name')),
                const SizedBox(height: 12),
                TextField(controller: _cardNumber, decoration: const InputDecoration(labelText: 'Card number')),
              ],
              if (_method == PaymentMethod.bankTransfer) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(18)),
                  child: Column(
                    children: [
                      _bankRow('Account name', 'Puffy Woffle Holdings', () => _copyBankValue('Account name', 'Puffy Woffle Holdings')),
                      _bankRow('Bank', 'Commercial Bank of Ceylon', () => _copyBankValue('Bank', 'Commercial Bank of Ceylon')),
                      _bankRow('Account number', '77854001234', () => _copyBankValue('Account number', '77854001234'), last: true),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(18), border: Border.all(color: AppColors.surfaceDark)),
                  child: _slipName == null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Upload payment slip', style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                            const SizedBox(height: 8),
                            Text('Orders paid via account transfer remain in Pending Verification until reviewed.', style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.textSecondary)),
                            const SizedBox(height: 12),
                            OutlinedPillButton(label: 'Select slip', onPressed: _uploadSlip),
                          ],
                        )
                      : Row(
                          children: [
                            const Icon(Icons.receipt_long_rounded, color: AppColors.primary),
                            const SizedBox(width: 10),
                            Expanded(child: Text(_slipName!, style: GoogleFonts.plusJakartaSans(color: AppColors.textPrimary))),
                            IconButton(onPressed: () => setState(() => _slipName = null), icon: const Icon(Icons.close_rounded)),
                          ],
                        ),
                ),
              ],
              const SizedBox(height: 24),
              Text('Order summary', style: GoogleFonts.fraunces(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(18)),
                child: Column(
                  children: [
                    ...cart.items.map((item) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(child: Text('${item.cone.name} x${item.quantity}', style: GoogleFonts.plusJakartaSans(color: AppColors.textPrimary))),
                              Text(AppFormatters.currency(item.totalPrice), style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700)),
                            ],
                          ),
                        )),
                    const Divider(height: 24),
                    _summary('Subtotal', AppFormatters.currency(cart.subtotal)),
                    _summary('Delivery', AppFormatters.currency(cart.deliveryFee)),
                    _summary('Total', AppFormatters.currency(cart.total), highlight: true),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              PrimaryButton(label: 'Place order', isLoading: _loading, onPressed: cart.isEmpty ? null : _submit),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bankRow(String label, String value, VoidCallback onCopy, {bool last = false}) => Padding(
        padding: EdgeInsets.only(bottom: last ? 0 : 12),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxWidth < 340;
            final info = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.textSecondary)),
                Text(
                  value,
                  style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                  maxLines: compact ? 2 : 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            );
            if (compact) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  info,
                  const SizedBox(height: 6),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(onPressed: onCopy, child: const Text('Copy')),
                  ),
                ],
              );
            }
            return Row(
              children: [
                Expanded(child: info),
                TextButton(onPressed: onCopy, child: const Text('Copy')),
              ],
            );
          },
        ),
      );

  Widget _summary(String label, String value, {bool highlight = false}) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            Expanded(
              child: Text(label, style: GoogleFonts.plusJakartaSans(color: AppColors.textSecondary)),
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Text(
                value,
                textAlign: TextAlign.right,
                style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700, color: highlight ? AppColors.primary : AppColors.textPrimary),
              ),
            ),
          ],
        ),
      );
}
