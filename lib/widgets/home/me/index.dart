import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:island/common/bloc/base_bloc.dart';
import 'package:island/common/bloc/home/home_bloc.dart';
import 'package:island/common/bloc/home/me/me_bloc.dart';
import 'package:island/common/utils/http.dart';
import 'package:island/common/utils/utils.dart';
import 'package:island/modules/api_data.dart';
import 'package:island/widgets/home/me/user_info.dart';

import 'category_list.dart';
import 'light.dart';

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
//    List<CategoryData> list = [];
//    for (int i=0; i<res.length; i++) {
//      var category = res[i];
//      List<CategoryItem> innerList = [];
//      for (int j=0; j<category["islands"].length; j++) {
//        var item = category["islands"][j];
//        innerList.add(new CategoryItem(name: item["name"], banner: item["banner"], backgroundColor: Utils.getColorByBase7(item["backgroundColor"][0])));
//      }
//      list.add(new CategoryData(title: category["name"], list: innerList));
//    }
    bloc.categoryListSink.add(res);
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
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    return Positioned(
                        top: allSize.height / 2.8,
                        child: Offstage(
                            offstage: snapshot.data != null,
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              transform: Matrix4.translationValues(1.5, 5.0, 0),
                              child: Container(
                                width: 20.0,
                                height: 20.0,
                                child: Stack(
                                    children: <Widget>[
                                      Positioned(
                                          top: 2.5,
                                          left: 2.5,
                                          child: Light(radius: 15.0, color: Color(0xFFFFF4B4), duration: 3000)
                                      ),
                                      Image.asset(
                                          Utils.getImgPath("login_bottom_light"),
                                          width: 20.0,
                                          height: 20.0
                                      )
                                    ]
                                )
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

class WaterRipple extends StatefulWidget {
  final int count;
  final Color color;

  const WaterRipple({Key key, this.count = 3, this.color = const Color(0xFF0080ff)}) : super(key: key);

  @override
  _WaterRippleState createState() => _WaterRippleState();
}

class _WaterRippleState extends State<WaterRipple>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller =
    AnimationController(vsync: this, duration: Duration(milliseconds: 2000))
      ..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: WaterRipplePainter(_controller.value,count: widget.count,color: widget.color),
        );
      },
    );
  }
}

class WaterRipplePainter extends CustomPainter {
  final double progress;
  final int count;
  final Color color;

  Paint _paint = Paint()..style = PaintingStyle.fill;

  WaterRipplePainter(this.progress,
      {this.count = 3, this.color = const Color(0xFF0080ff)});

  @override
  void paint(Canvas canvas, Size size) {
    double radius = min(size.width / 2, size.height / 2);
    for (int i = count; i >= 0; i--) {
      final double opacity = (1.0 - ((i + progress) / (count + 1)));
      final Color _color = color.withOpacity(opacity);
      _paint..color = _color;

      double _radius = radius * ((i + progress) / (count + 1));

      canvas.drawCircle(
          Offset(size.width / 2, size.height / 2), _radius, _paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}