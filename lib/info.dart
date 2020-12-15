import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:moving_forward/state/settings.dart';
import 'package:provider/provider.dart';
import 'theme.dart';
import 'services/localization.dart';
import 'services/location.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_matomo/flutter_matomo.dart';

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
                leading: Icon(Icons.room, size: 30, color: MfColors.gray),
                title: Text(
                  AppLocalizations.of(context).translate('language'),
                  style: TextStyle(fontSize: 14)
                ),
                subtitle: Text(
                    _getLanguageName(settings.language),
                    style: TextStyle(fontSize: 18, color: MfColors.dark)),
                trailing: Icon(Icons.keyboard_arrow_right), // TODO
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
}