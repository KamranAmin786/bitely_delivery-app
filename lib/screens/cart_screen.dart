import 'package:flutter/material.dart';

import '../data/cart.dart';
import '../theme.dart';
import '../widgets/animated_price.dart';
import '../widgets/fade_slide.dart';
import '../widgets/qty_stepper.dart';
import 'tracking_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  static const delivery = 2.0;

  @override
  Widget build(BuildContext context) {
    final cart = CartScope.of(context);
    final entries = cart.items.entries.toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: cream,
        surfaceTintColor: cream,
        centerTitle: true,
        title: const Text('My Cart', style: TextStyle(fontWeight: FontWeight.w800, color: ink)),
      ),
      body: entries.isEmpty
          ? const Center(
              child: Text('Your cart is empty', style: TextStyle(color: grey, fontSize: 16)),
            )
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              itemCount: entries.length,
              itemBuilder: (context, i) {
                final food = entries[i].key;
                return FadeSlide(
                  key: ValueKey(food.name),
                  delay: 80 * i,
                  child: Dismissible(
                    key: ValueKey(food.name),
                    direction: DismissDirection.endToStart,
                    onDismissed: (_) => cart.setQty(food, 0),
                    background: Container(
                      margin: const EdgeInsets.only(bottom: 14),
                      padding: const EdgeInsets.only(right: 24),
                      alignment: Alignment.centerRight,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF4D4F),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: const Icon(Icons.delete_rounded, color: Colors.white),
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 14),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: cream,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Image.asset(food.image),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(food.name, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: ink)),
                                const SizedBox(height: 6),
                                Text(
                                  '\$${food.price.toStringAsFixed(2)}',
                                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: orange),
                                ),
                              ],
                            ),
                          ),
                          QtyStepper(
                            value: entries[i].value,
                            onChanged: (v) => cart.setQty(food, v),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: entries.isEmpty ? null : _summary(context, cart),
    );
  }

  Widget _summary(BuildContext context, Cart cart) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 34),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _row('Subtotal', cart.total),
          const SizedBox(height: 10),
          _row('Delivery', delivery),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: Divider(height: 1, color: Color(0xFFF0E6DD)),
          ),
          _row('Total', cart.total + delivery, big: true),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const TrackingScreen()),
            ),
            child: Container(
              height: 58,
              decoration: BoxDecoration(color: orange, borderRadius: BorderRadius.circular(20)),
              child: const Center(
                child: Text(
                  'Checkout',
                  style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(String label, double value, {bool big = false}) {
    final style = TextStyle(
      fontSize: big ? 20 : 15,
      fontWeight: big ? FontWeight.w800 : FontWeight.w600,
      color: big ? ink : grey,
    );
    return Row(
      children: [
        Text(label, style: style),
        const Spacer(),
        AnimatedPrice(value: value, style: style.copyWith(color: ink)),
      ],
    );
  }
}
