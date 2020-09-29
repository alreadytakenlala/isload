import 'package:flutter/material.dart';
import 'package:island/common/utils/utils.dart';
import 'package:island/states/triangle.dart';
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

  Widget getMedia({url, width, height, maxWidth=200.0, maxHeight=200.0}) {
    if (url == null) return Container();
    return url.endsWith("mp4") ? Video(url: url, maxWidth: maxWidth, maxHeight: maxHeight) : ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: Container(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Image.network(url, width: width, height: height, fit: BoxFit.cover)
      )
    );
  }

  bool isContainFeedMusicUnit(List<dynamic> list) {
    for (int i=0; i<list.length; i++) {
      if (list[i]["type"] == "FeedMusicUnit") return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    Widget mediaWidget = Container();
    Widget musicWidget = Container();
    Widget urlWidget = Container();
    List<dynamic> mediaList = [];
    List<dynamic> musicList = [];
    List<dynamic> urlList = [];
    List<dynamic> videoList = [];
    if (widget.list == null) return Container();
    for (int i=0; i<widget.list.length; i++) {
      dynamic item = widget.list[i];
      if (item == null) continue;
      else if (item["type"] == "FeedImageUnit" || item["type"] == "FeedVideoUnit") mediaList.add(item);
      else if (item["type"] == "FeedMusicUnit") musicList.add(item);
      else if (item["type"] == "FeedUrlUnit") urlList.add(item);
    }
    // 图片
    if (mediaList.length == 1) {
      mediaWidget = getMedia(url: mediaList[0]["url"], height: 200.0, maxWidth: 250.0);
    } else if (mediaList.length == 2) {
      mediaWidget = Row(
          children: <Widget>[
            getMedia(url: mediaList[0]["url"], width: 120.0, height: 120.0),
            Container(
              margin: EdgeInsets.only(left: 5.0),
              child: getMedia(url: mediaList[1]["url"], width: 120.0, height: 120.0)
            )
          ]
      );
    } else if (mediaList.length == 3) {
      mediaWidget = Row(
        children: <Widget>[
          getMedia(url: mediaList[0]["url"], width: 150.0, height: 200.0),
          Container(
            margin: EdgeInsets.only(left: 5.0),
            child: Column(
                children: <Widget>[
                  getMedia(url: mediaList[1]["url"], width: 95.0, height: 95.0),
                  Container(
                    margin: EdgeInsets.only(top: 5.0),
                    child: getMedia(url: mediaList[2]["url"], width: 95.0, height: 95.0)
                  )
                ]
            )
          )
        ]
      );
    } else if (mediaList.length >= 4) {
      mediaWidget = Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              getMedia(url: mediaList[0]["url"], width: 120.0, height: 120.0),
              Container(
                  margin: EdgeInsets.only(top: 5.0),
                  child: getMedia(url: mediaList[1]["url"], width: 120.0, height: 120.0)
              )
            ]
          ),
          Container(
            margin: EdgeInsets.only(left: 5.0),
            child: Column(
                children: <Widget>[
                  getMedia(url: mediaList[2]["url"], width: 120.0, height: 120.0),
                  Container(
                      margin: EdgeInsets.only(top: 5.0),
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: <Widget>[
                          getMedia(url: mediaList[3]["url"], width: 120.0, height: 120.0),
                          mediaList.length > 4 ? Container(
                            padding: EdgeInsets.only(left: 5.0, top: 1.0, bottom: 1.0, right: 5.0),
                            margin: EdgeInsets.only(right: 2.0, bottom: 2.0),
                            decoration: BoxDecoration(
                              color: Color(0x66000000),
                              borderRadius: BorderRadius.circular(3.0),
                            ),
                            child: Text(
                              (mediaList.length-4).toString()+"+",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.0
                              )
                            )
                          ) : Container()
                        ]
                      )
                  )
                ]
            )
          )
        ]
      );
    }
    // 链接
    if (urlList.length == 1) {
      urlWidget = Container(
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
                        child: getMedia(url: urlList[0]["logo"], width: 36.0)
                    ),
                    Container(
                        width: 200.0,
                        margin: EdgeInsets.only(left: 8.0),
                        child: Text(
                            urlList[0]["title"],
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
    }

    // 音乐
    if (musicList.length == 1) {
      List musicIcon = new List(3);
      musicIcon[0] = Coordinate(cx: 0, cy: 0);
      musicIcon[1] = Coordinate(cx: 16, cy: 8);
      musicIcon[2] = Coordinate(cx: 0, cy: 16);
      musicWidget = Container(
        width: 300.0,
        margin: EdgeInsets.only(top: 15.0),
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
                    Stack(
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.all(5.0),
                            alignment: Alignment.center,
                            child: getMedia(url: musicList[0]["cover"], width: 36.0)
                        ),
                        Positioned(
                          left: 16.0,
                          top: 15.0,
                          child: CustomPaint(
                              painter: Triangle(context,musicIcon,Colors.white)
                          )
                        )
                      ]
                    ),
                    Container(
                        width: 200.0,
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(left: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                                musicList[0]["name"],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.0
                                )
                            ),
                            Text(
                                musicList[0]["artist"],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Color(0xFFA4A4A2),
                                    fontSize: 14.0
                                )
                            )
                          ]
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
        )
      );
    }

    return Container(
        margin: EdgeInsets.only(top: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            mediaWidget,
            urlWidget,
            musicWidget
          ]
        )
    );
  }
}