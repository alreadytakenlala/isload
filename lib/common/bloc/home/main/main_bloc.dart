import 'dart:async';
import 'package:island/common/bloc/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

class MainBloc extends BaseBloc {

  // 推荐列表
  BehaviorSubject<dynamic> listSubject = BehaviorSubject<dynamic>();
  StreamSink<dynamic> get listSink => listSubject.sink;
  Stream<dynamic> get listStream => listSubject.stream;

  @override
  void dispose() {
    listSubject.close();
  }
}