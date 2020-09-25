import 'package:flutter/material.dart';
import 'package:island/common/bloc/base_bloc.dart';
import 'package:island/common/bloc/home_bloc.dart';
import 'package:island/common/bloc/swiper_bloc.dart';
import 'package:island/modules/nav_data.dart';
import 'package:island/common/utils/utils.dart';
import 'package:island/states/swiper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'nav_banner.dart';

class HomeBanner extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  HomeBloc homeBloc;
  static List<NavData> navs = [
    new NavData(
        label: "Independence",
        name: "（独立",
        descRow1: "每一个人都是",
        descRow2: "自由独立的个体",
        imgUrl: Utils.getImgPath("updateguide1")
    ),
    new NavData(
        label: "Sincerity",
        name: "（真诚",
        descRow1: "我的鼓励真诚的",
        descRow2: "记录、分享和交流",
        imgUrl: Utils.getImgPath("updateguide2")
    ),
    new NavData(
        label: "Love",
        name: "（热爱",
        descRow1: '为所爱的"关键字"发声',
        descRow2: "表达你的态度",
        imgUrl: Utils.getImgPath("updateguide3")
    ),
    new NavData(
        label: "Affect",
        name: "（影响",
        descRow1: "『岛』相信",
        descRow2: "年轻人对世界的影响",
        imgUrl: Utils.getImgPath("updateguide4")
    ),
    new NavData(
        label: "Neverland",
        name: "（永无岛",
        descRow1: "致力于和大家共创",
        descRow2: "一个青年文化的乌托邦",
        imgUrl: Utils.getImgPath("updateguide5")
    ),
    new NavData(
        label: "Difference",
        name: "（不同",
        descRow1: "因不同，而多元",
        descRow2: "因多元，而精彩",
        imgUrl: Utils.getImgPath("updateguide6")
    )
  ];

  @override
  void initState() {
    super.initState();
//    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  // 设置隐藏栏
  void setEnabledSystemUIOverlays() async {
    SharedPreferences storage = await SharedPreferences.getInstance();

  }

  @override
  Widget build(BuildContext context) {
    HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);
    SwiperBloc swiperBloc = new SwiperBloc();
    return Material(
        child: Stack(
            children: <Widget>[
              Offstage(
                  offstage: false,
                  child: Swiper(
                      itemCount: navs.length,
                      bloc: swiperBloc,
                      itemBuilder: (context, index) {
                        return NavBanner(nav: navs[index]);
                      }
                  )
              ),
              StreamBuilder(
                stream: swiperBloc.stream,
                builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                  return Offstage(
                      offstage: snapshot.data != null ? snapshot.data == 5 : false,
                      child: Align(
                          alignment: Alignment.topRight,
                          child: Container(
                              width: 60.0,
                              height: 30.0,
                              margin: EdgeInsets.only(top: 30.0, right: 30.0),
                              child: FloatingActionButton.extended(
                                  label: Text("跳过", style: TextStyle(color: Color(0xFF0e0e0e))),
                                  backgroundColor: Color(0xFF686868),
                                  onPressed: () {
                                    homeBloc.bannerJumpSink.add(true);
                                  }
                              )
                          )
                      )
                  );
                }
              ),
              StreamBuilder(
                stream: swiperBloc.stream,
                builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                  return Offstage(
                      offstage: snapshot.data != null ? snapshot.data < 5 : true,
                      child: Align(
                          alignment: Alignment.center,
                          child: Container(
                              width: 90,
                              height: 45,
                              transform: Matrix4.translationValues(0, 237, 0),
                              child: FloatingActionButton.extended(
                                  label: Text("开始", style: TextStyle(
                                      color: Color(0xFF0e0e0e),
                                      fontSize: 18.0
                                  )),
                                  backgroundColor: Color(0xFFFFFFFF),
                                  onPressed: () {
                                    homeBloc.bannerJumpSink.add(true);
                                  }
                              )
                          )
                      )
                  );
                }
              )
            ]
        )
    );
  }
}