import 'dart:async';
import 'package:island/modules/Category_data.dart';
import 'package:rxdart/rxdart.dart';

import '../../base_bloc.dart';

class MeBloc implements BaseBloc {

  // 分类列表
  BehaviorSubject<dynamic> categoryListSubject = BehaviorSubject<dynamic>();
  StreamSink<dynamic> get categoryListSink => categoryListSubject.sink;
  Stream<dynamic> get categoryListStream => categoryListSubject.stream;

  @override
  void dispose() {
    categoryListSubject.close();
  }
}