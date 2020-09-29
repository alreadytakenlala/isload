import 'dart:async';

import 'package:island/common/bloc/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

class MarkBloc extends BaseBloc {

  BehaviorSubject<dynamic> listSubject = BehaviorSubject<dynamic>();
  StreamSink<dynamic> get listSink => listSubject.sink;
  Stream<dynamic> get listStream => listSubject.stream;

  BehaviorSubject<dynamic> categorysSubject = BehaviorSubject<dynamic>();
  StreamSink<dynamic> get categorysSink => categorysSubject.sink;
  Stream<dynamic> get categorysStream => categorysSubject.stream;

  @override
  void dispose() {
    listSubject.close();
    categorysSubject.close();
  }
}