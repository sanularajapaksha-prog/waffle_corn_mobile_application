import 'waffle_cone.dart';

class CartItem {
  final WaffleCone cone;
  final String productType;
  final String size;
  final List<String> tints;
  int quantity;

  CartItem({
    required this.cone,
    required this.productType,
    required this.size,
    required this.tints,
    this.quantity = 1,
  });

  double get baseUnitPrice => cone.sizePricing[size] ?? cone.price;
  double get tintCharge => tints.length * cone.tintPrice;
  double get unitPrice => baseUnitPrice + tintCharge;
  double get totalPrice => unitPrice * quantity;

  String get customizationSummary {
    final tintText = tints.isEmpty ? 'No tint' : tints.join(', ');
    return '$productType · $size · $tintText';
  }

  String get cartKey {
    final sortedTints = List<String>.from(tints)..sort();
    return '${cone.id}_${productType}_${size}_${sortedTints.join(',')}';
  }

  CartItem copyForOrder() {
    return CartItem(
      cone: cone,
      productType: productType,
      size: size,
      tints: List<String>.from(tints),
      quantity: quantity,
    );
  }
}
