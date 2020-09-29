import 'package:flutter/material.dart';
import 'package:island/common/utils/utils.dart';

class Entrance extends StatefulWidget {
  @override
  _EntranceState createState() => _EntranceState();
}

class _EntranceState extends State<Entrance> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Color(0xFF0e0e0e),
      child: Stack(
        children: <Widget>[
          Image.asset(
            Utils.getImgPath("img_splash_top"),
            width: MediaQuery.of(context).size.width
          ),
          Positioned(
            bottom: 60.0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: Image.asset(
                  Utils.getImgPath("start_text"),
                  width: 160.0
              )
            )
          )
        ]
      )
    );
  }
}