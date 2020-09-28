import 'package:flutter/material.dart';
import 'package:island/common/bloc/message_bloc.dart';
import 'package:island/common/utils/http.dart';
import 'package:island/modules/api_data.dart';
import 'package:island/widgets/home_message/msg.dart';

import 'menus.dart';

class Message extends StatefulWidget {
  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> with AutomaticKeepAliveClientMixin {
  MessageBloc bloc = new MessageBloc();
  Map<String, int> listQuery = {
    "page": 1,
    "size": 10
  };
  List<dynamic> list = [];

  @override
  void initState() {
    super.initState();
    loadList();
  }

  loadList() async {
    var res = await Http.get(api: ApiData.getMessageList, params: listQuery);
    listQuery["page"] == 1 ? list = res : list.addAll(res);
    bloc.sink.add(list);
  }
  ///  获取消息列表
  Widget getMsgList(list) {
    List<Widget> msgList = [];
    for (int i=0; i<list.length; i++) {
      msgList.add(Container(
        margin: EdgeInsets.only(top: i!=0?20.0:0),
        child: Msg(avatar: list[i]["avatar"], nickname: list[i]["nickname"], desc: list[i]["desc"])
      ));
    }
    return Container(
      padding: EdgeInsets.only(left: 20.0, right: 10.0),
      child: Column(
          children: msgList
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF0e0e0e),
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 20.0,
            top: 30.0,
            child: Text("消息", style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold
            ))
          ),
          Container(
            margin: EdgeInsets.only(top: 60.0),
            child: StreamBuilder(
                stream: bloc.stream,
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  return snapshot.data != null ? ListView(
                    children: <Widget>[
                      Menus(),
                      Container(
                        margin: EdgeInsets.only(top: 30.0),
                        child: getMsgList(snapshot.data)
                      )
                    ]
                  ) : Menus();
                }
            )
          )
        ]
      )
    );
  }

  @override
  bool get wantKeepAlive => true;
}