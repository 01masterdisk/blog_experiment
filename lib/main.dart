import 'package:flutter/material.dart';
import 'UI/Home.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      brightness: Brightness.dark,

    ),
    home: Home(),
    navigatorKey: GlobalKey(
      debugLabel: 'Login'
    ),
  ));
}



