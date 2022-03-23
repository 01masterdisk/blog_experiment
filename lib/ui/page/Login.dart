

import 'dart:convert';

import 'package:blog_experimental/api/RequestAPI.dart';
import 'package:blog_experimental/constant/CustomStyle.dart';
import 'package:blog_experimental/constant/Notif.dart';
import 'package:blog_experimental/constant/Separator.dart';
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => FormRegister()));
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

      }else{
        // JIKA GAGAL LOGIN
        ScaffoldMessenger.of(context).showSnackBar(Notif().snack(x["error_message"]));
      }
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
                  Text('Welcom to Registration Form',style: new CustomStyle().Title(),),
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
