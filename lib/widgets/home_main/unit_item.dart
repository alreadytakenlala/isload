import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:island/common/utils/utils.dart';
import 'package:island/states/video.dart';

class UnitItem extends StatefulWidget {
  final List<dynamic> list;
  UnitItem({
    Key key,
    this.list
  }) : super(key: key);
  @override
  _UnitItemState createState() => _UnitItemState();
}

class _UnitItemState extends State<UnitItem> {

  Widget getMedia({url, width, height, maxWidth=double.infinity, maxHeight=double.infinity}) {
    return url.endsWith("mp4") ? Video(url: url) : ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: Container(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Image.network(url, width: width, height: height, fit: BoxFit.cover)
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget innerWidget;
    List<dynamic> list = [];
    if (widget.list == null) return Container();
    for (int i=0; i<widget.list.length; i++) {
      if (widget.list[i] != null) list.add(widget.list[i]);
    }
    if (list.length == 0) return Container();
    else if (list.length == 1 && list[0]["type"] == "FeedUrlUnit") {
      innerWidget = Container(
        width: 300.0,
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xFF262626),
            width: 1.0,
            style: BorderStyle.solid
          )
        ),
        child: Stack(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(5.0),
                  alignment: Alignment.center,
                  child: getMedia(url: list[0]["logo"], width: 36.0)
                ),
                Container(
                  width: 200.0,
                  margin: EdgeInsets.only(left: 8.0),
                  child: Text(
                    list[0]["title"],
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0
                    )
                  )
                )
              ]
            ),
            Positioned(
              right: 0,
              child: Image.asset(
                  Utils.getImgPath("img_url_right"),
                  width: 50.0
              )
            )
          ]
        ),
      );
    } else if (list.length == 1) {
      innerWidget = getMedia(url: list[0]["url"], height: 200.0, maxWidth: 250.0);
    } else if (list.length == 2) {
      innerWidget = Row(
          children: <Widget>[
            getMedia(url: list[0]["url"], width: 120.0, height: 120.0),
            Container(
              margin: EdgeInsets.only(left: 5.0),
              child: getMedia(url: list[1]["url"], width: 120.0, height: 120.0)
            )
          ]
      );
    } else if (list.length == 3) {
      innerWidget = Row(
        children: <Widget>[
          getMedia(url: list[0]["url"], width: 150.0, height: 200.0),
          Container(
            margin: EdgeInsets.only(left: 5.0),
            child: Column(
                children: <Widget>[
                  getMedia(url: list[1]["url"], width: 95.0, height: 95.0),
                  Container(
                    margin: EdgeInsets.only(top: 5.0),
                    child: getMedia(url: list[2]["url"], width: 95.0, height: 95.0)
                  )
                ]
            )
          )
        ]
      );
    } else if (list.length >= 4) {
      innerWidget = Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              getMedia(url: list[0]["url"], width: 120.0, height: 120.0),
              Container(
                  margin: EdgeInsets.only(top: 5.0),
                  child: getMedia(url: list[1]["url"], width: 120.0, height: 120.0)
              )
            ]
          ),
          Container(
            margin: EdgeInsets.only(left: 5.0),
            child: Column(
                children: <Widget>[
                  getMedia(url: list[2]["url"], width: 120.0, height: 120.0),
                  Container(
                      margin: EdgeInsets.only(top: 5.0),
                      child: getMedia(url: list[3]["url"], width: 120.0, height: 120.0)
                  )
                ]
            )
          )
        ]
      );
    } else {
      return Container();
    }
    return Container(
        margin: EdgeInsets.only(top: 10.0),
        child: innerWidget
    );
  }
}