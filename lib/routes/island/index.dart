import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:island/common/bloc/island/island_bloc.dart';
import 'package:island/common/utils/http.dart';
import 'package:island/common/utils/utils.dart';
import 'package:island/modules/api_data.dart';

import 'nav.dart';

class Island extends StatefulWidget {
  final String id;

  Island({
    Key key,
    @required this.id
  });

  @override
  _IslandState createState() => _IslandState();
}

class _IslandState extends State<Island> {
  IslandBloc bloc = new IslandBloc();

  @override
  void initState() {
    super.initState();
    loadData();
    loadTopicList();
  }

  loadData() async {
    var res = await Http.get(api: ApiData.getIslandById, params: {"islandId": widget.id});
    bloc.sink.add(res);
  }

  loadTopicList() async {
    var res = await Http.get(api: ApiData.getIslandBindingTopicList, params: {"islandId": widget.id});
    bloc.topicSink.add(res);
  }

  List<double> getMatrix() {
    List<double> list = [
      0.5,0,0,0,0,
      0,0.5,0,0,0,
      0,0,0.5,0,0,
      0,0,0,0.7,0
    ];
    return list;
  }

  Widget getTopicList(list) {
    List<Widget> topics = [];
    for (int i=0; i<list.length; i++) {
      topics.add(Container(
        child: Text(
            list[i]["topic"]["name"],
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.0,
              decoration: TextDecoration.none
            )
        )
      ));
    }
    return Wrap(
      children: topics
    );
  }

  @override
  Widget build(BuildContext context) {
    Size allSize = MediaQuery.of(context).size;
    return Container(
      width: allSize.width,
      height: allSize.height,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 50.0,
            child: Nav()
          ),
          StreamBuilder(
            stream: bloc.stream,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                return snapshot.data != null ? Container(
                    width: MediaQuery.of(context).size.width,
                    height: 300.0,
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.matrix(getMatrix()),
                          image: new NetworkImage(snapshot.data["banner"])
                      )
                    ),
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
                          ),
                          StreamBuilder(
                            stream: bloc.topicStream,
                            builder: (BuildContext context, AsyncSnapshot<dynamic> topicSnapshot) {
                              return topicSnapshot.data != null ? getTopicList(topicSnapshot.data) : Container();
                            }
                          )
                        ]
                    )
                ) : Container();
            }
          )
        ]
      )
    );
  }
}

