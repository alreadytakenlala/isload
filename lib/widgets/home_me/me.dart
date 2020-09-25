import 'package:flutter/material.dart';
import 'package:island/common/bloc/base_bloc.dart';
import 'package:island/common/bloc/home_bloc.dart';
import 'package:island/common/bloc/me_bloc.dart';
import 'package:island/common/bloc/swiper_bloc.dart';
import 'package:island/modules/api_data.dart';
import 'package:island/modules/Category_data.dart';
import 'package:island/common/utils/http.dart';
import 'package:island/common/utils/utils.dart';
import 'dart:math' as math;

import 'me_category_list.dart';
import 'me_user_info.dart';

class Me extends StatefulWidget {
  final SwiperBloc homeSwiperBloc;
  Me({
    Key key,
    @required this.homeSwiperBloc
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MeState();
}

class _MeState extends State<Me> with AutomaticKeepAliveClientMixin {

  MeBloc bloc;
  HomeBloc homeBloc;
  ScrollController listController = new ScrollController();

  @override
  void initState() {
    super.initState();
    loadCategory();
    listenerListView();
  }

  void listenerListView() {
    listController.addListener(() {
      print(listController.offset);
    });
  }

  void loadCategory() async {
    var res = await Http.get(api: ApiData.getCategoryWithIsland);
    List<CategoryData> list = [];
    for (int i=0; i<res.length; i++) {
      var category = res[i];
      List<CategoryItem> innerList = [];
      for (int j=0; j<category["islands"].length; j++) {
        var item = category["islands"][j];
        innerList.add(new CategoryItem(name: item["name"], banner: item["banner"], backgroundColor: Utils.getColorByBase7(item["backgroundColor"][0])));
      }
      list.add(new CategoryData(title: category["name"], list: innerList));
    }
    bloc.categoryListSink.add(list);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    bloc = BlocProvider.of<MeBloc>(context);
    homeBloc = BlocProvider.of<HomeBloc>(context);
    return Material(
        child: Container(
            color: Color(0xFF0e0e0e),
            child: Stack(
                children: <Widget>[
                  Container(
                      alignment: Alignment.topRight,
                      child: Image.asset(
                          Utils.getImgPath("me_bg_a"),
                          width: 110.0
                      )
                  ),
                  Container(
                      alignment: Alignment.topRight,
                      margin: EdgeInsets.only(top: 50.0, right: 20.0),
                      child: Image.asset(
                          Utils.getImgPath("setting_icon"),
                          width: 20.0
                      )
                  ),
                  Container(
                      width: double.infinity,
                      height: double.infinity,
                      alignment: Alignment.center,
                      transform: Matrix4.translationValues(0, 200, 0),
                      child: Image.asset(
                          Utils.getImgPath("login_bottom_icon"),
                          width: 160.0
                      )
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 80.0),
                      child: ListView(
                          controller: listController,
                          children: <Widget>[
                            Stack(
                                children: <Widget>[
                                  Container(
                                      alignment: Alignment.topCenter,
                                      margin: EdgeInsets.only(left: 17.0),
                                      transform: Matrix4.translationValues(0, -20, 0),
                                      child: MeUserInfo(width: 356.0)
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(top: 70.0),
                                      child: Image.asset(
                                          Utils.getImgPath("me_bg_b"),
                                          width: 30.0
                                      )
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(top: 123.0, left: 14.0),
                                      child: MeCategoryList()
                                  )
                                ]
                            )
                          ]
                      )
                  )
                ]
            )
        )
    );
  }

  @override
  bool get wantKeepAlive => true;
}