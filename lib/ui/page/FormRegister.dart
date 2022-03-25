


import 'package:blog_experimental/constant/CustomStyle.dart';
import 'package:blog_experimental/constant/Separator.dart';
import 'package:blog_experimental/ui/page/FormLogin.dart';
import 'package:blog_experimental/utils/SessionManager.dart';
import 'package:blog_experimental/utils/Utility.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';
import 'package:blog_experimental/ui/page/Home.dart';
import 'package:blog_experimental/api/RequestAPI.dart';
import 'package:blog_experimental/constant/Notif.dart';

class FormRegister extends StatefulWidget {
  const FormRegister({Key? key}) : super(key: key);

  @override
  _FormRegisterState createState() => _FormRegisterState();
}

class _FormRegisterState extends State<FormRegister> {
  var _form = GlobalKey<FormState>();
  var _formController = {
    "username" : TextEditingController(),
    "email" : TextEditingController(),
    "password" : TextEditingController(),
    "confirm_password" :  TextEditingController(),
  };

  void doRegister() async {
    http.Response res = await RequestAPI().register(
        _formController["username"]?.value.text,
        _formController["email"]?.value.text,
        _formController["password"]?.value.text,
        _formController["confirm_password"]?.value.text
    );
    if(res.statusCode == 200){
      var x = jsonDecode(res.body);
      if(x["token"]!= null){
        SessionManager().setToken(x);
        Notif().snack(context, "Welcome ${x["user"]["name"]}");
        Utility().ChangeActivity(context, Home(username: x["user"]["name"],));
      }else{
        Notif().snack(context,x["error_message"]);
      }
    }else{
      Notif().snack(context, Notif().opps);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Utility().ChangeActivity(context, FormLogin());
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
                  ListTile(
                    title: Text('Welcome to Registration Form',style: new CustomStyle().Title(),) ,
                    subtitle: Text('Please fill the form below and posting what ever you want.',style: new CustomStyle().Value(),),
                  ),

                  new Separator().Large(),
                  Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.abc
                      ),
                      title: TextFormField(
                        autofocus: true,
                        keyboardType: TextInputType.name,
                        controller: _formController["username"],
                        validator: (String? value){
                          if(value!.isEmpty){
                            return "Username must be filled !";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Username',
                          hintText: 'Username',
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.email
                      ),
                      title: TextFormField(
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
                        keyboardType: TextInputType.visiblePassword,
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
                        controller: _formController["confirm_password"],
                        validator: (String? value){
                          if(value!.isEmpty){
                            return "Repeat Password !";
                          }
                          if(value != _formController["password"]!.value.text ){
                            return "Password is different !";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          hintText: 'Must be same with Password',
                        ),
                      ),
                    ),
                  ),
                  new Separator().Large(),
                  RaisedButton.icon(
                    onPressed: (){
                      if(_form.currentState!.validate()){
                        doRegister();
                      }
                    },
                    color: Colors.amber,
                    colorBrightness: Brightness.light,
                    label : Text("SIGN UP",style: new CustomStyle().Value(),),
                    icon: Icon(Icons.person_add),
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