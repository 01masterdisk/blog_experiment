

import 'dart:convert';
import 'package:blog_experimental/api/RequestAPI.dart';
import 'package:blog_experimental/constant/CustomStyle.dart';
import 'package:blog_experimental/constant/Notif.dart';
import 'package:blog_experimental/constant/Separator.dart';
import 'package:blog_experimental/ui/page/Home.dart';
import 'package:blog_experimental/ui/page/FormRegister.dart';
import 'package:blog_experimental/utils/SessionManager.dart';
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

  void autoLogin() async{
    var x = await SessionManager().getUsername();
    print(x);
    if(x != null){
      Notif().snack(context,"Welcome, $x");
      Utility().ChangeActivity(context, Home());
    }
  }
  void doLogin() async{
    Notif().loading(context);
    http.Response res = await RequestAPI().login(_formController["email"]?.value.text, _formController["password"]?.value.text);
    Navigator.pop(context);
    if(res.statusCode == 200){
      var x = jsonDecode(res.body);
      if(x["token"] != null){
        SessionManager().setToken(x);
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
    autoLogin();
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _form,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  title:Text('Welcome to BLOG EXPERIMENTAL !',style: new CustomStyle().Title(),),
                  subtitle: Text('Are you already registered ?',style: new CustomStyle().Value(),),
                ),
                new Separator().Large(),
                Card(
                  child: ListTile(
                    leading: Icon(
                      Icons.email
                    ),
                    title : TextFormField(
                      autofocus: true,
                      keyboardType: TextInputType.emailAddress,
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
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(
                      Icons.password
                    ),
                    title: TextFormField(
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
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
                  ),
                ),
                new Separator().Large(),
                ListTile(
                  leading: FlatButton.icon(
                    onPressed: (){
                      Utility().ChangeActivity(context, FormRegister());
                    },
                    color: Colors.transparent,
                    label : Text("REGISTER",style: new CustomStyle().Default(),),
                    icon: Icon(Icons.person_add),
                  ),
                  title: RaisedButton.icon(
                    onPressed: (){
                      if(_form.currentState!.validate()){
                        doLogin();
                      }
                    },
                    color: Colors.amber,
                    colorBrightness: Brightness.light,
                    icon: Icon(Icons.login),
                    label: Text('SIGN IN', style: new CustomStyle().Value(),),
                  ),
                )


              ],
            ),
          ),
        ),
      ),
    );
  }
}


