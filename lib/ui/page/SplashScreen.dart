import 'package:blog_experimental/constant/Notif.dart';
import 'package:blog_experimental/ui/page/FormLogin.dart';
import 'package:blog_experimental/ui/page/Home.dart';
import 'package:blog_experimental/utils/SessionManager.dart';
import 'package:blog_experimental/utils/Utility.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  void autoLogin() async{
    var x = await SessionManager().getUsername();
    Future.delayed(Duration(milliseconds: 5000),(){
      if(x != null){
        Notif().snack(context,"Welcome, $x");
        Utility().ChangeActivity(context, Home(username: x,));
      }else{
        Utility().ChangeActivity(context, FormLogin());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    PackageInfo.fromPlatform().then((value) {
      Notif().snack(context, "v${value.version}");
      autoLogin();
    });
    //autoLogin();
    return Scaffold(
      body: SafeArea(
        child: ListTile(
          title: Center(
            child: Icon(
              Icons.post_add,
              size: 200,
            ),
          ),
        ),
      ),
    );
  }
}
