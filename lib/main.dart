import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:island/common/utils/http.dart';
import 'package:island/routes/home/index.dart';
import 'package:island/routes/island/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:island/common/bloc/application_bloc.dart';
import 'package:island/common/bloc/base_bloc.dart';
import 'package:island/common/global.dart';
import 'package:island/modules/api_data.dart';
import 'package:island/modules/user_data.dart';

ApplicationBloc applicationBloc = new ApplicationBloc();

void main() {
  Global.init(() {
    runApp(BlocProvider(
        bloc: applicationBloc,
        child: Application())
    );
    loadUserInfo();
  });
}

void loadUserInfo() async {
  SharedPreferences storage = await SharedPreferences.getInstance();
  String userInfo = storage.getString("userInfo");
  UserData userData;
  if (userInfo != null) {
    var data = json.decode(userInfo);
    userData = new UserData(nickname: data["nickname"], avatar: data["avatar"], createTime: data["createTime"]);
    storage.setString("userInfo", json.encode(userData));
  } else {
    var res = await Http.post(api: ApiData.getUserInfo);
    userData = new UserData(nickname: res["username"], avatar: res["defaultAvatar"], createTime: res["createTime"]);
  }
  applicationBloc.userInfoSink.add(userData);
}

class Application extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "岛",
      theme: new ThemeData(
        primaryColor: Colors.white
      ),
      debugShowCheckedModeBanner: false,
      home: new Island(id: "5d0772d433e8bb34bf2a9ece"),
//      home: new Home(),
      onGenerateRoute: (RouteSettings settings) {
        var routes = <String, WidgetBuilder>{
          "island_page": (context) => new Island(id: settings.arguments),
          "/": (context) => new Home()
        };
        WidgetBuilder builder = routes[settings.name];
        return MaterialPageRoute(builder: (ctx) => builder(ctx));
      }
    );
  }
}
