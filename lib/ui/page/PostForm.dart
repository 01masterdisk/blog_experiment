import 'dart:convert';
import 'package:blog_experimental/api/RequestAPI.dart';
import 'package:blog_experimental/constant/CustomStyle.dart';
import 'package:blog_experimental/constant/Notif.dart';
import 'package:blog_experimental/constant/Separator.dart';
import 'package:blog_experimental/ui/page/FormLogin.dart';
import 'package:blog_experimental/ui/page/Home.dart';
import 'package:blog_experimental/utils/SessionManager.dart';
import 'package:blog_experimental/utils/Utility.dart';
import 'package:flutter/material.dart';


class PostForm extends StatefulWidget {
  const PostForm({Key? key}) : super(key: key);

  @override
  _PostFormState createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  var _form = GlobalKey<FormState>();
  var _formController = {
    "title" : TextEditingController(),
    "body" : TextEditingController(),
  };
  var _user = "";

  void setValue() async {
    _user = (await SessionManager().getUsername())!;
  }

  void doPosting() async {
    Notif().loading(context);
    String? title ;
    if(_formController["title"] == null){
      title = "Untitled";
    }else{
      title = _formController["title"]?.value.text.toString();
    }
    var resp = await RequestAPI().posting(
        title,
        _formController["body"]?.value.text
    );
    Navigator.pop(context);
    print(resp.body);
    switch(resp.statusCode){
      case 200 :
        var x = jsonDecode(resp.body);
        Notif().snack(context, x["message"]);
        Utility().ChangeActivity(context, Home(username: _user,));
        break;
      case 401 :
        Notif().snack(context, "Please Login First");
        Utility().ChangeActivity(context, FormLogin());
        break;
      default:
        Notif().snack(context, Notif().opps);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Utility().ChangeActivity(context, Home(username: _user,));
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Form(
            key: _form,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(title: Text('What are you thinking today ?',style: new CustomStyle().Title(),)),
                  new Separator().Large(),
                  Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.abc
                      ),
                      title: Text('Title :',),
                      subtitle: TextFormField(
                        controller: _formController["title"],
                        decoration: InputDecoration(
                          hintText: 'Title of your posting',
                        ),
                      ),
                    ),
                  ),


                  Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.abc
                      ),
                      title: Text('Content :',),
                      subtitle: TextFormField(
                        controller: _formController["body"],
                        maxLength: 500,
                        maxLines: 5,
                        validator: (String? value){
                          if(value!.isEmpty){
                            return "What do you want to say ?";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  new Separator().Large(),
                  RaisedButton.icon(
                    onPressed: (){
                      if(_form.currentState!.validate()){
                        doPosting();
                      }
                    },
                    color: Colors.amber,
                    colorBrightness: Brightness.light,
                    label : Text("POST IT",style: new CustomStyle().Value(),),
                    icon: Icon(Icons.post_add),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
