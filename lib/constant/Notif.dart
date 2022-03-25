import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


import 'CustomStyle.dart';

class Notif{
  String opps = "Opps... Someting wrong...";
  void snack(BuildContext context,String? msg){
    var x =  SnackBar(
      backgroundColor: Colors.amber,
      content: Text("$msg",style: TextStyle(fontWeight: FontWeight.bold),),
    );
    ScaffoldMessenger.of(context).showSnackBar(x);
  }
  void loading(BuildContext context){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: SingleChildScrollView(
            child: ListTile(
              title:  Center(child: Text("Loading",style: CustomStyle().Title(),)),
              subtitle: SpinKitFadingFour(
                color: Colors.amber,
              ),
              ),
          )
          );
      },
    );
  }
}