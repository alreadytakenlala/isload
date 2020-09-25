import 'package:flutter/material.dart';
import 'package:island/common/bloc/swiper_bloc.dart';

class Swiper extends StatefulWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final bool indicatorDots;
  final SwiperBloc bloc;

  Swiper({
    Key key,
    this.indicatorDots : true,
    @required this.itemCount,
    @required this.itemBuilder,
    @required this.bloc,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SwiperState();
}

class _SwiperState extends State<Swiper> {
  PageController controller = new PageController(
      initialPage: 0,
      keepPage: true,
      viewportFraction: 1.0
  );

  List<Container> carousel() {
    List<Container> carousel = [];
    for (int i=0; i < widget.itemCount; i++) {
      carousel.add(Container(
          margin: EdgeInsets.only(left: i != 0 ? 5.0 : 0),
          child: ClipOval(
              child: StreamBuilder(
                stream: widget.bloc.stream,
                builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                  int index = snapshot.data == null ? 0 : snapshot.data;
                  return Container(
                      width: 6.0,
                      height: 6.0,
                      color: index == i ? Color(0xFFFFFFFF) : Color(0xFF686868)
                  );
                }
              )
          )
      ));
    }
    return carousel;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: <Widget>[
          PageView.builder(
              itemCount: widget.itemCount,
              controller: controller,
              itemBuilder: (context, index) {
                return widget.itemBuilder(context,index);
              },
              onPageChanged: (int page) {
                widget.bloc.sink.add(page);
              }
          ),
          Offstage(
            offstage: !widget.indicatorDots,
            child: Container(
                width: double.infinity,
                height: double.infinity,
                transform: Matrix4.translationValues(0, 163, 0),
                child: Center(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: carousel()
                    )
                )
            )
          )
        ]
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}