import 'dart:async';
import 'package:flutter/services.dart';
import 'package:island/common/bloc/base_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeBloc extends BaseBloc {

  // 首页banner跳过事件监听
  BehaviorSubject<bool> bannerJumpSubject = BehaviorSubject<bool>();
  StreamSink<bool> get bannerJumpSink => bannerJumpSubject.sink;
  Stream<bool> get bannerJumpStream => bannerJumpSubject.stream;

  HomeBloc() {
    bannerJumpStream.listen(recordBannerJump);
  }

  void recordBannerJump(bool data) async {
    SystemChrome.setEnabledSystemUIOverlays(data == true ? [SystemUiOverlay.top, SystemUiOverlay.bottom] : []);
    if (data == true) {
      SharedPreferences storage = await SharedPreferences.getInstance();
      storage.setBool("ALREADY_SHOW_BANNER", data);
    }
  }

  @override
  void dispose() {
    bannerJumpSubject.close();
  }
}