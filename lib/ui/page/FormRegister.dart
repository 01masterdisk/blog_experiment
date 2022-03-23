
import 'dart:convert';

import 'package:blog_experimental/constant/CustomStyle.dart';
import 'package:blog_experimental/constant/Separator.dart';
import 'package:blog_experimental/utils/Utility.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

import '../../UI/Home.dart';
import '../../api/RequestAPI.dart';
import '../../constant/Notif.dart';

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
        Notif().snack(context, "Welcome ${x["user"]["name"]}");
        Utility().ChangeActivity(context, Home());
      }else{
        Notif().snack(context,x["error_message"]);
      }
    }else{
      Notif().snack(context, Notif().opps);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
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
                children: [
                  Text('Welcome to Registration Form',style: new CustomStyle().Title(),),
                  Text('Please fill the form below and posting what ever you want.',style: new CustomStyle().Value(),),
                  new Separator().Large(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0,4,8,4),
                    child: TextFormField(
                      autofocus: true,
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0,4,8,4),
                    child: TextFormField(
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0,4,8,4),
                    child: TextFormField(
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0,4,8,4),
                    child: TextFormField(
                      obscureText: true,
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
                  new Separator().Large(),
                  RaisedButton.icon(
                    onPressed: (){
                      if(_form.currentState!.validate()){
                        doRegister();
                      }
                    },
                    color: Colors.white,
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