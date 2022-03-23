
import 'package:flutter/material.dart';
class Utility{
  String Datenow(){
    final x = DateTime.now();
    return "$x";
  }
  void ChangeActivity( BuildContext context,Widget page ){
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }
}