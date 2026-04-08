import 'package:flutter/foundation.dart';

import '../models/cart_item.dart';
import '../models/waffle_cone.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);
  int get totalItems => _items.fold(0, (sum, item) => sum + item.quantity);
  bool get isEmpty => _items.isEmpty;
  double get subtotal => _items.fold(0.0, (sum, item) => sum + item.totalPrice);
  double get deliveryFee => subtotal > 0 ? 120.0 : 0.0;
  double get total => subtotal + deliveryFee;

  void addItem(
    WaffleCone cone, {
    required String productType,
    required String size,
    List<String> tints = const [],
    int quantity = 1,
  }) {
    final newItem = CartItem(
      cone: cone,
      productType: productType,
      size: size,
      tints: List<String>.from(tints),
      quantity: quantity,
    );
    final existingIndex = _items.indexWhere((item) => item.cartKey == newItem.cartKey);
    if (existingIndex >= 0) {
      _items[existingIndex].quantity += quantity;
    } else {
      _items.add(newItem);
    }
    notifyListeners();
  }

  void incrementItem(int index) {
    if (index < 0 || index >= _items.length) return;
    _items[index].quantity++;
    notifyListeners();
  }

  void decrementItem(int index) {
    if (index < 0 || index >= _items.length) return;
    if (_items[index].quantity <= 1) {
      _items.removeAt(index);
    } else {
      _items[index].quantity--;
    }
    notifyListeners();
  }

  void setItemQuantity(int index, int quantity) {
    if (index < 0 || index >= _items.length) return;
    if (quantity <= 0) {
      _items.removeAt(index);
    } else {
      _items[index].quantity = quantity;
    }
    notifyListeners();
  }

  void removeItem(int index) {
    if (index < 0 || index >= _items.length) return;
    _items.removeAt(index);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
