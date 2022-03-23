import 'package:flutter/material.dart';

class Notif{
  String opps = "Opps... Someting wrong...";
  void snack(BuildContext context,String? msg){
    var x =  SnackBar(content:
     Text("$msg"),
    );
    ScaffoldMessenger.of(context).showSnackBar(x);

  }
}