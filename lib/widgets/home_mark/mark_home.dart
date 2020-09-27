import 'package:flutter/cupertino.dart';
import 'package:island/common/bloc/base_bloc.dart';
import 'package:island/common/bloc/mark_bloc.dart';
import 'package:island/common/bloc/swiper_bloc.dart';
import 'package:island/common/utils/http.dart';
import 'package:island/modules/api_data.dart';
import 'package:island/routes/home/main_nav.dart';
import 'package:island/widgets/home_main/recommend.dart';

class Mark extends StatefulWidget {
  @override
  _Mark createState() => _Mark();
}

class _Mark extends State<Mark> with AutomaticKeepAliveClientMixin {
  List<dynamic> list = [];
  MarkBloc bloc = new MarkBloc();
  SwiperBloc homeSwiperBolc;

  @override
  void initState() {
    super.initState();
    loadList();
  }

  loadList() async {
    var res = await Http.get(api: ApiData.getFeedListByFollowings);
    print(res);
    bloc.listSink.add(res);
  }

  // 加载推荐列表
  Widget loadRecommendList(list) {
    List<Widget> recommends = [];
    for (int i=0; i<list.length; i++) {
      recommends.add(Recommend(recommend: list[i]));
    }
    return ListView(
        children: recommends
    );
  }

  @override
  Widget build(BuildContext context) {
    homeSwiperBolc = BlocProvider.of<SwiperBloc>(context);
    return Container(
      color: Color(0xFF0e0e0e),
      width: double.infinity,
      height: double.infinity,
      child: Stack(
          children: <Widget>[
            StreamBuilder(
                stream: homeSwiperBolc.indexStream,
                builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
                  double index = snapshot.data;
                  return (index != null && index > 2) ? MainNav() : Container();
                }
            ),
            StreamBuilder(
                stream: bloc.listStream,
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  return Container(
                      margin: EdgeInsets.only(top: 80.0),
                      child: snapshot.data != null ? loadRecommendList(snapshot.data) : Container()
                  );
                }
            )
          ]
      )
    );
  }

  @override
  bool get wantKeepAlive => true;
}