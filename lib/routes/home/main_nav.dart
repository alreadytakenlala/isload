import 'package:flutter/material.dart';
import 'package:island/common/bloc/base_bloc.dart';
import 'package:island/common/bloc/swiper_bloc.dart';
import 'package:island/common/utils/utils.dart';

class MainNav extends StatefulWidget {
  final int index;
  MainNav({Key key, this.index}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _MainNavState();
}

class _MainNavState extends State<MainNav> {

  SwiperBloc homeSwiperBolc;

  Widget genderMenu(String name, bool isActive) {
    return Text(name,
        style: TextStyle(
            color: isActive ? Colors.white : Color(0xFF8f8f8f),
            fontSize: isActive ? 24.0 : 16.0,
            fontWeight: FontWeight.bold
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    homeSwiperBolc = BlocProvider.of<SwiperBloc>(context);
    return Stack(
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(left: 20.0, top: 30.0),
              child: StreamBuilder(
                stream: homeSwiperBolc.indexStream,
                builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
                  double index = snapshot.data;
                  return Row(
                      children: <Widget>[
                        Container(
                            width: 50.0,
                            height: 40.0,
                            alignment: Alignment.bottomCenter,
                            child: index != null ? genderMenu("环游", index >= 0 && index < 1.5) : Container()
                        ),
                        Container(
                            width: 50.0,
                            height: 40.0,
                            alignment: Alignment.bottomCenter,
                            margin: EdgeInsets.only(left: 7.0),
                            child: index != null ? genderMenu("标记", index >= 1.5 && index <= 3) : Container()
                        )
                      ]
                  );
                }
              )
          ),
          Container(
              alignment: Alignment.topRight,
              margin: EdgeInsets.only(top: 50.0, right: 68.0),
              child: Image.asset(Utils.getImgPath("maindrift_normal"),
                width: 22.0,
              )
          ),
          Container(
              alignment: Alignment.topRight,
              margin: EdgeInsets.only(top: 50.0, right: 20.0),
              child: Image.asset(Utils.getImgPath("main_randomplay"),
                  width: 22.0
              )
          )
        ]
    );
  }
}