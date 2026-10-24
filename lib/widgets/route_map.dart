import 'package:flutter/material.dart';

import '../theme.dart';

/// Draws a dashed route from the store to the house and moves the
/// scooter along it. [progress] goes from 0 to 1.
class RouteMap extends StatelessWidget {
  const RouteMap({super.key, required this.progress});

  final double progress;

  static Path routeFor(Size size) => Path()
    ..moveTo(size.width * 0.18, size.height * 0.80)
    ..cubicTo(
      size.width * 0.15, size.height * 0.30,
      size.width * 0.60, size.height * 0.95,
      size.width * 0.82, size.height * 0.22,
    );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest;
        final metric = routeFor(size).computeMetrics().first;
        final tangent = metric.getTangentForOffset(metric.length * progress)!;
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(child: CustomPaint(painter: _RoutePainter(progress))),
            _pin('assets/food/store.png', Offset(size.width * 0.18, size.height * 0.80)),
            _pin('assets/food/house.png', Offset(size.width * 0.82, size.height * 0.22)),
            Positioned(
              left: tangent.position.dx - 32,
              top: tangent.position.dy - 50,
              child: Image.asset('assets/food/scooter.png', width: 64),
            ),
          ],
        );
      },
    );
  }

  Widget _pin(String image, Offset at) {
    return Positioned(
      left: at.dx - 30,
      top: at.dy - 30,
      child: Container(
        width: 60,
        height: 60,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 12, offset: const Offset(0, 4)),
          ],
        ),
        child: Image.asset(image),
      ),
    );
  }
}

class _RoutePainter extends CustomPainter {
  _RoutePainter(this.progress);

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final metric = RouteMap.routeFor(size).computeMetrics().first;
    final dash = Paint()
      ..color = const Color(0xFFE3D3C6)
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    for (double d = 0; d < metric.length; d += 18) {
      canvas.drawPath(metric.extractPath(d, d + 9), dash);
    }
    // The part already travelled is solid orange.
    final done = Paint()
      ..color = orange
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawPath(metric.extractPath(0, metric.length * progress), done);
  }

  @override
  bool shouldRepaint(_RoutePainter old) => old.progress != progress;
}
