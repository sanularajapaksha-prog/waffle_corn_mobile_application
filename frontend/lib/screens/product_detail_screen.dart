import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/waffle_cone.dart';
import '../providers/cart_provider.dart';
import '../utils/app_colors.dart';
import '../utils/app_formatters.dart';
import '../widgets/custom_button.dart';
import '../widgets/quantity_stepper.dart';

class ProductDetailScreen extends StatefulWidget {
  final WaffleCone cone;

  const ProductDetailScreen({super.key, required this.cone});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late String _productType;
  late String _size;
  final Set<String> _tints = {};
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    _productType = widget.cone.productTypes.first;
    _size = widget.cone.sizePricing.keys.first;
  }

  double get _unitPrice => (widget.cone.sizePricing[_size] ?? widget.cone.price) + (_tints.length * widget.cone.tintPrice);
  double get _total => _unitPrice * _quantity;

  void _addToCart() {
    context.read<CartProvider>().addItem(
          widget.cone,
          productType: _productType,
          size: _size,
          tints: _tints.toList(),
          quantity: _quantity,
        );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${widget.cone.name} added to cart.')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final gradient = AppColors.categoryGradient(widget.cone.category);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 280,
                        child: Image.network(
                          widget.cone.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: gradient),
                            ),
                            child: const Icon(Icons.icecream_outlined, size: 72, color: Colors.white),
                          ),
                        ),
                      ),
                      SafeArea(
                        child: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back_ios_new_rounded),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.cone.name, style: GoogleFonts.fraunces(fontSize: 28, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                        const SizedBox(height: 8),
                        Text(widget.cone.description, style: GoogleFonts.plusJakartaSans(fontSize: 14, height: 1.6, color: AppColors.textSecondary)),
                        const SizedBox(height: 18),
                        Text(AppFormatters.currency(_unitPrice), style: GoogleFonts.plusJakartaSans(fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.primary)),
                        const SizedBox(height: 20),
                        _label('Product type'),
                        const SizedBox(height: 8),
                        ...widget.cone.productTypes.map((type) => RadioListTile<String>(
                              value: type,
                              groupValue: _productType,
                              onChanged: (value) => setState(() => _productType = value!),
                              title: Text(
                                type,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              activeColor: AppColors.primary,
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                            )),
                        const SizedBox(height: 12),
                        _label('Size'),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: widget.cone.sizePricing.entries.map((entry) {
                            final selected = _size == entry.key;
                            return ChoiceChip(
                              label: Text(
                                '${entry.key} (${AppFormatters.currency(entry.value)})',
                                overflow: TextOverflow.ellipsis,
                              ),
                              selected: selected,
                              onSelected: (_) => setState(() => _size = entry.key),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 20),
                        _label('Color / tint'),
                        const SizedBox(height: 6),
                        Text(
                          'Each selected tint adds ${AppFormatters.currency(widget.cone.tintPrice)}.',
                          style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.textSecondary),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: widget.cone.tintOptions.map((tint) {
                            final selected = _tints.contains(tint);
                            return FilterChip(
                              label: Text(
                                tint,
                                overflow: TextOverflow.ellipsis,
                              ),
                              selected: selected,
                              onSelected: (_) {
                                setState(() {
                                  if (selected) {
                                    _tints.remove(tint);
                                  } else {
                                    _tints.add(tint);
                                  }
                                });
                              },
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 20),
                        _label('Quantity'),
                        const SizedBox(height: 8),
                        QuantityStepper(
                          quantity: _quantity,
                          onIncrement: () => setState(() => _quantity++),
                          onDecrement: () => setState(() => _quantity = _quantity > 1 ? _quantity - 1 : 1),
                          onQuantitySubmitted: (value) => setState(() => _quantity = value),
                        ),
                        const SizedBox(height: 24),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _amountRow('Base amount', AppFormatters.currency(widget.cone.sizePricing[_size] ?? widget.cone.price)),
                              _amountRow('Tint charges', AppFormatters.currency(_tints.length * widget.cone.tintPrice)),
                              _amountRow('Quantity', 'x$_quantity'),
                              const Divider(height: 24),
                              _amountRow('Total preview', AppFormatters.currency(_total), highlight: true),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 12, 20, MediaQuery.of(context).padding.bottom + 16),
            child: PrimaryButton(
              label: 'Add to cart',
              onPressed: _addToCart,
            ),
          ),
        ],
      ),
    );
  }

  Widget _label(String text) => Text(
        text,
        style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textSecondary),
      );

  Widget _amountRow(String label, String value, {bool highlight = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.plusJakartaSans(color: AppColors.textSecondary),
            ),
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w700,
                color: highlight ? AppColors.primary : AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
