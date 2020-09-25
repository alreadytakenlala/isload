import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:island/common/bloc/base_bloc.dart';
import 'package:island/common/bloc/me_bloc.dart';
import 'package:island/modules/Category_data.dart';

class MeCategoryList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MeCategoryListState();
}

class _MeCategoryListState extends State<MeCategoryList> {
  // 加载分类
  Widget getCategoryList(List<CategoryData> list) {
    List<Widget> categoryWidget = [];
    for (int i=0; i<list.length; i++) {
      CategoryData categoryData = list[i];
      List<Widget> categoryItemWidget = [];
      for (int j=0; j<categoryData.list.length; j++) {
        CategoryItem categoryItem = categoryData.list[j];
        categoryItemWidget.add(Container(
            margin: EdgeInsets.only(left: j!=0?12.0:0),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Stack(
                    children: <Widget>[
                      Image.network(categoryItem.banner,
                          fit: BoxFit.fill,
                          width: 100.0,
                          height: 135.0
                      ),
                      Container(
                          alignment: Alignment.center,
                          child: Container(
                              width: 60.0,
                              height: 20.0,
                              margin: EdgeInsets.only(left: 20.0),
                              alignment: Alignment.center,
                              color: Color(categoryItem.backgroundColor),
                              child: Text(categoryItem.name,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0
                                  )
                              )
                          )
                      )
                    ]
                )
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
                    child: Text(categoryData.title,
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
        builder: (BuildContext context, AsyncSnapshot<List<CategoryData>> snapshot) {
          return snapshot.data != null ? getCategoryList(snapshot.data) : Container();
        }
    );
  }
}