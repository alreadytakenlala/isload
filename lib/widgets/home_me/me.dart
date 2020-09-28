import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:island/common/bloc/base_bloc.dart';
import 'package:island/common/bloc/home_bloc.dart';
import 'package:island/common/bloc/me_bloc.dart';
import 'package:island/modules/api_data.dart';
import 'package:island/modules/Category_data.dart';
import 'package:island/common/utils/http.dart';
import 'package:island/common/utils/utils.dart';

import 'me_category_list.dart';
import 'me_user_info.dart';

class Me extends StatefulWidget {
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
    Size allSize = MediaQuery.of(context).size;
    super.build(context);
    bloc = BlocProvider.of<MeBloc>(context);
    homeBloc = BlocProvider.of<HomeBloc>(context);
    return Container(
          color: Color(0xFF0e0e0e),
          child: Stack(
              children: <Widget>[
                Positioned(
                  right: 0,
                    child: Image.asset(
                        Utils.getImgPath("me_bg_a"),
                        width: 110.0
                    )
                ),
                Positioned(
                    right: 20.0,
                    top: 50.0,
                    child: Image.asset(
                        Utils.getImgPath("setting_icon"),
                        width: 20.0
                    )
                ),
                Positioned(
                    top: 190.0,
                    child: Image.asset(
                        Utils.getImgPath("me_bg_b"),
                        width: 30.0
                    )
                ),
                StreamBuilder(
                  stream: bloc.categoryListStream,
                  builder: (BuildContext context, AsyncSnapshot<List<CategoryData>> snapshot) {
                    return Offstage(
                      offstage: snapshot.data != null,
                      child: Positioned(
                          top: allSize.height / 2.8,
                          child: Container(
                              width: allSize.width,
                              alignment: Alignment.center,
                              child: Column(
                                  children: <Widget>[
                                    Text("这里的每一座「岛」都代表了年轻人的“元”", style: TextStyle(
                                        color: Color(0xFF5E5E5E),
                                        fontSize: 14.0
                                    )),
                                    Text("多元共生 和而不同", style: TextStyle(
                                        color: Color(0xFF5E5E5E),
                                        fontSize: 14.0
                                    ))
                                  ]
                              )
                          )
                      )
                    );
                  }
                ),
                Positioned(
                    bottom: allSize.height / 8,
                    child: Container(
                      width: allSize.width,
                      alignment: Alignment.center,
                      child: Column(
                          children: <Widget>[
                            Container(
                              transform: Matrix4.translationValues(0, 5.0, 0),
                              child: Image.asset(
                                  Utils.getImgPath("login_bottom_light"),
                                  width: 20.0
                              )
                            ),
                            Image.asset(
                                Utils.getImgPath("login_bottom_icon"),
                                width: 200.0
                            )
                          ]
                      )
                    )
                ),
                Container(
                    margin: EdgeInsets.only(top: 60.0),
                    child: ListView(
                        controller: listController,
                        children: <Widget>[
                          Stack(
                              children: <Widget>[
                                Positioned(
                                    left: 17.0,
                                    child: MeUserInfo(width: 356.0)
                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 145.0, left: 14.0),
                                    child: MeCategoryList()
                                )
                              ]
                          )
                        ]
                    )
                )
              ]
          )
      );
  }

  @override
  bool get wantKeepAlive => true;
}