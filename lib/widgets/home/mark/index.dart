import 'package:flutter/cupertino.dart';
import 'package:island/common/bloc/base_bloc.dart';
import 'file:///D:/project-study/mobility/island/lib/common/bloc/home/mark/mark_bloc.dart';
import 'package:island/common/bloc/swiper_bloc.dart';
import 'package:island/common/utils/http.dart';
import 'package:island/modules/api_data.dart';
import 'package:island/states/category.dart';
import 'package:island/widgets/home/main/nav.dart';
import 'package:island/widgets/home/main/recommend.dart';

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
    loadCategorys();
  }

  loadCategorys() async {
    var res = await Http.get(api: ApiData.getMarkCategoryList);
    bloc.categorysSink.add(res);
  }

  loadList() async {
    var res = await Http.get(api: ApiData.getFeedListByFollowings);
    bloc.listSink.add(res);
  }

  Widget loadMarkList(list) {
    List<Widget> recommends = [];
    for (int i=0; i<list.length; i++) recommends.add(Recommend(recommend: list[i]));
    return Column(
      children: recommends
    );
  }

  Widget loadCategorysList(list) {
    List<Widget> categorys = [];
    for (int i=0; i<list.length; i++) {
      dynamic island = list[i]["island"];
      categorys.add(Container(
          margin: EdgeInsets.only(left: i > 0 ? 10.0 : 0.0),
          child: Category(backgroundColor: island["backgroundColor"][0], name: island["name"], banner: island["banner"])
      ));
    }
    return Container(
        height: 135.0,
        margin: EdgeInsets.only(left: 10.0, bottom: 30.0),
        child: ListView(
            cacheExtent: double.infinity,
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            children: categorys
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    homeSwiperBolc = BlocProvider.of<SwiperBloc>(context);
    return Container(
      color: Color(0xFF0e0e0e),
      child: Stack(
          children: <Widget>[
            StreamBuilder(
                stream: homeSwiperBolc.indexStream,
                builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
                  double index = snapshot.data;
                  return (index != null && index > 2) ? Nav() : Container();
                }
            ),
            Container(
                margin: EdgeInsets.only(top: 80.0),
                child: ListView(
                    cacheExtent: double.infinity,
                    children: <Widget>[
                      StreamBuilder(
                        stream: bloc.categorysStream,
                        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                          return snapshot.data != null ? loadCategorysList(snapshot.data) : Container();
                        }
                      ),
                      StreamBuilder(
                          stream: bloc.listStream,
                          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                            return snapshot.data != null ? loadMarkList(snapshot.data) : Container();
                          }
                      )
                    ]
                )
            )
          ]
      )
    );
  }

  @override
  bool get wantKeepAlive => true;
}