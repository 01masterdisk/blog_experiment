import 'package:blog_experimental/utils/SessionManager.dart';
import 'package:http/http.dart' as http;
class RequestAPI{
  String server = "https://blogs.cibportofolio.com";


  /// LOGIN
  Future<http.Response> login  (String? user, String? pass)  async {
    var req  = {
      "email":user,
      "password" : pass
    };
    return await http.post(Uri.parse(server+"/api/login"),body:req);
  }

  /// REGISTER
  Future<http.Response> register (String? name,String? email, String? pass, String? cpass) async {
    var req = {
      "name" : name,
      "email" : email,
      "password" : pass,
      "password_confirmation" : cpass
    };
    return await http.post(Uri.parse(server+"/api/register"),body: req);
  }

  /// Posting
  Future<http.Response> posting (String? title, String? content) async {
    String? rest = "";
    String? author = "";
    rest = await SessionManager().getToken();
    rest = await SessionManager().getToken();
    var req = {
      "created_by" : author,
      "title" : title,
      "content" : content,
    };
    var auth = {
      "Authorization" : "Bearer $rest"
    };
    print(req);
    print(auth);
    return await http.post(Uri.parse(server+"/api/blog"),headers: auth,body: req);
  }

  /// List Blog
  Future<http.Response> list_blog () async {
    String? rest = "";
    rest = await SessionManager().getToken();
    var auth = {
      "Authorization" : "Bearer $rest"
    };
    return await http.get(Uri.parse(server+"/api/blog"),headers: auth);
  }

  /// Detail Blog
  Future<http.Response> detail_blog (String? id) async {
    String? rest = "";
    rest = await SessionManager().getToken();
    var auth = {
      "Authorization" : "Bearer $rest"
    };
    return await http.get(Uri.parse(server+"/api/blog/$id"),headers: auth);
  }
}