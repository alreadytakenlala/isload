import 'package:flutter/material.dart';
import 'package:island/modules/nav_data.dart';

class NavBanner extends StatelessWidget {
  final NavData nav;
  NavBanner({
    Key key,
    this.nav
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xFF0e0e0e),
        width: double.infinity,
        height: double.infinity,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                transform: Matrix4.translationValues(0, -95, 0),
                child: Image.asset(
                    nav.imgUrl,
                    width: 200.0
                )
              ),
              Container(
                  transform: Matrix4.translationValues(0, -77, 0),
                  child: Text(
                      nav.label,
                      style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          height: 3.0,
                          fontSize: 16.0
                      )
                  )
              ),
              Container(
                  transform: Matrix4.translationValues(0, -73, 0),
                  child: Text(
                      nav.name,
                      style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 20.0
                      )
                  )
              ),
              Container(
                transform: Matrix4.translationValues(0, -60, 0),
                child: Text(
                    nav.descRow1,
                    style: TextStyle(
                        color: Color(0xFF494949),
                        fontSize: 14.0,
                        letterSpacing: 1.0
                    )
                )
              ),
              Container(
                  transform: Matrix4.translationValues(0, -58, 0),
                child: Text(
                    nav.descRow2,
                    style: TextStyle(
                        color: Color(0xFF494949),
                        fontSize: 14.0,
                        letterSpacing: 1.0
                    )
                )
              )
            ]
        )
    );
  }
}