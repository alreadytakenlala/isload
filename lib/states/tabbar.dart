import 'package:flutter/material.dart';
import 'package:island/common/bloc/application_bloc.dart';
import 'package:island/common/bloc/base_bloc.dart';
import 'package:island/common/bloc/swiper_bloc.dart';
import 'package:island/common/utils/utils.dart';

class Tabbar extends StatefulWidget {
  SwiperBloc swiperBloc;

  Tabbar({
    Key key,
    @required this.swiperBloc
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TabbarState();
}

class _TabbarState extends State<Tabbar> with SingleTickerProviderStateMixin {
  AnimationController animiationController;
  Animation animation;

  @override
  void initState() {
    super.initState();
    animiationController = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(animiationController);
  }

  // 是否在main页面上
  bool isInMain(int page) {
    return page == 1 || page == 2;
  }

  // 监听回到MainHome页面，执行动画
  void listenMainHome(data) {
    if (isInMain(data)) {
      animiationController.forward();
    } else {
      animiationController.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    ApplicationBloc applicationBloc = BlocProvider.of<ApplicationBloc>(context);
    widget.swiperBloc.stream.listen(listenMainHome);
    return Container(
        alignment: Alignment.bottomCenter,
        transform: Matrix4.translationValues(0, 4, 0),
        child: Container(
            height: 80.0,
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.transparent, Color(0xFF0e0e0e)]
                )
            ),
            child: StreamBuilder(
                stream: widget.swiperBloc.stream,
                builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                  return AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      padding: EdgeInsets.only(left: isInMain(snapshot.data) ? 20.0 : 50.0, right: isInMain(snapshot.data) ? 20.0 : 50.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            FlatButton(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                child: Image.asset(Utils.getImgPath("main_me"),
                                    width: 26.0
                                ),
                                onPressed: () {
                                  applicationBloc.tabberSink.add(0);
                                }
                            ),
                            FlatButton(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                child: Row(
                                    children: <Widget>[
                                      Offstage(
                                          offstage: isInMain(snapshot.data),
                                          child: Image.asset(Utils.getImgPath("main_main"),
                                              width: 26.0
                                          )
                                      ),
                                      Offstage(
                                          offstage: !isInMain(snapshot.data),
                                          child: AnimatedContainer(
                                              duration: Duration(milliseconds: 500),
                                              width: isInMain(snapshot.data) ? 50.0 : 20.0,
                                              height: isInMain(snapshot.data) ? 50.0 : 20.0,
                                              child: RotationTransition(
                                                  alignment: Alignment.center,
                                                  turns: animation,
                                                  child: Container(
                                                      alignment: Alignment.center,
                                                      decoration: BoxDecoration(
                                                          color: Color(0xFF0e0e0e),
                                                          borderRadius: BorderRadius.circular(25.0)
                                                      ),
                                                      child: Stack(
                                                        alignment: Alignment.center,
                                                        children: <Widget>[
                                                          Container(
                                                            width: 3.0,
                                                            height: isInMain(snapshot.data) ? 16.0 : 6.0,
                                                            color: Colors.white
                                                          ),
                                                          Container(
                                                            width: isInMain(snapshot.data) ? 16.0 : 6.0,
                                                            height: 3.0,
                                                            color: Colors.white
                                                          )
                                                        ]
                                                      )
                                                  )
                                              )
                                          )
                                      )
                                    ]
                                ),
                                onPressed: () {
                                  applicationBloc.tabberSink.add(1);
                                }
                            ),
                            FlatButton(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                child: Image.asset(Utils.getImgPath("main_conversation"),
                                    width: 26.0
                                ),
                                onPressed: () {
                                  applicationBloc.tabberSink.add(2);
                                }
                            )
                          ]
                      )
                  );
                }
            )
        )
    );
  }

  @override
  void dispose() {
    super.dispose();
    animiationController.dispose();
  }
}