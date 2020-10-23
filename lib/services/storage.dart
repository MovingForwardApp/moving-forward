import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {

  static SharedPreferences _sharedPrefs;

  init() async {
    if (_sharedPrefs == null) {
      _sharedPrefs = await SharedPreferences.getInstance();
    }
  }

  // get Bookmarks
  List<String> getList(String key) {
    if (_sharedPrefs == null) return null;
    return _sharedPrefs.getStringList(key) ?? List<String>();
  }

  putIntoList(String key, String id) {
    if (_sharedPrefs == null) return null;
    var list = getList(key);
    print(list);
    list.add(id);
  }

  bool contains(String key, String id) {
    if (_sharedPrefs == null) return null;
    var list = getList(key);
    return list.contains(id);
  }

  deleteFromList(String key, String id) {
    if (_sharedPrefs == null) return null;
    var list = getList(key);
    list.remove(id);
  }
}

final sharedPrefs = SharedPrefs();
const String keyBookmark = "saved";

