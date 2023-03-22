import 'package:flutter/material.dart';

class BorderGradient extends StatelessWidget {
  final _GradientPainter painter;
  final double radius;
  final double strokeWidth;

  BorderGradient({
    Key? key,
    required this.strokeWidth,
    required this.radius,
    required Gradient gradient,
  })  : painter = _GradientPainter(
            strokeWidth: strokeWidth, radius: radius, gradient: gradient),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: painter,
      child: Container(),
    );
  }
}

class _GradientPainter extends CustomPainter {
  final Paint _paint = Paint();
  final double radius;
  final double strokeWidth;
  final Gradient gradient;

  _GradientPainter(
      {required this.strokeWidth,
      required this.radius,
      required this.gradient});

  @override
  void paint(Canvas canvas, Size size) {
    Rect outerRect = Offset.zero & size;
    var outerRRect =
        RRect.fromRectAndRadius(outerRect, Radius.circular(radius));

    Rect innerRect = Rect.fromLTWH(strokeWidth, strokeWidth,
        size.width - strokeWidth * 2, size.height - strokeWidth * 2);
    var innerRRect = RRect.fromRectAndRadius(
        innerRect, Radius.circular(radius - strokeWidth));

    _paint.shader = gradient.createShader(outerRect);

    Path path1 = Path()..addRRect(outerRRect);
    Path path2 = Path()..addRRect(innerRRect);
    var path = Path.combine(PathOperation.difference, path1, path2);
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;
}
