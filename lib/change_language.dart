import 'package:flutter/material.dart';
import 'package:moving_forward/localization.dart';
import 'package:moving_forward/location.dart';
import 'package:moving_forward/theme.dart';

class AppLang extends StatelessWidget {
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
                FlatButton(
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
                    AppLocalizations.load(Locale('ar', 'AR'));
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LocationPage(),
                      ),
                    );
                  },
                  child: Text(
                    'العربية. (AR)',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                FlatButton(
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
                    AppLocalizations.load(Locale('fr', 'FR'));
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LocationPage(),
                      ),
                    );
                  },
                  child: Text(
                    'Français (FR)',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                FlatButton(
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
                    AppLocalizations.load(Locale('en', 'US'));
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LocationPage(),
                      ),
                    );
                  },
                  child: Text(
                    'English (US)',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                FlatButton(
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
                    AppLocalizations.load(Locale('es', 'ES'));
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LocationPage(),
                      ),
                    );
                  },
                  child: Text(
                    'Español (ES)',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
