import 'package:flutter/foundation.dart';
import '../models/resource.dart';
import 'dart:collection';

class FavoritesState extends ChangeNotifier {
  /// Internal, private state of the resources list.
  final List<Resource> _resources = [];

  UnmodifiableListView<Resource> get resources => UnmodifiableListView(_resources);

  /// Checks if [resource] exists in ist  .
  bool contains(Resource resource) {
    return _resources.contains(resource);
  }

  /// Adds [resource] to resources list.
  void add(Resource resource) {
    _resources.add(resource);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Removes [resource] to resources list.
  void remove(Resource resource) {
    _resources.remove(resource);
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
