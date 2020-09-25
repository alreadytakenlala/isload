import 'dart:async';
import 'package:island/modules/Category_data.dart';
import 'package:rxdart/rxdart.dart';

import 'base_bloc.dart';

class MeBloc implements BaseBloc {

  // 分类列表
  BehaviorSubject<List<CategoryData>> categoryListSubject = BehaviorSubject<List<CategoryData>>();
  StreamSink<List<CategoryData>> get categoryListSink => categoryListSubject.sink;
  Stream<List<CategoryData>> get categoryListStream => categoryListSubject.stream;

  @override
  void dispose() {
    categoryListSubject.close();
  }
}