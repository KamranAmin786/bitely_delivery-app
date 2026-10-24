import 'package:flutter/material.dart';

import '../data/food.dart';
import '../theme.dart';

/// One food in the grid. The add button reports where the image is,
/// so the home screen can fly a copy of it to the cart.
class FoodCard extends StatelessWidget {
  const FoodCard({super.key, required this.food, required this.onTap, required this.onAdd});

  final Food food;
  final VoidCallback onTap;
  final void Function(GlobalKey imageKey) onAdd;

  @override
  Widget build(BuildContext context) {
    final imageKey = GlobalKey();
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFE9D9CC).withValues(alpha: 0.6),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: Hero(
                  tag: food.name,
                  child: Image.asset(food.image, key: imageKey),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              food.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: ink),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.star_rounded, size: 16, color: Color(0xFFFFB800)),
                Text(
                  ' ${food.rating}  ·  ${food.minutes} min',
                  style: const TextStyle(fontSize: 12, color: grey, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  '\$${food.price.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: ink),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => onAdd(imageKey),
                  child: Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(color: orange, borderRadius: BorderRadius.circular(12)),
                    child: const Icon(Icons.add_rounded, color: Colors.white, size: 22),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
