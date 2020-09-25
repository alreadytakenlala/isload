import 'package:flutter/material.dart';
import 'package:island/common/bloc/application_bloc.dart';
import 'package:island/common/bloc/base_bloc.dart';
import 'package:island/modules/user_data.dart';
import 'package:island/common/utils/utils.dart';

class MeUserInfo extends StatefulWidget {
  final double width;

  MeUserInfo({
    Key key,
    this.width
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MeUserInfo();
}

class _MeUserInfo extends State<MeUserInfo> {
  String defaultAvatar = "https://resource.iiisland.com/default/avatar/default-passport-avatar-3.gif";

  Widget getCountDay(time) {
    List<Widget> list = [];
    String count = DateTime.now().difference(DateTime.parse(time)).inDays.toString();
    for (int i=0; i < count.length; i++) {
      list.add(Container(
          width: 15.0,
          height: 22.0,
          margin: EdgeInsets.only(left: i==0?4.0:3.0, right: i==count.length-1?4.0:0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(1)
          ),
          child: Stack(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: Divider(
                      color: Color(0xFFe0e0e0),
                      height: 1.0,
                      thickness: 1.0,
                      indent: 0.0,
                      endIndent: 0.0,
                    )
                ),
                Container(
                    alignment: Alignment.center,
                    child: Text(count[i], style: TextStyle(
                        color: Color(0xFF0e0e0e),
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold
                    ))
                )
              ]
          )
      ));
    }
    return Row(children: list);
  }

  @override
  Widget build(BuildContext context) {
    ApplicationBloc applicationBloc = BlocProvider.of<ApplicationBloc>(context);
    return StreamBuilder(
        stream: applicationBloc.userInfoStream,
        builder: (BuildContext context, AsyncSnapshot<UserData> snapshot) {
          return Stack(
              children: <Widget>[
                Image.asset(
                    Utils.getImgPath("me_top_bg"),
                    width: widget.width
                ),
                Container(
                    margin: EdgeInsets.only(top: 18.0, left: 25.0),
                    child: Image.network(snapshot.data != null ? snapshot.data.avatar : defaultAvatar,
                        width: 46.0
                    )
                ),
                Container(
                    margin: EdgeInsets.only(top: 20.0, left: 86.0),
                    child: Text(snapshot.data != null ? snapshot.data.nickname : "昵称",
                        style: TextStyle(color:
                        Colors.white,
                            fontSize: 16.0
                        )
                    )
                ),
                Container(
                    margin: EdgeInsets.only(top: 45.0, left: 86.0),
                    child: Row(
                        children: <Widget>[
                          Text("你在「岛」上登陆了", style: TextStyle(
                              color: Color(0xFF4f4f4f),
                              fontSize: 14.0
                          )),
                          getCountDay(snapshot.data != null ? snapshot.data.createTime : DateTime.now().toString()),
                          Text("天", style: TextStyle(
                              color: Color(0xFF4f4f4f),
                              fontSize: 13.0
                          ))
                        ]
                    )
                )
              ]
          );
        }
    );
  }
}