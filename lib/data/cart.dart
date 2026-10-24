import 'package:flutter/material.dart';

import 'food.dart';

/// Holds what is in the cart and tells listeners when it changes.
class Cart extends ChangeNotifier {
  final Map<Food, int> _items = {};

  Map<Food, int> get items => Map.unmodifiable(_items);

  int get count => _items.values.fold(0, (sum, qty) => sum + qty);

  double get total => _items.entries
      .fold(0, (sum, e) => sum + e.key.price * e.value);

  void add(Food food, [int qty = 1]) {
    _items[food] = (_items[food] ?? 0) + qty;
    notifyListeners();
  }

  void setQty(Food food, int qty) {
    if (qty <= 0) {
      _items.remove(food);
    } else {
      _items[food] = qty;
    }
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}

/// Makes the cart available to every screen below it.
class CartScope extends InheritedNotifier<Cart> {
  const CartScope({super.key, required Cart cart, required super.child})
      : super(notifier: cart);

  static Cart of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<CartScope>()!.notifier!;
}
