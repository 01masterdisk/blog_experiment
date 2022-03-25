import 'package:flutter/material.dart';
import 'UI/page/FormLogin.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      brightness: Brightness.dark,

    ),
    home: FormLogin(),
    navigatorKey: GlobalKey(
      debugLabel: 'Login'
    ),
  ));
}



