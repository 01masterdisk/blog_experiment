import 'package:blog_experimental/constant/CustomStyle.dart';
import 'package:blog_experimental/constant/Separator.dart';
import 'package:blog_experimental/model/PostBody.dart';
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
  var _user = "Badu";
  var _dateNow;
  var _post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Post"),
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
                  Text("Welcome, $_user",style: new CustomStyle().Title(),),
                  Text('What are you thinking today ?',style: new CustomStyle().Default(),),
                  new Separator().Large(),
                  Text('Title :',),
                  TextFormField(
                    controller: _formController["title"],
                    decoration: InputDecoration(
                      hintText: 'Title of your posting',
                    ),
                  ),
                  new Separator().Large(),
                  Text('Content :',),
                  TextFormField(
                    controller: _formController["body"],
                    maxLength: 200,
                    maxLines: 3,
                    validator: (String? value){
                      if(value!.isEmpty){
                        return "What do you want to say ?";
                      }
                      return null;
                    },
                  ),
                  new Separator().Large(),
                  FlatButton.icon(
                    onPressed: (){
                      if(_form.currentState!.validate()){
                        _post = new PostBody(
                            author: _user,
                            created_at: new Utility().Datenow(),
                            body: _formController["body"]!.value.text,
                            title: _formController["title"]!.value.text,
                            id: "32",
                            updated_at: new Utility().Datenow()
                        );
                        print("Mantap");
                        print(_post.toString());

                      }else{
                        setState(() {
                          _formController["body"] = TextEditingController();
                        });
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
