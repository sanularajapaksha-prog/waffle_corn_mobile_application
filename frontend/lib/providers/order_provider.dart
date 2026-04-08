import 'package:flutter/foundation.dart';

import '../models/cart_item.dart';
import '../models/order_result.dart';
import '../models/placed_order.dart';

class OrderProvider with ChangeNotifier {
  final List<PlacedOrder> _orders = [
    PlacedOrder(
      id: 'CC-10214',
      items: [],
      total: 420,
      address: '12 Galle Road, Colombo 04',
      paymentMethod: PaymentMethod.cash,
      status: 'Delivered',
      placedAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    PlacedOrder(
      id: 'CC-10982',
      items: [],
      total: 265,
      address: '88 High Level Road, Nugegoda',
      paymentMethod: PaymentMethod.card,
      status: 'Preparing',
      placedAt: DateTime.now().subtract(const Duration(hours: 5)),
    ),
  ];

  List<PlacedOrder> get orders => List.unmodifiable(_orders);

  PlacedOrder placeOrder({
    required String id,
    required List<CartItem> items,
    required double total,
    required String address,
    required PaymentMethod paymentMethod,
  }) {
    final order = PlacedOrder(
      id: id,
      items: items.map((item) => item.copyForOrder()).toList(),
      total: total,
      address: address,
      paymentMethod: paymentMethod,
      status: paymentMethod == PaymentMethod.bankTransfer ? 'Pending Verification' : 'Preparing',
      placedAt: DateTime.now(),
    );
    _orders.insert(0, order);
    notifyListeners();
    return order;
  }
}
