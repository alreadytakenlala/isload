import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:island/common/bloc/base_bloc.dart';
import 'package:island/common/bloc/me_bloc.dart';
import 'package:island/modules/Category_data.dart';
import 'package:island/states/category.dart';

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
            child: Category(
              backgroundColor: categoryItem.backgroundColor,
              name: categoryItem.name,
              banner: categoryItem.banner
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
                    cacheExtent: 3000.0,
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