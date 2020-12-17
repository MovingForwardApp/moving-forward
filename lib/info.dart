import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:moving_forward/state/settings.dart';
import 'package:provider/provider.dart';
import 'about_dialog.dart';
import 'theme.dart';
import 'services/localization.dart';
import 'services/location.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_matomo/flutter_matomo.dart';

enum Answers{ar, fr, en, es}

class Info extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        Text(
          AppLocalizations.of(context).translate('information'),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Divider(),
        Consumer<SettingsState>(
            builder: (context, settings, child) {
              return ListTile(
                onTap: () => _askUser(context),
                leading: Icon(Icons.room, size: 30, color: MfColors.gray),
                title: Text(
                  AppLocalizations.of(context).translate('language'),
                  style: TextStyle(fontSize: 14)
                ),
                subtitle: Text(
                    _getLanguageName(settings.language),
                    style: TextStyle(fontSize: 18, color: MfColors.dark)),
                trailing: Icon(Icons.keyboard_arrow_right),
                dense: true,
              );
            }
        ),

        Divider(),
        ListTile(
          leading: Icon(Icons.language, size: 30, color: MfColors.gray),
          title: Text(
            AppLocalizations.of(context).translate('location'),
            style: TextStyle(fontSize: 14)
          ),
          subtitle: FutureBuilder<String>(
              future: LocationService.instance.fetchCurrentLocality(),
              builder:
                  (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.data != null) {
                  return Text(
                    LocationService.instance.locality,
                    style: TextStyle(fontSize: 18, color: MfColors.dark),
                  );
                } else {
                  return Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: SizedBox(
                                  height: 10,
                                  width: 10,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 1,
                                    valueColor: new AlwaysStoppedAnimation<Color>(MfColors.dark),
                                  )
                              ),
                            ),
                            Text(
                              AppLocalizations.of(context).translate('loading_location'),
                              style: TextStyle(fontSize: 18, color: MfColors.dark),
                            ),
                          ]
                      )
                  );
                }
              }
          ),
          //trailing: Icon(Icons.keyboard_arrow_right), // TODO
          dense: true,
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.info_outline_rounded, size: 30, color: MfColors.gray),
          title: Text(
              AppLocalizations.of(context).translate('about_app'),
              style: TextStyle(fontSize: 14)
          ),
          dense: true,
          onTap: () => showMovingForwardAboutDialog(context),
        ),
        Divider(),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
          child: Text(
            AppLocalizations.of(context).translate('about_mf'),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
          child: Text(
            AppLocalizations.of(context).translate('about_mf_text1'),
            style: TextStyle(fontSize: 16)),
        ),
        Text(
            AppLocalizations.of(context).translate('about_mf_text2'),
            style: TextStyle(fontSize: 16)),
        GestureDetector(
            onTap: () async {
              await FlutterMatomo.trackEvent(
                  context, 'https://www.cear.es/', 'Clicked');
              FlutterMatomo.dispatchEvents();
              launch('https://www.cear.es/');
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Image(
                image: AssetImage('assets/cear.png'),
              ),
            ))
      ],
    )));
  }

  String _getLanguageName(String lang) {
    switch(lang) {
      case 'ar': {
        return 'العربية';
      }
      break;

      case 'fr': {
        return 'Français (FR)';
      }
      break;

      case 'en': {
        return 'English (US)';
      }
      break;

      case 'es': {
        return 'Español (ES)';
      }
      break;

      default: {
        return lang;
      }
      break;
    }
  }



  Future _askUser(BuildContext context) async {
    switch(
    await showDialog(
        context: context,
        child: new SimpleDialog(
          title: new Text(AppLocalizations.of(context).translate('languages')),
          children: <Widget>[
            new SimpleDialogOption(
              child: new Text("العربية. (AR)"),
              onPressed: (){
                Navigator.of(context, rootNavigator: true).pop(Answers.ar);
              },
            ),
            new SimpleDialogOption(
              child: new Text("Français (FR)"),
              onPressed: (){
                Navigator.of(context, rootNavigator: true).pop(Answers.fr);
              },
            ),
            new SimpleDialogOption(
              child: new Text("English (US)"),
              onPressed: (){
                Navigator.of(context, rootNavigator: true).pop(Answers.en);
              },
            ),
            new SimpleDialogOption(
              child: new Text("Español (ES)"),
              onPressed: (){
                Navigator.of(context, rootNavigator: true).pop(Answers.es);
              },
            )
          ],
        )
    )
    ) {
      case Answers.ar:
        await FlutterMatomo.trackEvent(context, "AR lang", "Updated");
        FlutterMatomo.dispatchEvents();
        Provider.of<SettingsState>(context, listen: false).setLanguage('ar', 'AR');
        break;
      case Answers.fr:
        await FlutterMatomo.trackEvent(context, "FR lang", "Updated");
        FlutterMatomo.dispatchEvents();
        Provider.of<SettingsState>(context, listen: false).setLanguage('fr', "FR");
        break;
      case Answers.en:
        await FlutterMatomo.trackEvent(context, "EN lang", "Updated");
        FlutterMatomo.dispatchEvents();
        Provider.of<SettingsState>(context, listen: false).setLanguage('en', "US");
        break;
      case Answers.es:
        await FlutterMatomo.trackEvent(context, "ES lang", "Updated");
        FlutterMatomo.dispatchEvents();
        Provider.of<SettingsState>(context, listen: false).setLanguage('es', "ES");

        break;
    }
    Navigator.popAndPushNamed(context, '/');
  }
}



