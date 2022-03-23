import 'package:flutter/material.dart';

class Notif{
  SnackBar snack(String? msg){
    return SnackBar(content:
     Text("$msg"),
    );
  }
}