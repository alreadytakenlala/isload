import 'dart:async';
import 'package:island/common/bloc/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

class IslandBloc extends BaseBloc {

  // 详情数据
  BehaviorSubject<dynamic> subject = BehaviorSubject<dynamic>();
  StreamSink<dynamic> get sink => subject.sink;
  Stream<dynamic> get stream => subject.stream;

  // 主题列表
  BehaviorSubject<dynamic> topicSubject = BehaviorSubject<dynamic>();
  StreamSink<dynamic> get topicSink => topicSubject.sink;
  Stream<dynamic> get topicStream => topicSubject.stream;

  @override
  void dispose() {
    subject.close();
    topicSubject.close();
  }
}