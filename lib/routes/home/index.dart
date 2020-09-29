import 'package:flutter/material.dart';
import 'package:island/common/bloc/application_bloc.dart';
import 'package:island/common/bloc/base_bloc.dart';
import 'package:island/common/bloc/home/home_bloc.dart';
import 'package:island/common/bloc/home/main/main_bloc.dart';
import 'package:island/common/bloc/home/me/me_bloc.dart';
import 'package:island/common/bloc/swiper_bloc.dart';
import 'package:island/modules/user_data.dart';
import 'package:island/routes/home/start_banner.dart';
import 'package:island/states/swiper.dart';
import 'package:island/states/tabbar.dart';
import 'package:island/widgets/home/main/index.dart';
import 'package:island/widgets/home/main/nav.dart';
import 'package:island/widgets/home/mark/index.dart';
import 'package:island/widgets/home/me/index.dart';
import 'package:island/widgets/home/message/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'entrance.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  HomeBloc bloc = new HomeBloc();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    bool alreadyShowBanner = storage.getBool("ALREADY_SHOW_BANNER");
    bloc.bannerJumpSink.add(alreadyShowBanner);
  }

  @override
  Widget build(BuildContext context) {
    SwiperBloc swiperBloc = new SwiperBloc();
    ApplicationBloc applicationBloc = BlocProvider.of<ApplicationBloc>(context);
    applicationBloc.tabberStream.listen((data) {
      swiperBloc.toSink.add(data);
    });
    applicationBloc.mainNavStream.listen((data) {
      swiperBloc.toSink.add(data);
    });
    return Material(
      child: StreamBuilder(
        stream: bloc.bannerJumpStream,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          return StreamBuilder(
              stream: applicationBloc.userInfoStream,
              builder: (BuildContext context, AsyncSnapshot<UserData> userSnapshot) {
                return BlocProvider(
                  bloc: bloc,
                  child: Stack(
                      children: <Widget>[
                        Offstage(
                            offstage: userSnapshot.data != null,
                            child: Entrance()
                        ),
                        Offstage(
                            offstage: snapshot.data != null ? snapshot.data : true,
                            child: StartBanner()
                        ),
                        Offstage(
                            offstage: (snapshot.data != null && userSnapshot.data != null) ? !snapshot.data : true,
                            child: BlocProvider(
                                bloc: MeBloc(),
                                child: BlocProvider(
                                    bloc: MainBloc(),
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
                                                    else if (index == 1) return Main();
                                                    else if (index == 2) return Mark();
                                                    else return Message();
                                                  }
                                              ),
                                              StreamBuilder(
                                                  stream: swiperBloc.indexStream,
                                                  builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
                                                    double index = snapshot.data;
                                                    return Offstage(
                                                        offstage: !(index != null && index >= 1 && index <= 2),
                                                        child: Nav()
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
                            offstage: (snapshot.data != null && userSnapshot.data != null) ? !snapshot.data : true,
                            child: Tabbar(swiperBloc: swiperBloc)
                        )
                      ]
                  )
                );
              }
          );
        }
      )
    );
  }
}