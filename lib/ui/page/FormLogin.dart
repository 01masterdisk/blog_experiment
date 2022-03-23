

import 'dart:convert';
import 'package:blog_experimental/api/RequestAPI.dart';
import 'package:blog_experimental/constant/CustomStyle.dart';
import 'package:blog_experimental/constant/Notif.dart';
import 'package:blog_experimental/constant/Separator.dart';
import 'package:blog_experimental/ui/Home.dart';
import 'package:blog_experimental/ui/page/FormRegister.dart';
import 'package:blog_experimental/utils/Utility.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class FormLogin extends StatefulWidget {
  const FormLogin({Key? key}) : super(key: key);

  @override
  _FormLoginState createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {

  var _form = GlobalKey<FormState>();
  var _formController = {
    "email" : TextEditingController(),
    "password" : TextEditingController()
  };

  void doLogin() async{
    http.Response res = await RequestAPI().login(_formController["email"]?.value.text, _formController["password"]?.value.text);
    if(res.statusCode == 200){
      var x = jsonDecode(res.body);
      if(x["token"] != null){
        Notif().snack(context,"Welcome, ${x["user"]["name"]}");
        Utility().ChangeActivity(context, Home());
      }else{
       Notif().snack(context,x["error_message"]);
      }
    }else{
      Notif().snack(context,Notif().opps);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
        child: Card(
          margin: EdgeInsets.all(25),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Welcome',style: new CustomStyle().Title(),),
                  Text('Are you already registered ?',style: new CustomStyle().Value(),),
                  new Separator().Large(),
                  TextFormField(
                    autofocus: true,
                    controller: _formController["email"],
                    validator: (String? value){
                      if(value!.isEmpty){
                        return "Email must be filled !";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'email@mail.com',
                    ),
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: _formController["password"],
                    validator: (String? value){
                      if(value!.isEmpty){
                        return "Password must be filled !";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Password',
                    ),
                  ),
                  new Separator().Large(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      RaisedButton.icon(
                        onPressed: (){
                          Utility().ChangeActivity(context, FormRegister());
                        },
                        color: Colors.white,
                        colorBrightness: Brightness.light,
                        label : Text("REGISTER",style: new CustomStyle().Value(),),
                        icon: Icon(Icons.person_add),
                      ),

                      RaisedButton.icon(
                        onPressed: (){
                          if(_form.currentState!.validate()){
                            doLogin();
                          }
                        },
                        color: Colors.amber,
                        colorBrightness: Brightness.light,
                        icon: Icon(Icons.login),
                        label: Text('SIGN IN', style: new CustomStyle().Value(),),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


