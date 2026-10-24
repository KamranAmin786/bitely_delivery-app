import 'package:flutter/material.dart';

import '../theme.dart';

/// S / M / L selector with a white indicator that slides between them.
class SizeSelector extends StatelessWidget {
  const SizeSelector({super.key, required this.selected, required this.onSelect});

  final int selected;
  final ValueChanged<int> onSelect;

  static const sizes = ['S', 'M', 'L'];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 52,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: const Color(0xFFF3E9E1),
        borderRadius: BorderRadius.circular(26),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeOutBack,
            alignment: Alignment(-1 + selected * 1.0, 0),
            child: FractionallySizedBox(
              widthFactor: 1 / 3,
              child: Container(
                decoration: BoxDecoration(
                  color: orange,
                  borderRadius: BorderRadius.circular(21),
                ),
              ),
            ),
          ),
          Row(
            children: [
              for (var i = 0; i < sizes.length; i++)
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => onSelect(i),
                    child: Center(
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 250),
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: i == selected ? Colors.white : ink,
                        ),
                        child: Text(sizes[i]),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
