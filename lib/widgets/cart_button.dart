import 'package:flutter/material.dart';

import '../data/cart.dart';
import '../theme.dart';

/// Cart icon with a badge that pops every time the count changes.
class CartButton extends StatelessWidget {
  const CartButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final count = CartScope.of(context).count;
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 52,
        height: 52,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              decoration: BoxDecoration(
                color: ink,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Center(
                child: Icon(Icons.shopping_bag_rounded, color: Colors.white, size: 24),
              ),
            ),
            if (count > 0)
              Positioned(
                right: -6,
                top: -6,
                child: TweenAnimationBuilder<double>(
                  key: ValueKey(count),
                  tween: Tween(begin: 1.6, end: 1),
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.elasticOut,
                  builder: (context, scale, child) =>
                      Transform.scale(scale: scale, child: child),
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: orange,
                      shape: BoxShape.circle,
                      border: Border.all(color: cream, width: 2.5),
                    ),
                    child: Center(
                      child: Text(
                        '$count',
                        style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
