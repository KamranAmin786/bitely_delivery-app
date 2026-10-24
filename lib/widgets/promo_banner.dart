import 'dart:math';

import 'package:flutter/material.dart';

import '../theme.dart';

/// Orange promo card with a scooter that bobs up and down.
class PromoBanner extends StatefulWidget {
  const PromoBanner({super.key});

  @override
  State<PromoBanner> createState() => _PromoBannerState();
}

class _PromoBannerState extends State<PromoBanner>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          colors: [Color(0xFFFF8A4C), orange],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(22, 22, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Free delivery',
                  style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800),
                ),
                SizedBox(height: 4),
                Text(
                  'on your first 3 orders',
                  style: TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 14),
                _OrderNowChip(),
              ],
            ),
          ),
          Positioned(
            right: 4,
            bottom: -10,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                final t = _controller.value * 2 * pi;
                return Transform.translate(
                  offset: Offset(0, sin(t) * 6),
                  child: Transform.rotate(angle: sin(t) * 0.04, child: child),
                );
              },
              child: Image.asset('assets/food/scooter.png', width: 150),
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderNowChip extends StatelessWidget {
  const _OrderNowChip();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: const Text(
        'Order now',
        style: TextStyle(color: orange, fontWeight: FontWeight.w700, fontSize: 13),
      ),
    );
  }
}
