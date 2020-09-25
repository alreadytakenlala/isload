import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:video_player/video_player.dart';
import 'base_bloc.dart';

class MediaBloc extends BaseBloc {

  BehaviorSubject<VideoPlayerValue> subject = BehaviorSubject<VideoPlayerValue>();
  StreamSink<VideoPlayerValue> get sink => subject.sink;
  Stream<VideoPlayerValue> get stream => subject.stream;

  @override
  void dispose() {
    subject.close();
  }
}