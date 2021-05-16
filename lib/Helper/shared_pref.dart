import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static String sharedPreferenceUserLoggedInKey = "ISLOGGEDINKEY";
  static String sharedPreferenceUsernameKey = "USERNAMEKEY";
  static String sharedPreferenceUseremailkey = "USEREMAILKEY";

  //SAVE THE DATA TO SHAREDPRFERENCE

  //this function will save the user who is already login
  static Future<bool> saveLoggedInUserSharedPref(bool isLoggedIn) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(
        sharedPreferenceUserLoggedInKey, isLoggedIn);
  }

  //this function will save the username
  static Future<bool> saveUsernameSharedPref(String username) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceUsernameKey, username);
  }

  //this function will save the user emailID
  static Future<bool> saveUseremailSharedPref(String email) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceUseremailkey, email);
  }

  //GET THE DATA FROM SHAREDPREFERENCE

  static Future<bool> getLoggedInUserSharedPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getBool(sharedPreferenceUserLoggedInKey);
  }

  static Future<String> getUsernameSharedPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceUsernameKey);
  }

  static Future<String> getemailSharedPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceUseremailkey);
  }
}
