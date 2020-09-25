import 'package:flutter/material.dart';
import 'package:island/common/utils/utils.dart';

class MainNav extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainNavState();
}

class _MainNavState extends State<MainNav> {
  @override
  Widget build(BuildContext context) {
    return Stack(
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(left: 20.0, top: 30.0),
              child: Row(
                  children: <Widget>[
                    Container(
                        width: 50.0,
                        height: 40.0,
                        alignment: Alignment.bottomCenter,
                        child: Text("环游",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold
                            )
                        )
                    ),
                    Container(
                        width: 50.0,
                        height: 40.0,
                        alignment: Alignment.bottomCenter,
                        margin: EdgeInsets.only(left: 7.0),
                        child: Text("标记",
                            style: TextStyle(
                                color: Color(0xFF8f8f8f),
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold
                            )
                        )
                    )
                  ]
              )
          ),
          Container(
              alignment: Alignment.topRight,
              margin: EdgeInsets.only(top: 50.0, right: 68.0),
              child: Image.asset(Utils.getImgPath("maindrift_normal"),
                width: 22.0,
              )
          ),
          Container(
              alignment: Alignment.topRight,
              margin: EdgeInsets.only(top: 50.0, right: 20.0),
              child: Image.asset(Utils.getImgPath("main_randomplay"),
                  width: 22.0
              )
          )
        ]
    );
  }
}