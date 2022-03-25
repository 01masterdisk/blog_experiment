import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  final String TOKEN = "TkxmanAKLSlm12.?s@923";
  final String USERNAME = "DLLKSKJNJSd4123!@#.?s@923";


  /////// SAVE AND GET TOKEN //////////////
  void setToken(dynamic value) async {
      var pref = await SharedPreferences.getInstance();
      await pref.setString(TOKEN, value["token"]);
      await pref.setString(USERNAME, value["user"]["name"]);
  }
  Future<String?> getToken() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(TOKEN);
  }

  Future<String?> getUsername() async {
    var pref = await SharedPreferences.getInstance();
   return pref.getString(USERNAME);
  }
  void logout() async{
    var pref = await SharedPreferences.getInstance();
    await pref.clear();
  }
}

