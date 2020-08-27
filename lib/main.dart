import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:island/Home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(new Application());
}

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "岛",
      theme: new ThemeData(
        primaryColor: Colors.blue
      ),
      debugShowCheckedModeBanner: false,
      routes: {
      },
      home: new Home()
    );
  }
}