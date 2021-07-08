
import 'package:shared_preferences/shared_preferences.dart';

class HelperFuncitons{

  static String userLoggedInKey = "userLoggedInKey" ;

  static saveUserLoggedInDetails({bool isLoggedIn})async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool(userLoggedInKey, isLoggedIn);
  }

  static Future<bool> getUserLoggedInDetails()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(userLoggedInKey);
  }
}