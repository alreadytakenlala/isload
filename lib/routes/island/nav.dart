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
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 20.0,
            top: 50.0,
            child: Image.asset(
                Utils.getImgPath("umeng_socialize_back_icon"),
                width: 10.0
            )
          ),
          Positioned(
            right: 20.0,
            top: 50.0,
            child: Image.asset(
              Utils.getImgPath("ic_feeddetali_more"),
              width: 20.0
            )
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(top: 160.0),
                        child: Text("穿搭", style: TextStyle(
                            color: Colors.white,
                            fontSize: 26.0,
                            decoration: TextDecoration.none
                        ))
                    )
                  ]
              )
            )
          )
        ]
      )
    );
  }
}