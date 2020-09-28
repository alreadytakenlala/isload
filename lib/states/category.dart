import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Category extends StatefulWidget {
  final int backgroundColor;
  final String name;
  final String banner;
  Category({Key key, this.backgroundColor, this.name, this.banner}) : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: Stack(
            children: <Widget>[
              Image.network(widget.banner,
                  fit: BoxFit.cover,
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
                      color: Color(widget.backgroundColor),
                      child: Text(widget.name,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0
                          )
                      )
                  )
              )
            ]
        )
    );
  }
}