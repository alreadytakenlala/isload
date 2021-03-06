import 'package:flutter/material.dart';
import 'package:island/common/bloc/base_bloc.dart';
import 'package:island/common/bloc/home/main/main_bloc.dart';
import 'package:island/common/bloc/swiper_bloc.dart';
import 'package:island/common/utils/http.dart';
import 'package:island/modules/api_data.dart';
import 'file:///D:/project-study/mobility/island/lib/states/recommend.dart';

import 'nav.dart';

class Main extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainState();
}

class _MainState extends State<Main> with AutomaticKeepAliveClientMixin {
  MainBloc bloc;
  SwiperBloc homeSwiperBolc;

  Map<String, int> listQuery = {
    "page": 1,
    "size": 10
  };
  List<dynamic> list = [];
  ScrollController listViewController = new ScrollController();

  @override
  void initState() {
    super.initState();
    loadList();
    listViewController.addListener(() {
      if (listViewController.position.pixels == listViewController.position.maxScrollExtent) {
        listQuery["page"]++;
        loadList();
      }
    });
  }

  // 请求推荐列表
  void loadList() async {
    var res = await Http.get(api: ApiData.getRecommendFeedList, params: listQuery);
    listQuery["page"] == 1 ? list = res : list.addAll(res);
    bloc.listSink.add(list);
  }

  // 加载推荐列表
  Widget loadRecommendList(list) {
    List<Widget> recommends = [];
    for (int i=0; i<list.length; i++) {
      recommends.add(Recommend(recommend: list[i]));
    }
    return ListView(
      controller: listViewController,
      cacheExtent: double.infinity,
      children: recommends
    );
  }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<MainBloc>(context);
    homeSwiperBolc = BlocProvider.of<SwiperBloc>(context);
    SwiperBloc swiperBloc = new SwiperBloc();
    return Container(
      color: Color(0xFF0e0e0e),
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: <Widget>[
          StreamBuilder(
            stream: homeSwiperBolc.indexStream,
            builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
              double index = snapshot.data;
              return (index != null && index < 1) ? Nav() : Container();
            }
          ),
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

  @override
  bool get wantKeepAlive => true;
}