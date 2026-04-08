import 'cart_item.dart';
import 'order_result.dart';

class PlacedOrder {
  final String id;
  final List<CartItem> items;
  final double total;
  final String address;
  final PaymentMethod paymentMethod;
  final String status;
  final DateTime placedAt;

  const PlacedOrder({
    required this.id,
    required this.items,
    required this.total,
    required this.address,
    required this.paymentMethod,
    required this.status,
    required this.placedAt,
  });
}
