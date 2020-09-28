import 'dart:async';
import 'package:island/common/bloc/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

class SwiperBloc extends BaseBloc {

  /// 页数
  BehaviorSubject<int> subject = BehaviorSubject<int>();
  StreamSink<int> get sink => subject.sink;
  Stream<int> get stream => subject.stream;

  /// 滑动索引
  BehaviorSubject<double> indexSubject = BehaviorSubject<double>();
  StreamSink<double> get indexSink => indexSubject.sink;
  Stream<double> get indexStream => indexSubject.stream;

  // 指定滚动到某个页数
  BehaviorSubject<int> toSubject = BehaviorSubject<int>();
  StreamSink<int> get toSink => toSubject.sink;
  Stream<int> get toStream => toSubject.stream;

  @override
  void dispose() {
    subject.close();
    indexSubject.close();
    toSubject.close();
  }
}