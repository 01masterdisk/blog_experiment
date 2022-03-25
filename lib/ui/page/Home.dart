
import 'dart:convert';

import 'package:blog_experimental/UI/list/Recycler.dart';
import 'package:blog_experimental/api/RequestAPI.dart';
import 'package:blog_experimental/constant/CustomStyle.dart';
import 'package:blog_experimental/constant/Notif.dart';
import 'package:blog_experimental/model/PostBody.dart';
import 'package:blog_experimental/utils/Utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

import '../../UI/page/FormLogin.dart';
import 'PostForm.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var data = [];

  void doGetBlog() async {
    Notif().loading(context);
    Navigator.pop(context);
     http.Response resp = await RequestAPI().list_blog();
      switch (resp.statusCode){
        case 200 : var x = jsonDecode(resp.body);
                  List<dynamic> tmp = x["blogs"];
                  if(tmp.length>0) {
                    for (int i = 0; i < tmp.length; i++) {
                      data.add(PostBody(
                          author: tmp[i]["created_by"].toString(),
                          created_at: tmp[i]["created_at"].toString(),
                          body: tmp[i]["content"].toString(),
                          title: tmp[i]["title"].toString(),
                          id: tmp[i]["id"].toString(),
                          updated_at: tmp[i]["updated_at"].toString()
                      ));
                    }
                  }
                  break;
        case 401 : Utility().ChangeActivity(context, FormLogin());
                   Notif().snack(context, "Please Login First");
                   break;
        default : Notif().snack(context, Notif().opps);
                  break;
      }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    doGetBlog();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Home')),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: data.map((e) => Recycler(body: e)).toList(),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.grey
              ),
                child: Text('Blog Example')
            ),
            ListTile(
              leading: Icon(
                Icons.post_add
              ),
              title: Text('New Posting'),
              onTap: () {
                Utility().ChangeActivity(context,PostForm());
              },
            ),
            ListTile(
              leading: Icon(
                  Icons.logout
              ),
              title: Text('Logout'),
              onTap: (){

              },
            ),
          ],
        ),
      ),
    );
  }
}