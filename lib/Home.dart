import 'package:flutter/material.dart';
import 'package:island/pages/Mark.dart';
import 'package:island/pages/travelAround.dart';
import 'package:island/utils/utils.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  static var imgs = [
    Utils.getImgPath("updateguide1"),
    Utils.getImgPath("updateguide2"),
    Utils.getImgPath("updateguide3"),
    Utils.getImgPath("updateguide4"),
    Utils.getImgPath("updateguide5"),
    Utils.getImgPath("updateguide6")
  ];
  double _index = 0;

  PageController controller = new PageController(
    initialPage: 0,
    keepPage: true,
    viewportFraction: 1.0
  );
  
  @override
  void initState() {
    controller.addListener(() {
      _index = controller.page;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      child: Stack(
        children: <Widget>[
          PageView.builder(
            itemCount: imgs.length,
            controller: controller,
            itemBuilder: (context, index) {
              return Container(
                color: Color(0xFF000000),
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                        imgs[index],
                        width: 200.0
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10.0),
                      child: Text(
                          "Independence",
                          style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              height: 3.0,
                              fontSize: 14.0
                          )
                      )
                    ),
                    Container(
                        margin: EdgeInsets.only(bottom: 15.0),
                        child: Text(
                            "(独立",
                            style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 20.0
                            )
                        )
                    ),
                    Text(
                        "每一个人都是",
                        style: TextStyle(
                            color: Color(0xFF494949),
                            fontSize: 14.0,
                            letterSpacing: 2.0
                        )
                    ),
                    Text(
                        "自由独立的个体",
                        style: TextStyle(
                            color: Color(0xFF494949),
                            fontSize: 14.0,
                            letterSpacing: 2.0
                        )
                    )
                  ]
                )
              );
            }
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            margin: EdgeInsets.only(top: 450.0),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      child: ClipOval(
                          child: Container(
                              width: 6.0,
                              height: 6.0,
                              color: _index >= 0 && _index < 0.5 ? Color(0xFFFFFFFF) : Color(0xFF686868)
                          )
                      )
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 8.0),
                      child: ClipOval(
                          child: Container(
                              width: 6.0,
                              height: 6.0,
                              color: _index >= 0.5 && _index < 1.5 ? Color(0xFFFFFFFF) : Color(0xFF686868)
                          )
                      )
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 8.0),
                      child: ClipOval(
                          child: Container(
                              width: 6.0,
                              height: 6.0,
                              color: _index >= 1.5 && _index < 2.5 ? Color(0xFFFFFFFF) : Color(0xFF686868)
                          )
                      )
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 8.0),
                      child: ClipOval(
                          child: Container(
                              width: 6.0,
                              height: 6.0,
                              color: _index >= 2.5 && _index < 3.5 ? Color(0xFFFFFFFF) : Color(0xFF686868)
                          )
                      )
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 8.0),
                      child: ClipOval(
                          child: Container(
                              width: 6.0,
                              height: 6.0,
                              color: _index >= 3.5 && _index < 4.5 ? Color(0xFFFFFFFF) : Color(0xFF686868)
                          )
                      )
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 8.0),
                    child: ClipOval(
                        child: Container(
                            width: 6.0,
                            height: 6.0,
                            color: _index >= 4.5 && _index <= 5 ? Color(0xFFFFFFFF) : Color(0xFF686868)
                        )
                    )
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