import 'package:flutter/material.dart';

import '../data/cart.dart';
import '../theme.dart';
import '../widgets/route_map.dart';

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({super.key});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen>
    with SingleTickerProviderStateMixin {
  late final _trip = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 9),
  )..forward();

  static const _steps = [
    ('Order confirmed', Icons.check_rounded),
    ('Preparing your food', Icons.restaurant_rounded),
    ('On the way', Icons.delivery_dining_rounded),
    ('Delivered', Icons.home_rounded),
  ];

  @override
  void dispose() {
    _trip.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: cream,
        surfaceTintColor: cream,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () {
            CartScope.of(context).clear();
            Navigator.pop(context);
          },
        ),
        title: const Text('Track order', style: TextStyle(fontWeight: FontWeight.w800, color: ink)),
      ),
      body: AnimatedBuilder(
        animation: _trip,
        builder: (context, _) {
          final t = _trip.value;
          // The scooter waits while the food is being prepared, then drives.
          final drive = Curves.easeInOut.transform(((t - 0.3) / 0.65).clamp(0, 1));
          final step = t < 0.15 ? 0 : t < 0.3 ? 1 : t < 0.97 ? 2 : 3;
          final minutes = (25 * (1 - t)).ceil();
          return Column(
            children: [
              Container(
                height: 320,
                margin: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFEFE3),
                  borderRadius: BorderRadius.circular(32),
                ),
                child: RouteMap(progress: drive),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    const Text('Arriving in', style: TextStyle(fontSize: 16, color: grey, fontWeight: FontWeight.w600)),
                    const Spacer(),
                    Text(
                      step == 3 ? 'Enjoy!' : '$minutes min',
                      style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: orange),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              for (var i = 0; i < _steps.length; i++) _stepRow(i, step),
              const Spacer(),
              _riderCard(),
            ],
          );
        },
      ),
    );
  }

  Widget _riderCard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: ink, borderRadius: BorderRadius.circular(24)),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.white12, borderRadius: BorderRadius.circular(16)),
            child: Image.asset('assets/food/scooter.png'),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Sam Carter', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
                SizedBox(height: 2),
                Text('Your rider', style: TextStyle(color: Colors.white60, fontSize: 13)),
              ],
            ),
          ),
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(color: orange, borderRadius: BorderRadius.circular(16)),
            child: const Icon(Icons.call_rounded, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _stepRow(int i, int current) {
    final done = i <= current;
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutBack,
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: done ? orange : Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: done ? orange : const Color(0xFFE6D8CC), width: 2),
                ),
                child: Icon(_steps[i].$2, size: 20, color: done ? Colors.white : grey),
              ),
              if (i < _steps.length - 1)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  width: 3,
                  height: 26,
                  color: i < current ? orange : const Color(0xFFE6D8CC),
                ),
            ],
          ),
          const SizedBox(width: 14),
          Padding(
            padding: const EdgeInsets.only(top: 9),
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 15,
                fontWeight: i == current ? FontWeight.w800 : FontWeight.w600,
                color: done ? ink : grey,
              ),
              child: Text(_steps[i].$1),
            ),
          ),
        ],
      ),
    );
  }
}
