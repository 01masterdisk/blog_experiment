import 'package:blog_experimental/constant/CustomStyle.dart';
import 'package:blog_experimental/constant/Separator.dart';
import 'package:blog_experimental/model/PostBody.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Recycler extends StatelessWidget {
  final PostBody body;
  Recycler({required this.body});
  
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(30, 15, 30, 5),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0,8,0,0),
        child: ListTile(
          title: Text(body.title,style: CustomStyle().TitleValue(),),
          subtitle: Column(
            children: [

              ListTile(
                  leading: Icon(
                    Icons.person
                  ),
                  title: Text(body.author,style: CustomStyle().Default(),)
              ),
              ListTile(
                  leading: Icon(
                      Icons.date_range_outlined
                  ),
                  title: Text("created at : ${body.created_at}\nlast update : ${body.updated_at}",style: CustomStyle().Default(),)
              ),
              ListTile(
                  leading: Icon(
                      Icons.abc
                  ),
                  title: Text(body.body,style: CustomStyle().ValueColor(),)
              ),
            ],
          ),
        ),
      )
    );
  }
}

//