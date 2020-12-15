import 'package:flutter/foundation.dart';
import 'dart:collection';
import 'package:moving_forward/services/storage.dart';

class FavoritesState extends ChangeNotifier {
  SharedPreferencesRepository _storage = SharedPreferencesRepository();

  /// Internal, private state of the resources list.
  final List<int> _resources = [];

  UnmodifiableListView<int> get resources => UnmodifiableListView(_resources);

  FavoritesState() {
    _initializeData();
  }

  /// Initialize resources list from the store
  Future<void> _initializeData() async {
    var data = await _storage.getJson("favorites");

    if (data != null) {
      var storeResources = data["resources"].cast<int>() as List<int>;

      _resources.clear();
      _resources.addAll(storeResources);

      notifyListeners();
    }
  }

  /// Persist resources list to the store
  Future<void> _persistData() async {
    await _storage.setJson("favorites", {
      "resources": _resources
    });
  }

  /// Checks if [resource] exists in list  .
  bool isFavorite(int id) {
    return _resources.contains(id);
  }

  /// Adds [resource] to resources list.
  void add(int id) {
    _resources.add(id);
    _persistData();

    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Removes [resource] to resources list.
  void remove(int id) {
    _resources.remove(id);
    _persistData();

    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Removes all [resources] from the resources list.
  void removeAll() {
    _resources.clear();
    _persistData();

    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
