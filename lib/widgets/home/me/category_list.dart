import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:island/common/bloc/base_bloc.dart';
import 'package:island/common/bloc/home/me/me_bloc.dart';
import 'package:island/states/category.dart';

class MeCategoryList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MeCategoryListState();
}

class _MeCategoryListState extends State<MeCategoryList> {
  // 加载分类
  Widget getCategoryList(dynamic list) {
    List<Widget> categoryWidget = [];
    for (int i=0; i<list.length; i++) {
      dynamic categoryData = list[i];
      List<Widget> categoryItemWidget = [];
      for (int j=0; j<categoryData["islands"].length; j++) {
        dynamic categoryItem = categoryData["islands"][j];
        categoryItemWidget.add(Container(
            margin: EdgeInsets.only(left: j!=0?12.0:0),
            child: GestureDetector(
              child: Category(
                  backgroundColor: categoryItem["backgroundColor"][0],
                  name: categoryItem["name"],
                  banner: categoryItem["banner"]
              ),
              onTap: () {
                  Navigator.pushNamed(context, "island_page", arguments: categoryItem["id"]);
              }
            )
        ));
      }

      categoryWidget.add(Column(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: i!=0?30.0:0),
                child: Container(
                    margin: EdgeInsets.only(left: 2.0),
                    alignment: Alignment.centerLeft,
                    child: Text(categoryData["name"],
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            letterSpacing: 3.0
                        )
                    )
                )
            ),
            Container(
                height: 135.0,
                margin: EdgeInsets.only(top: 21.0),
                child: ListView(
                    cacheExtent: double.infinity,
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    children: categoryItemWidget
                )
            )
          ]
      ));
    }
    return Container(
        margin: EdgeInsets.only(bottom: 80.0),
        child: Column(children: categoryWidget)
    );
  }

  @override
  Widget build(BuildContext context) {
    MeBloc bloc = BlocProvider.of<MeBloc>(context);
    return StreamBuilder(
        stream: bloc.categoryListStream,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return snapshot.data != null ? getCategoryList(snapshot.data) : Container();
        }
    );
  }
}