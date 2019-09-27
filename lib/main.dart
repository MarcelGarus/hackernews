import 'package:flutter/material.dart';

import 'data.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HackerNews',
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: Scaffold(
        body: Center(
          child: FlutterLogo(),
        ),
      ),
    );
  }
}
