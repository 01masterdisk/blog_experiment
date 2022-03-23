import 'package:blog_experimental/constant/CustomStyle.dart';
import 'package:blog_experimental/constant/Separator.dart';
import 'package:blog_experimental/model/PostBody.dart';
import 'package:flutter/material.dart';

class Recycler extends StatelessWidget {
  final PostBody body;
  Recycler({required this.body});
  
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(15, 15, 15, 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(body.title,
              style: new CustomStyle().TitleValue(),
              ),
            ),
          ),
          new Separator().Large(),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0),
            child: Text("created at : ${body.created_at}",
              style: new CustomStyle().Default(),),
          ),
          new Separator().Large(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(body.body,
              style: new CustomStyle().ValueColor(),
            ),
          ),
          new Separator().Large(),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
            child: Text("author : ${body.author}",
              style: new CustomStyle().ValueBold(),),
          ),
        ],
      ),
    );
  }
}
