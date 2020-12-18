import 'package:flutter/foundation.dart';
import 'package:moving_forward/services/localization.dart';
import 'package:flutter/material.dart';
import 'package:moving_forward/services/storage.dart';

class SettingsState extends ChangeNotifier {
  String _language;
  String _languageVariant;
  SharedPreferencesRepository _storage = SharedPreferencesRepository();

  SettingsState() {
    _initializeData();
  }

  get language => _language;
  get variant => _languageVariant;

  /// Initialize default language from the store
  Future<void> _initializeData() async {
    var data = await _storage.getString("language");

    if (data != null) {
      List<String> langList = data.split('_');

      _language = langList[0];
      _languageVariant = langList[1];

      notifyListeners();
    }
  }

  /// Set default language in app
  void setLanguage(String language, String variant) {
    _language = language;
    _languageVariant = variant;
    AppLocalizations.load(Locale(_language, _languageVariant));
    _persistData();

    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Persist resources list to the store
  Future<void> _persistData() async {
    String currentLang = "${_language}_$_languageVariant";
    await _storage.setString("language", currentLang);
  }
}
