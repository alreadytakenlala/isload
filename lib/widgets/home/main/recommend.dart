import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:island/common/utils/utils.dart';
import 'package:island/widgets/home/main/unit_item.dart';

class Recommend extends StatelessWidget {
  dynamic recommend;
  Recommend({
    Key key,
    this.recommend
  }) : super(key: key);

  // 是否单个相片
  bool isSingImg(item) {
    return false;
  }

  // 加载话题列表
  Widget _loadTopics() {
    List<Widget> topics = [];
    if (recommend["topics"] != null && recommend["topics"].length > 0) {
      var item = recommend["topics"][0];
      topics.add(Container(
          margin: EdgeInsets.only(top: 10.0),
          padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 8.0, right: 10.0),
          decoration: BoxDecoration(
            color: Color(0xFF00b8fe),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
                bottomLeft: Radius.circular(5.0),
                bottomRight: Radius.circular(20.0)
            )
          ),
          child: Row(
              children: <Widget>[
                Image.asset(Utils.getImgPath("ic_topic"),
                    width: 20.0
                ),
                Container(
                  margin: EdgeInsets.only(left: 5.0),
                  child: Text(item["name"],
                    style: TextStyle(
                        color: Color(0xFF15282f),
                        letterSpacing: -1.0,
                        fontWeight: FontWeight.bold
                    )
                  )
                )
              ]
          )
      ));
    }
    return Row(children: topics);
  }

  List<double> getMatrix() {
    List<double> list = [
      0.5,0,0,0,0,
      0,0.5,0,0,0,
      0,0,0.5,0,0,
      0,0,0,0.5,0
    ];
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: new BoxDecoration(
              image: new DecorationImage(
                fit: BoxFit.cover,
                colorFilter: ColorFilter.matrix(getMatrix()),
                image: new NetworkImage(
                    recommend["background"]["url"]
                )
              )
          ),
          child: Stack(
            children: <Widget>[
              Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        width: 60.0,
                        alignment: Alignment.topCenter,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image.network(recommend["passport"]["avatar"],
                                width: 30.0
                            )
                        )
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              child: Text(recommend["passport"]["nickname"],
                                  style: TextStyle(
                                    color: Color(0xFF68676C999999),
                                    fontSize: 16.0,
                                  )
                              )
                          ),
                          _loadTopics(),
                          Container(
                              margin: EdgeInsets.only(top: 10.0),
                              width: 300.0,
                              child: Text(recommend["text"]["content"],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0
                                  )
                              )
                          ),
                          UnitItem(list: recommend["units"]),
                          Container(
                            width: 300.0,
                            padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                            child: Stack(
                              children: <Widget>[
                                Row(
                                    children: <Widget>[
                                      Image.asset(
                                        Utils.getImgPath("item_feedadapter_talk"),
                                        width: 16.0,
                                      ),
                                      Container(
                                          margin: EdgeInsets.only(left: 5.0),
                                          child: Text(recommend["commentCount"]>0?recommend["commentCount"].toString():'', style: TextStyle(
                                              color: Color(0xFF616161)
                                          ))
                                      )
                                    ]
                                ),
                                Positioned(
                                    right: 0,
                                    child: Image.asset(
                                        Utils.getImgPath("love_normal"),
                                        width: 18.0
                                    )
                                )
                              ]
                            )
                          )
                        ]
                    )
                  ]
              ),
              Positioned(
                top: 5.0,
                right: 5.0,
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0x20EEEEEE),
                      borderRadius: BorderRadius.circular(3.0)
                  ),
                  padding: EdgeInsets.only(left: 5.0, right: 5.0),
                  child: Row(
                      children: <Widget>[
                        Container(
                            alignment: Alignment.center,
                            height: 24.0,
                            transform: Matrix4.translationValues(0, 1, 0),
                            child: Container(
                                width: 8.0,
                                height: 8.0,
                                margin: EdgeInsets.only(right: 3.0),
                                decoration: BoxDecoration(
                                    color: Color(Utils.getColorByBase7(recommend["island"]["backgroundColor"][0] is int ? recommend["island"]["backgroundColor"][0] : 4207660)),
                                    borderRadius: BorderRadius.circular(2.0)
                                )
                            )
                        ),
                        Container(
                            alignment: Alignment.center,
                            height: 24.0,
                            transform: Matrix4.translationValues(0, -0.5, 0),
                            child: Text(
                                recommend["island"]["name"],
                                style: TextStyle(
                                    color: Color(0xFFA1A1A1),
                                    fontSize: 12.0
                                )
                            )
                        )
                      ]
                  ),
                )
              )
            ]
          )
        )
      ]
    );
  }
}