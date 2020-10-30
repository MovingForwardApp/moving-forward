import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {

  static SharedPreferences _sharedPrefs;
  List<String> _bookmarkList;

  init() async {
    if (_sharedPrefs == null) {
      _sharedPrefs = await SharedPreferences.getInstance();
       _bookmarkList = [];
    }
  }

  // get Bookmarks
  List<String> getList(String key) {
    if (_sharedPrefs == null) return null;
    print("getList $key");
    var list = _sharedPrefs.getStringList(key);
    print("getList $list");
    if (list == null) list = List<String>();
    return list;
  }

  putIntoList(String key, String id) {
    if (_sharedPrefs == null) return null;
    _bookmarkList.add(id);
    print("putIntoList $_bookmarkList");
    _sharedPrefs.setStringList(key, _bookmarkList);
  }

  bool contains(String key, String id) {
    if (_sharedPrefs == null) return null;
    return _bookmarkList.contains(id);
  }

  deleteFromList(String key, String id) {
    if (_sharedPrefs == null) return null;
    _bookmarkList.remove(id);
    print("putIntoList $_bookmarkList");
    _sharedPrefs.setStringList(key, _bookmarkList);
  }
}

final sharedPrefs = SharedPrefs();
const String keyBookmark = "saved";

