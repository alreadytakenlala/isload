import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  String icon;
  String label;

  Menu({
    Key key,
    this.icon,
    this.label
  });

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.asset(
          widget.icon,
          width: 20.0,
        ),
        Container(
          margin: EdgeInsets.only(top: 5.0),
          child: Text(widget.label, style: TextStyle(
              color: Color(0xFF828282),
              fontSize: 12.0
          ))
        )
      ]
    );
  }
}