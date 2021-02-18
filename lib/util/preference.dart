import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtil{

  static put( String name, String value ) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(name, value);
  }

  static Future<String> get( String name ) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(name);
  }

}