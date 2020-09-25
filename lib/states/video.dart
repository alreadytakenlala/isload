import 'package:flutter/material.dart';
import 'package:island/common/bloc/media_bloc.dart';
import 'package:video_player/video_player.dart';

class Video extends StatefulWidget {
  final String url;
  final double maxWidth;
  final double maxHeight;
  const Video({
    Key key,
    @required this.url,
    this.maxWidth = 200,
    this.maxHeight = 200
  }) : super(key: key);
  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  VideoPlayerController _controller;
  MediaBloc bloc = new MediaBloc();
  @override
  void initState() {
    bool isAssets = widget.url.startsWith("assets/");
    if (isAssets) {
      _controller = VideoPlayerController.asset(widget.url);
    } else {
      _controller = VideoPlayerController.network(widget.url);
    }
    _controller.addListener(() {
      bloc.sink.add(_controller.value);
      print(_controller.value.aspectRatio);
    });
    _controller.setLooping(true);
    _controller.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints(maxWidth: widget.maxWidth, maxHeight: widget.maxHeight),
        child: StreamBuilder(
            stream: bloc.stream,
            builder: (BuildContext context, AsyncSnapshot<VideoPlayerValue> snapshot) {
              return AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: <Widget>[
                        VideoPlayer(_controller)
                      ]
                  )
              );
            }
        )
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}