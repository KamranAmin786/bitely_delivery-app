import 'dart:math';

import 'package:flutter/material.dart';

import '../data/cart.dart';
import '../data/food.dart';
import '../theme.dart';
import '../widgets/animated_price.dart';
import '../widgets/fade_slide.dart';
import '../widgets/qty_stepper.dart';
import '../widgets/size_selector.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.food});

  final Food food;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  int _size = 1;
  int _qty = 1;

  late final _float = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 4),
  )..repeat();

  static const _sizeExtra = [-1.5, 0.0, 2.5];
  static const _sizeScale = [0.85, 1.0, 1.12];

  double get _total => (widget.food.price + _sizeExtra[_size]) * _qty;

  @override
  void dispose() {
    _float.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final food = widget.food;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: Row(
                children: [
                  _roundButton(Icons.arrow_back_ios_new_rounded, () => Navigator.pop(context)),
                  const Spacer(),
                  _roundButton(Icons.favorite_border_rounded, () {}),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: AnimatedScale(
                  scale: _sizeScale[_size],
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOutBack,
                  child: AnimatedBuilder(
                    animation: _float,
                    builder: (context, child) {
                      final t = _float.value * 2 * pi;
                      return Transform.translate(
                        offset: Offset(0, sin(t) * 10),
                        child: Transform.rotate(angle: sin(t) * 0.06, child: child),
                      );
                    },
                    child: Hero(
                      tag: food.name,
                      child: Image.asset(food.image, width: 240),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeSlide(
                    delay: 150,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            food.name,
                            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: ink),
                          ),
                        ),
                        QtyStepper(
                          value: _qty,
                          onChanged: (v) => setState(() => _qty = v.clamp(1, 9)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  FadeSlide(
                    delay: 250,
                    child: Row(
                      children: [
                        _info(Icons.star_rounded, '${food.rating}', const Color(0xFFFFB800)),
                        _info(Icons.local_fire_department_rounded, '${food.calories} kcal', orange),
                        _info(Icons.schedule_rounded, '${food.minutes} min', const Color(0xFF4C8BF5)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  FadeSlide(
                    delay: 350,
                    child: Text(
                      food.description,
                      style: const TextStyle(fontSize: 14, height: 1.5, color: grey),
                    ),
                  ),
                  const SizedBox(height: 20),
                  FadeSlide(
                    delay: 450,
                    child: Row(
                      children: [
                        const Text('Size', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: ink)),
                        const Spacer(),
                        SizeSelector(
                          selected: _size,
                          onSelect: (i) => setState(() => _size = i),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  FadeSlide(
                    delay: 550,
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Total', style: TextStyle(fontSize: 13, color: grey)),
                            AnimatedPrice(
                              value: _total,
                              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: ink),
                            ),
                          ],
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              CartScope.of(context).add(food, _qty);
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 58,
                              decoration: BoxDecoration(
                                color: orange,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: orange.withValues(alpha: 0.4),
                                    blurRadius: 16,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Text(
                                  'Add to cart',
                                  style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _roundButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: Icon(icon, size: 20, color: ink),
      ),
    );
  }

  Widget _info(IconData icon, String text, Color color) {
    return Padding(
      padding: const EdgeInsets.only(right: 18),
      child: Row(
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 4),
          Text(text, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: ink)),
        ],
      ),
    );
  }
}
