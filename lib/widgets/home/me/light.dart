import 'dart:math';

import 'package:flutter/material.dart';

class Light extends StatefulWidget {
  final double radius;
  final Color color;
  final int duration;

  Light({
    Key key,
    @required this.radius,
    @required this.color,
    @required this.duration
  });

  @override
  _LightState createState() => _LightState();
}

class _LightState extends State<Light> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(vsync: this, duration: Duration(milliseconds: widget.duration))
      ..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: _LightPainter(_controller.value, radius: widget.radius, color: widget.color)
        );
      }
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

class _LightPainter extends CustomPainter {
  final double progress;
  final double radius;
  final Color color;
  Paint _paint = new Paint()
    ..style = PaintingStyle.fill;

  _LightPainter(
      this.progress,
      {
        @required this.radius,
        @required this.color
      }
  );

  @override
  void paint(Canvas canvas, Size size) {
    double _progress = (max(progress-0.8,0)).abs()/0.2;
    Color _color = color.withOpacity(1-_progress);
    canvas.drawCircle(Offset(radius/2, radius/2), radius*_progress, _paint..color=_color);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}