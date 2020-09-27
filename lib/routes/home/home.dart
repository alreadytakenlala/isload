import 'package:flutter/material.dart';
import 'package:island/common/bloc/base_bloc.dart';
import 'package:island/common/bloc/home_bloc.dart';
import 'package:island/common/bloc/main_bloc.dart';
import 'package:island/common/bloc/me_bloc.dart';
import 'package:island/common/bloc/swiper_bloc.dart';
import 'package:island/states/swiper.dart';
import 'package:island/states/tabbar.dart';
import 'package:island/widgets/home_main/main_home.dart';
import 'package:island/widgets/home_mark/mark_home.dart';
import 'package:island/widgets/home_me/me.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_banner.dart';
import 'main_nav.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {

  void initBuild(HomeBloc homeBloc) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    bool alreadyShowBanner = storage.getBool("ALREADY_SHOW_BANNER");
    homeBloc.bannerJumpSink.add(alreadyShowBanner);
  }

  @override
  Widget build(BuildContext context) {
    HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);
    initBuild(homeBloc);
    SwiperBloc swiperBloc = new SwiperBloc();
    return Material(
      child: StreamBuilder(
        stream: homeBloc.bannerJumpStream,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          return Stack(
              children: <Widget>[
                Offstage(
                  offstage: snapshot.data != null ? snapshot.data : false,
                  child: HomeBanner()
                ),
                Offstage(
                    offstage: snapshot.data != null ? !snapshot.data : true,
                    child: BlocProvider(
                        bloc: new MeBloc(),
                        child: BlocProvider(
                          bloc: new MainBloc(),
                          child: BlocProvider(
                            bloc: swiperBloc,
                            child: Stack(
                                children: <Widget>[
                                  Swiper(
                                      itemCount: 4,
                                      indicatorDots: false,
                                      bloc: swiperBloc,
                                      itemBuilder: (context, index) {
                                        if (index == 0) return Me();
                                        else if (index == 1) return MainHome();
                                        else if (index == 2) return Mark();
                                        else return Me();
                                      }
                                  ),
                                  StreamBuilder(
                                      stream: swiperBloc.indexStream,
                                      builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
                                        double index = snapshot.data;
                                        return Offstage(
                                            offstage: !(index != null && index >= 1 && index <= 2),
                                            child: MainNav()
                                        );
                                      }
                                  )
                                ]
                            )
                          )
                        )
                    )
                ),
                Offstage(
                  offstage: snapshot.data != null ? !snapshot.data : true,
                  child: Tabbar(swiperBloc: swiperBloc)
                )
              ]
          );
        }
      )
    );
  }
}