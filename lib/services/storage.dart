import 'dart:convert';
import "package:shared_preferences/shared_preferences.dart";


abstract class StorageRepositoryInterface {
  // String
  Future<String> getString(String key);
  Future<void> setString(String key, String item);

  // Json
  Future<Map<String, dynamic>> getJson(String key);
  Future<void> setJson(String key, Map<String, dynamic> item);
}


class SharedPreferencesRepository implements StorageRepositoryInterface {
  // String
  @override
  Future<String> getString(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  @override
  Future<void> setString(String key, String item) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, item);
  }

  // Json
  @override
  Future<Map<String, dynamic>> getJson(String key) async {
    String data = await getString(key);
    return jsonDecode(data);
  }

  @override
  Future<void> setJson(String key, Map<String, dynamic> item) async{
    setString(key, jsonEncode(item));
  }
}

