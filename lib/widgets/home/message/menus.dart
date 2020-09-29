import 'package:flutter/material.dart';
import 'package:island/common/utils/utils.dart';
import 'menu.dart';

class Menus extends StatefulWidget {
  @override
  _MenusState createState() => _MenusState();
}

class _MenusState extends State<Menus> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Menu(
                icon: Utils.getImgPath("ic_interaction_follow"),
                label: "标记"
            ),
            Menu(
                icon: Utils.getImgPath("ic_interaction_love"),
                label: "状态"
            ),
            Menu(
                icon: Utils.getImgPath("ic_interaction_comment"),
                label: "回应"
            ),
            Menu(
                icon: Utils.getImgPath("ic_interaction_favorite"),
                label: "收藏"
            )
          ]
      )
    );
  }
}