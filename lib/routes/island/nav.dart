import 'package:flutter/material.dart';
import 'package:island/common/utils/utils.dart';

class Nav extends StatefulWidget {
  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 20.0,
      child: Stack(
        children: <Widget>[
          Positioned(
              left: 20.0,
              child: Image.asset(
                  Utils.getImgPath("white_back_icon"),
                  width: 20.0,
                  height: 20.0,
              )
          ),
          Positioned(
              right: 20.0,
              child: Image.asset(
                  Utils.getImgPath("feeddetali_more"),
                  width: 20.0,
                  height: 20.0,
                  color: Colors.white
              )
          )
        ]
      )
    );
  }
}