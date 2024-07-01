import 'dart:math';

import 'package:flutter/material.dart';

class HeartBeatAnimation extends StatefulWidget {
  final bool isRunning;

  HeartBeatAnimation({Key? key, required this.isRunning}) : super(key: key);

  @override
  _HeartBeatAnimationState createState() => _HeartBeatAnimationState();
}

class _HeartBeatAnimationState extends State<HeartBeatAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.isRunning ? Duration(seconds: 1) : Duration(seconds: 5),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        size: Size(100, 100),
        painter: HeartPainter(beatAnimation: _controller),
      ),
    );
  }
}

class HeartPainter extends CustomPainter {
  final Animation<double> beatAnimation;

  HeartPainter({required this.beatAnimation}) : super(repaint: beatAnimation);

  @override
  void paint(Canvas canvas, Size size) {
    final double x0 = size.width / 2;
    final double y0 = size.height / 2;

    final double heartSize = size.width / 30;

    final Path path = Path();
    path.moveTo(x0, y0 - heartSize);

    for (double t = 0.0; t <= 2 * 3.14; t += 0.05) {
      double x = 16 * pow(sin(t), 3) as double;
      double y = 13 * cos(t) - 5 * cos(2 * t) - 2 * cos(3 * t) - cos(4 * t);
      x = x * heartSize + x0;
      y = -y * heartSize + y0;

      double scale = 1 + 0.1 * sin(beatAnimation.value * pi * 2);
      x = x0 + (x - x0) * scale;
      y = y0 + (y - y0) * scale;

      path.lineTo(x, y);
    }

    path.close();

    canvas.drawPath(
        path,
        Paint()
          ..color = Colors.red
          ..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
