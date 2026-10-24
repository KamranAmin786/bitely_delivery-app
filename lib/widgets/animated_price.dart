import 'package:flutter/material.dart';

/// Counts smoothly from the old price to the new one.
class AnimatedPrice extends StatelessWidget {
  const AnimatedPrice({super.key, required this.value, required this.style});

  final double value;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(end: value),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
      builder: (context, v, _) => Text('\$${v.toStringAsFixed(2)}', style: style),
    );
  }
}
