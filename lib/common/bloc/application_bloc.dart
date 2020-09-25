import 'dart:async';
import 'package:island/common/bloc/base_bloc.dart';
import 'package:island/modules/user_data.dart';
import 'package:rxdart/rxdart.dart';

class ApplicationBloc extends BaseBloc {

  // 用户信息流
  BehaviorSubject<UserData> userInfoSubject = BehaviorSubject<UserData>();
  StreamSink<UserData> get userInfoSink => userInfoSubject.sink;
  Stream<UserData> get userInfoStream => userInfoSubject.stream;

  // tabber按钮
  BehaviorSubject<int> tabberSubject = BehaviorSubject<int>();
  StreamSink<int> get tabberSink => tabberSubject.sink;
  Stream<int> get tabberStream => tabberSubject.stream;

  @override
  void dispose() {
    userInfoSubject.close();
    tabberSubject.close();
  }
}