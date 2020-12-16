
import 'package:flutter/material.dart';
import 'package:moving_forward/services/localization.dart';
import 'package:moving_forward/location.dart';
import 'package:moving_forward/state/settings.dart';
import 'package:moving_forward/theme.dart';

import 'package:flutter_matomo/flutter_matomo.dart';
import 'package:provider/provider.dart';

class AppLang extends StatelessWidget {
  AppLang({Key key}) : super(key: key) {
    initPage();
  }

  Future<void> initPage() async {
    await FlutterMatomo.trackScreenWithName("Language", "Screen opened");
  }

  FlatButton _languageButton(textLabel, trackText, trackEvent, lang, variant, context) {
    return FlatButton(
      color: MfColors.white,
      textColor: MfColors.dark,
      padding: EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 40.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      onPressed: () async {
        await FlutterMatomo.trackEvent(context, trackText, trackEvent);
        FlutterMatomo.dispatchEvents();
        Provider.of<SettingsState>(context, listen: false).setLanguage(lang, variant);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LocationPage(),
          ),
        );
      },
      child: Text(
        textLabel,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _checkSystemLocale(BuildContext context) {
    Locale _systemLocale = Localizations.localeOf(context);
    var lang = _systemLocale.languageCode;
    var variant = _systemLocale.countryCode;

    List<String> supportedLocales = ['ar', 'fr' ,'en', 'es'];
    List<String> supportedVariants = ['AR', 'FR' ,'US', 'ES'];

    // TODO: Check if user has already chosen a language on localstorage
    // else
    // TODO: Check if user has a default language on its device that matches our default languages
    // else
    // Choose language from change_language screen.

    if (supportedLocales.contains(lang) && supportedVariants.contains(variant))

      Provider.of<SettingsState>(context, listen: false).setLanguage(lang, variant);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LocationPage(),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: null,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Icon(Icons.explore),
              margin: EdgeInsets.only(right: 10),
            ),
            Text(
              'MovingForward',
              style: TextStyle(color: MfColors.white),
            ),
          ],
        ),
        backgroundColor: MfColors.dark,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 100.0),
        color: MfColors.dark,
        child: Column(
          children: <Widget>[
            Text(
              AppLocalizations.of(context).translate('languages'),
              style: TextStyle(
                color: MfColors.white,
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Padding(padding: EdgeInsets.only(top: 60)),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                _languageButton(
                    "العربية. (AR)", "AR button", "Clicked", "ar", "AR", context),
                _languageButton(
                    "Français (FR)", "FR button", "Clicked", "fr", "FR", context),
                _languageButton(
                    "English (US)", "US button", "Clicked", "en", "US", context),
                _languageButton(
                    "Español (ES)", "ES button", "Clicked", "es", "ES", context)
              ],
            )
          ],
        ),
      ),
    );
  }
}