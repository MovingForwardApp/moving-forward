import 'package:flutter/material.dart';
import 'package:flutter_matomo/flutter_matomo.dart';
import 'package:moving_forward/layout.dart';
import 'package:moving_forward/services/localization.dart';

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
  Future<String> _currentLocality = LocationService.instance.fetchCurrentLocality();

  void _refreshLocality () {
    setState(() {
      _currentLocality = LocationService.instance.fetchCurrentLocality();
    });
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
          backgroundColor: MfColors.dark
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 100.0),
        color: MfColors.dark,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FutureBuilder<String>(
              future: _currentLocality,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return _buildLoadingIndicator();
                }
                if (snapshot.hasError) {
                  return _buildErrorOnGeolocation(snapshot.error);
                }
                return _buildCurrentLocation();
              }
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

  Widget _buildLocationLayout({@required List<Widget> children}) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            AppLocalizations.of(context).translate('location_guess'),
            style: TextStyle(
              color: MfColors.white,
              fontSize: 18.0,
            ),
          ),
        ] + children
    );
  }

  Widget _buildCurrentLocation() {
    return _buildLocationLayout(
      children: [
        Text(
          LocationService.instance.locality,
          style: TextStyle(
            color: MfColors.white,
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        /* TODO: Uncomment when select other location is implemented
        Container(
          margin: EdgeInsets.only(top: 40.0),

            child: Text(
            AppLocalizations.of(context)
                .translate('location_guess_change_info'),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: MfColors.white,
            ),
          ),
        ),
        */
      ]
    );
  }

  Widget _buildErrorOnGeolocation(String errorKey) {
    return _buildLocationLayout(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 20, bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 5),
                child: Icon(
                  Icons.location_disabled,
                  size: 20,
                  color: MfColors.red
                )
              ),
              Expanded(
                child: Text(
                  AppLocalizations.of(context).translate(errorKey),
                  style: TextStyle(
                    color: MfColors.red,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.clip,
                )
              ),
            ]
          )
        ),
        OutlineButton.icon(
          color: MfColors.white,
          textColor: MfColors.white,
          padding: EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 15.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          borderSide: BorderSide(
            color: MfColors.white,
          ),
          icon: Icon(Icons.autorenew, size: 20, color: MfColors.white),
          label: Text(
            AppLocalizations.of(context).translate('location_guess_refresh_action'),
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () async {
            _refreshLocality();
          }
        )
      ],
    );
  }

  Widget _buildLoadingIndicator() {
    return _buildLocationLayout(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 20, bottom: 15),
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
                        valueColor: AlwaysStoppedAnimation<Color>(MfColors.white),
                      )
                  ),
                ),
                Text(
                  AppLocalizations.of(context).translate('loading_location'),
                  style: TextStyle(
                    color: MfColors.white,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]
          )
        )
      ],
    );
  }
}
