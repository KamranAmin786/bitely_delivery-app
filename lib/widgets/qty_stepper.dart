import 'package:flutter/material.dart';

import '../theme.dart';

/// Minus / count / plus. The number slides up or down when it changes.
class QtyStepper extends StatelessWidget {
  const QtyStepper({super.key, required this.value, required this.onChanged, this.dark = false});

  final int value;
  final ValueChanged<int> onChanged;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _button(Icons.remove_rounded, () => onChanged(value - 1)),
        SizedBox(
          width: 36,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            transitionBuilder: (child, animation) => SlideTransition(
              position: Tween(begin: const Offset(0, 0.6), end: Offset.zero).animate(animation),
              child: FadeTransition(opacity: animation, child: child),
            ),
            child: Text(
              '$value',
              key: ValueKey(value),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: ink),
            ),
          ),
        ),
        _button(Icons.add_rounded, () => onChanged(value + 1), filled: true),
      ],
    );
  }

  Widget _button(IconData icon, VoidCallback onTap, {bool filled = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: filled ? orange : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: filled ? null : Border.all(color: const Color(0xFFEADFD6)),
        ),
        child: Icon(icon, size: 20, color: filled ? Colors.white : ink),
      ),
    );
  }
}
