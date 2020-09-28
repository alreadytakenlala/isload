import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:video_player/video_player.dart';
import 'base_bloc.dart';

class MessageBloc extends BaseBloc {

  BehaviorSubject<dynamic> subject = BehaviorSubject<dynamic>();
  StreamSink<dynamic> get sink => subject.sink;
  Stream<dynamic> get stream => subject.stream;

  @override
  void dispose() {
    subject.close();
  }
}