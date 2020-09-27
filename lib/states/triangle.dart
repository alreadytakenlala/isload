import 'package:flutter/material.dart';

class Coordinate {
  final double cx;
  final double cy;
  Coordinate({this.cx, this.cy});
}

class Triangle extends CustomPainter {
  Paint _paint = new Paint();
  final BuildContext context;
  final List spots;
  final Color color;
  Triangle(this.context,this.spots,this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Path path = new Path();
    path.moveTo(spots[0].cx, spots[0].cy);
    path.lineTo(spots[1].cx, spots[1].cy);
    path.lineTo(spots[2].cx, spots[2].cy);
    _paint.style = PaintingStyle.fill;
    _paint.color = color;
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}