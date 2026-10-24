import 'package:flutter/material.dart';

/// Flies a copy of [image] from [from] to [to] along a curve,
/// shrinking as it goes, then calls [onArrive].
void flyToCart({
  required BuildContext context,
  required String image,
  required Rect from,
  required Offset to,
  required VoidCallback onArrive,
}) {
  final overlay = Overlay.of(context);
  late OverlayEntry entry;
  entry = OverlayEntry(
    builder: (context) => TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
      onEnd: () {
        entry.remove();
        onArrive();
      },
      builder: (context, t, child) {
        // Quadratic bezier: start, a control point above, end.
        final start = from.center;
        final control = Offset((start.dx + to.dx) / 2, start.dy - 220);
        final p = Offset(
          (1 - t) * (1 - t) * start.dx + 2 * (1 - t) * t * control.dx + t * t * to.dx,
          (1 - t) * (1 - t) * start.dy + 2 * (1 - t) * t * control.dy + t * t * to.dy,
        );
        final size = from.width * (1 - 0.75 * t);
        return Positioned(
          left: p.dx - size / 2,
          top: p.dy - size / 2,
          width: size,
          height: size,
          child: Transform.rotate(angle: t * 6.28, child: child),
        );
      },
      child: Image.asset(image),
    ),
  );
  overlay.insert(entry);
}
