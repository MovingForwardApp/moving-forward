import 'package:flutter/foundation.dart';
import 'package:moving_forward/services/localization.dart';
import 'package:flutter/material.dart';

class SettingsState extends ChangeNotifier {
  String _language = "";

  get language => _language;

  /// Set default language in app
  void setLanguage(String language) {
    print(language);
    _language = language;
    AppLocalizations.load(Locale(language, language.toUpperCase()));

    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}