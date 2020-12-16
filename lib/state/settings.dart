import 'package:flutter/foundation.dart';
import 'package:moving_forward/services/localization.dart';
import 'package:flutter/material.dart';

class SettingsState extends ChangeNotifier {
  String _language = "";
  String _languageVariant = "";

  get language => _language;
  get variant => _languageVariant;

  /// Set default language in app
  void setLanguage(String language, String variant) {
    print(language);
    print(variant);
    _language = language;
    _languageVariant = variant;
    AppLocalizations.load(Locale(_language, _languageVariant));

    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}