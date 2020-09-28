import 'package:flutter/material.dart';

class Msg extends StatefulWidget {
  String avatar;
  String nickname;
  String desc;
  Msg({
    Key key,
    @required this.avatar,
    @required this.nickname,
    @required this.desc
  }) : super(key: key);

  @override
  _MsgState createState() => _MsgState();
}

class _MsgState extends State<Msg> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(35.0),
          child: Image.network(
              widget.avatar,
              width: 70.0,
              height: 70.0,
              fit: BoxFit.cover
          )
        ),
        Container(
          width: MediaQuery.of(context).size.width - 120,
          margin: EdgeInsets.only(left: 10.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                    widget.nickname,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0
                    )
                ),
                Container(
                  margin: EdgeInsets.only(top: 2.0),
                  child: Text(
                      widget.desc,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Color(0xFF828282),
                          fontSize: 16.0
                      )
                  )
                )
              ]
          )
        )
      ]
    );
  }
}