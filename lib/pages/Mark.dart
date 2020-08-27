import 'package:flutter/material.dart';

class Mark extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MarkState();
  }
}

class _MarkState extends State<Mark> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: new Text("标记"),
    );
  }
}