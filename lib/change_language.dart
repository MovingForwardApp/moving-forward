import 'package:flutter/material.dart';
import 'package:moving_forward/localization.dart';
import 'package:moving_forward/location.dart';
import 'package:moving_forward/theme.dart';

import 'package:flutter_matomo/flutter_matomo.dart';

class AppLang extends StatelessWidget {
  AppLang({Key key}) : super(key: key) {
    initPage();
  }

  Future<void> initPage() async {
    await FlutterMatomo.trackScreenWithName("Language", "Screen opened");
  }

  FlatButton _languageButton(textLabel, trackText, trackEvent, lang, context) {
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
        AppLocalizations.load(Locale(lang, lang.toUpperCase()));
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
            ),
            Padding(padding: EdgeInsets.only(top: 60)),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                _languageButton(
                    "العربية. (AR)", "AR button", "Clicked", "ar", context),
                _languageButton(
                    "Français (FR)", "FR button", "Clicked", "fr", context),
                _languageButton(
                    "English (US)", "US button", "Clicked", "en", context),
                _languageButton(
                    "Español (ES)", "ES button", "Clicked", "es", context)
              ],
            )
          ],
        ),
      ),
    );
  }
}
