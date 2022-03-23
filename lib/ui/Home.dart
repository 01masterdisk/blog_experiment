
import 'package:blog_experimental/UI/page/Login.dart';
import 'package:blog_experimental/UI/list/Recycler.dart';
import 'package:blog_experimental/api/RequestAPI.dart';
import 'package:blog_experimental/model/PostBody.dart';
import 'package:blog_experimental/ui/page/Login.dart';
import 'package:blog_experimental/utils/Utility.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'page/PostForm.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var data = [
    PostBody(author: 'Badu', created_at: '2022-03-06', body: 'Bayang2 Selayang Pandang', title: 'Ngigo'),
    PostBody(author: 'Badu', created_at: '2022-03-06', body: 'Bayang2 Selayang Pandang', title: 'Ngigo'),
    PostBody(author: 'Badu', created_at: '2022-03-06', body: 'Bayang2 Selayang Pandang', title: 'Ngigo'),
    PostBody(author: 'Badu', created_at: '2022-03-06', body: 'Bayang2 Selayang Pandang', title: 'Ngigo'),
    PostBody(author: 'Badu', created_at: '2022-03-06', body: 'Bayang2 Selayang Pandang', title: 'Ngigo'),
    PostBody(author: 'Badu', created_at: '2022-03-06', body: 'Bayang2 Selayang Pandang', title: 'Ngigo'),
    PostBody(author: 'Badu', created_at: '2022-03-06', body: 'Bayang2 Selayang Pandang', title: 'Ngigo'),
    PostBody(author: 'Badu', created_at: '2022-03-06', body: 'Bayang2 Selayang Pandang', title: 'Ngigo'),
    PostBody(author: 'Badu', created_at: '2022-03-06', body: 'Bayang2 Selayang Pandang', title: 'Ngigo'),
    PostBody(author: 'Badu', created_at: '2022-03-06', body: 'Bayang2 Selayang Pandang', title: 'Ngigo'),
    PostBody(author: 'Badu', created_at: '2022-03-06', body: 'Bayang2 Selayang Pandang', title: 'Ngigo'),
    PostBody(author: 'Badu', created_at: '2022-03-06', body: 'Bayang2 Selayang Pandang', title: 'Ngigo'),
    PostBody(author: 'Badu', created_at: '2022-03-06', body: 'Bayang2 Selayang Pandang', title: 'Ngigo'),
    PostBody(author: 'Badu', created_at: '2022-03-06', body: 'Bayang2 Selayang Pandang', title: 'Ngigo'),
    PostBody(author: 'Badu', created_at: '2022-03-06', body: 'Bayang2 Selayang Pandang', title: 'Ngigo'),
    PostBody(author: 'Badu', created_at: '2022-03-06', body: 'Bayang2 Selayang Pandang', title: 'Ngigo'),
    PostBody(author: 'Badu', created_at: '2022-03-06', body: 'Bayang2 Selayang Pandang', title: 'Ngigo'),
    PostBody(author: 'Badu', created_at: '2022-03-06', body: 'Bayang2 Selayang Pandang', title: 'Ngigo'),
    PostBody(author: 'Badu', created_at: '2022-03-06', body: 'Bayang2 Selayang Pandang', title: 'Ngigo'),
    PostBody(author: 'Badu', created_at: '2022-03-06', body: 'Bayang2 Selayang Pandang', title: 'Ngigo'),
    PostBody(author: 'Badu', created_at: '2022-03-06', body: 'Bayang2 Selayang Pandang', title: 'Ngigo'),
    PostBody(author: 'Badu', created_at: '2022-03-06', body: 'Bayang2 Selayang Pandang', title: 'Ngigo'),
    PostBody(author: 'Badu', created_at: '2022-03-06', body: 'Bayang2 Selayang Pandang', title: 'Ngigo'),
    PostBody(author: 'Badu', created_at: '2022-03-06', body: 'Bayang2 Selayang Pandang', title: 'Ngigo'),
    PostBody(author: 'Badu', created_at: '2022-03-06', body: 'Bayang2 Selayang Pandang', title: 'Ngigo'),
    PostBody(author: 'Badu', created_at: '2022-03-06', body: 'Bayang2 Selayang Pandang', title: 'Ngigo'),
    PostBody(author: 'Badu', created_at: '2022-03-06', body: 'Bayang2 Selayang Pandang', title: 'Ngigo'),
    PostBody(author: 'Badu', created_at: '2022-03-06', body: 'Bayang2 Selayang Pandang', title: 'Ngigo'),
    PostBody(author: 'Badu', created_at: '2022-03-06', body: 'Bayang2 Selayang Pandang', title: 'Ngigo'),
    PostBody(author: 'Badu', created_at: '2022-03-06', body: 'Bayang2 Selayang Pandang', title: 'Ngigo'),
    PostBody(author: 'Badu', created_at: '2022-03-06', body: 'Bayang2 Selayang Pandang', title: 'Ngigo'),
    PostBody(author: 'Badu', created_at: '2022-03-06', body: 'Bayang2 Selayang Pandang', title: 'Ngigo'),
    PostBody(author: 'Badu', created_at: '2022-03-06', body: 'Bayang2 Selayang Pandang', title: 'Ngigo'),
    PostBody(author: 'Badu', created_at: '2022-03-06', body: 'Bayang2 Selayang Pandang', title: 'Ngigo'),
    PostBody(author: 'Badu', created_at: '2022-03-06', body: 'Bayang2 Selayang Pandang', title: 'Ngigo'),
    PostBody(author: 'Badu', created_at: '2022-03-06', body: 'Bayang2 Selayang Pandang', title: 'Ngigo'),
  ];

  // void login() async {
  //   http.Response x = await RequestAPI().login("anto@gmail.com", "123123123");
  //   print("error code : ${x.statusCode}");
  //   print("Content code : ${x.body}");
  // }

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
              title: Text('Login'),
              onTap: (){
                Utility().ChangeActivity(context, FormLogin());
              },
            ),
            ListTile(
              title: Text('New Posting'),
              onTap: () {
                Utility().ChangeActivity(context,PostForm());
              },
            )
          ],
        ),
      ),
    );
  }
}