import 'package:flutter/foundation.dart';
import '../models/resource.dart';
import 'dart:collection';

class FavoritesState extends ChangeNotifier {
  /// Internal, private state of the resources list.
  final List<int> _resources = [];

  UnmodifiableListView<int> get resources => UnmodifiableListView(_resources);

  /// Checks if [resource] exists in list  .
  bool isFavorite(int id) {
    print(_resources);
    print(id);
    return _resources.contains(id);
  }

  /// Adds [resource] to resources list.
  void add(int id) {
    _resources.add(id);

    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Removes [resource] to resources list.
  void remove(int id) {
    _resources.remove(id);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Removes all [resources] from the resources list.
  void removeAll() {
    _resources.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
