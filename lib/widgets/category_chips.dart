import 'package:flutter/material.dart';

import '../data/food.dart';
import '../theme.dart';

/// Category chips with an orange pill that slides to the selected one.
class CategoryChips extends StatelessWidget {
  const CategoryChips({super.key, required this.selected, required this.onSelect});

  final int selected;
  final ValueChanged<int> onSelect;

  static const chipWidth = 108.0;
  static const gap = 10.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutBack,
              left: selected * (chipWidth + gap),
              top: 0,
              bottom: 0,
              width: chipWidth,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: orange,
                  borderRadius: BorderRadius.circular(26),
                  boxShadow: [
                    BoxShadow(
                      color: orange.withValues(alpha: 0.35),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                for (var i = 0; i < categories.length; i++)
                  GestureDetector(
                    onTap: () => onSelect(i),
                    child: Container(
                      width: chipWidth,
                      height: 52,
                      margin: const EdgeInsets.only(right: gap),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26),
                        border: Border.all(
                          color: i == selected ? Colors.transparent : const Color(0xFFF0E6DD),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(categoryImages[categories[i]]!, width: 24),
                          const SizedBox(width: 6),
                          AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 250),
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: i == selected ? Colors.white : ink,
                            ),
                            child: Text(categories[i]),
                          ),
                        ],
                      ),
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
