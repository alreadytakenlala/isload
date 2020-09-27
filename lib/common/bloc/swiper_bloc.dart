import 'dart:async';
import 'package:island/common/bloc/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

class SwiperBloc extends BaseBloc {

  BehaviorSubject<int> subject = BehaviorSubject<int>();
  StreamSink<int> get sink => subject.sink;
  Stream<int> get stream => subject.stream;

  BehaviorSubject<double> indexSubject = BehaviorSubject<double>();
  StreamSink<double> get indexSink => indexSubject.sink;
  Stream<double> get indexStream => indexSubject.stream;

  @override
  void dispose() {
    subject.close();
    indexSubject.close();
  }
}