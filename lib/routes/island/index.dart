import 'package:flutter/cupertino.dart';

import 'nav.dart';

class IslandPage extends StatefulWidget {
  @override
  _IslandPageState createState() => _IslandPageState();
}

class _IslandPageState extends State<IslandPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Nav()
        ]
      )
    );
  }
}

