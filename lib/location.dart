import 'package:flutter/material.dart';
import 'package:moving_forward/layout.dart';
import 'package:moving_forward/localization.dart';

import 'package:flutter_matomo/flutter_matomo.dart';

import 'services/location.dart';
import 'theme.dart';

class LocationPage extends StatefulWidget {
  LocationPage({Key key}) : super(key: key) {
    initPage();
  }

  Future<void> initPage() async {
    await FlutterMatomo.trackScreenWithName("Location", "Screen opened");
  }

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
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
          backgroundColor: MfColors.dark),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 100.0),
        color: MfColors.dark,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  AppLocalizations.of(context).translate('location_guess'),
                  style: TextStyle(
                    color: MfColors.white,
                    fontSize: 18.0,
                  ),
                ),
                FutureBuilder<String>(
                    future: LocationService.instance.fetchCurrentLocality(),
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.data != null) {
                        return Text(
                          LocationService.instance.locality,
                          style: TextStyle(
                            color: MfColors.white,
                            fontSize: 32.0,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      } else {
                        return Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    AppLocalizations.of(context).translate('loading_location'),
                                    style: TextStyle(
                                      color: MfColors.white,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: SizedBox(
                                      height: 10,
                                      width: 10,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 1,
                                        valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                                      )
                                    ),
                                  )
                                ]
                            )
                        );
                      }
                    }),
                Container(
                  margin: EdgeInsets.only(top: 40.0),
                  child: Text(
                    AppLocalizations.of(context)
                        .translate('location_guess_error'),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: MfColors.white,
                    ),
                  ),
                ),
              ],
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
                await FlutterMatomo.trackEvent(context,
                    'Location ${LocationService.instance.locality}', 'Clicked');
                FlutterMatomo.dispatchEvents();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AppLayout()),
                );
              },
              child: Text(
                AppLocalizations.of(context).translate('continue'),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
