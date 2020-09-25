import 'package:flutter/material.dart';
import 'package:island/common/bloc/base_bloc.dart';
import 'package:island/common/bloc/main_bloc.dart';
import 'package:island/common/utils/http.dart';
import 'package:island/common/utils/utils.dart';
import 'package:island/modules/api_data.dart';
import 'package:island/widgets/home_main/recommend.dart';
import 'main_nav.dart';

class MainHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  MainBloc bloc;
  Map<String, dynamic> listQuery = {
    "page": 1,
    "size": 10
  };

  @override
  void initState() {
    super.initState();
    loadList();
  }

  // 请求推荐列表
  void loadList() async {
    var res = await Http.get(api: ApiData.getRecommendFeedList, params: listQuery);
    bloc.listSink.add(res);
  }

  // 加载推荐列表
  Widget loadRecommendList(list) {
    List<Widget> recommends = [];
    for (int i=0; i<list.length; i++) {
      recommends.add(Recommend(recommend: list[i]));
    }
    return ListView(
      children: recommends
    );
  }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<MainBloc>(context);
    return Container(
      color: Color(0xFF0e0e0e),
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: <Widget>[
          MainNav(),
          StreamBuilder(
            stream: bloc.listStream,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              return Container(
                  margin: EdgeInsets.only(top: 80.0),
                  child: snapshot.data != null ? loadRecommendList(snapshot.data) : Container()
              );
            }
          )
        ]
      )
    );
  }
}