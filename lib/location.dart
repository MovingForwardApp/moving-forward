import 'package:flutter/material.dart';
import 'package:moving_forward/layout.dart';
import 'package:moving_forward/localization.dart';

import 'services/location.dart';
import 'theme.dart';

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Icon(Icons.explore),
            Text(
              'MovingForward',
              style: TextStyle(color: MfColors.white),
            ),
          ],
        ),
      ),
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
                  'Parece que estás en',
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
                        return Text(AppLocalizations.of(context)
                            .translate('loading_location'));
                      }
                    }),
                Container(
                  margin: EdgeInsets.only(top: 40.0),
                  child: Text(
                    'Si esto no es correcto o prefieres ver información sobre recursos de otro lugar puedes elegir otra localización',
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AppLayout()),
                );
              },
              child: Text(
                "Continuar",
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
