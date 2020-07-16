import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:moving_forward/services/location.dart';
import 'package:url_launcher/url_launcher.dart';
import 'theme.dart';
import 'localization.dart';

class Resource extends StatelessWidget {
  ListTile _dataRow(IconData icon, String title, Color color) {
    return ListTile(
      leading: Icon(
        icon,
        size: 24.0,
        color: MfColors.gray,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: color,
        ),
      ),
      dense: true,
    );
  }

  Container _dataSection() {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 10.0),
        child: Column(
          children: [
            _dataRow(Icons.location_on, 'Calle Barbate, 62, 1oC, 11012',
                MfColors.dark),
            _dataRow(Icons.call, '915 123 456', MfColors.dark),
            _dataRow(
                Icons.access_time, 'L - V de 9:00h a 18:00h', MfColors.dark),
            _dataRow(
                Icons.mail_outline, 'cadiz@apdha.org', MfColors.primary[400]),
            _dataRow(Icons.whatshot, '667 123 456', MfColors.dark),
            _dataRow(Icons.public, 'apdhacadiz. wordpress.com',
                MfColors.primary[400]),
            _dataRow(Icons.public, 'http://es-la.facebook.com/apdha.cadiz.1',
                MfColors.primary[400]),
          ],
        ));
  }

  // TODO: remove when real data
  final String phone = 'tel:+0034625528029';
  final String email = 'mailto:hola@xaviju.dev';
  final String url = 'https://github.com/PIWEEK/moving-forward/';

  _executeAction(String action) async {
    if (await canLaunch(action)) {
      await launch(action);
    } else {
      throw 'Could not execute action';
    }
  }

  _save() {
    return null;
  }

  Column _actionIcon(IconData icon, String text, String action) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 8.0),
          decoration: BoxDecoration(
              color: MfColors.dark,
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          child: IconButton(
            color: MfColors.white,
            icon: Icon(icon),
            tooltip: text,
            onPressed: () {
              if (action != 'save') {
                _executeAction(action);
              } else {
                _save();
              }
            },
          ),
        ),
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Container _actionSection(BuildContext context) {
    return Container(
        color: MfColors.primary[100],
        padding: EdgeInsets.all(32.0),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _actionIcon(Icons.call,
                  AppLocalizations.of(context).translate("phone_call"), phone),
              _actionIcon(Icons.mail_outline,
                  AppLocalizations.of(context).translate("send_email"), email),
              _actionIcon(Icons.public,
                  AppLocalizations.of(context).translate("browse_web"), url),
              _actionIcon(Icons.bookmark_border,
                  AppLocalizations.of(context).translate("save"), 'save'),
            ]));
  }

  _launchMap({String lat = "47.6", String long = "-122.3"}) async {
    var mapSchema = 'geo:$lat,$long';
    if (await canLaunch(mapSchema)) {
      await launch(mapSchema);
    } else {
      throw 'Could not launch $mapSchema';
    }
  }

  SizedBox _mapSection() {
    return SizedBox(
        height: 230,
        child: Stack(
          children: <Widget>[
            Container(
                child: FlutterMap(
              options: MapOptions(
                center: LatLng(51.5, -0.09),
                zoom: 13.0,
              ),
              children: <Widget>[
                TileLayerWidget(
                    options: TileLayerOptions(
                        urlTemplate:
                            "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                        subdomains: ['a', 'b', 'c'])),
                MarkerLayerWidget(
                    options: MarkerLayerOptions(
                  markers: [
                    Marker(
                      width: 16.0,
                      height: 22.0,
                      point: LatLng(51.5, -0.09),
                      builder: (ctx) => Container(
                        child: Image(
                          image: AssetImage('assets/marker.png'),
                        ),
                      ),
                    ),
                  ],
                )),
              ],
            )),
            Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.symmetric(horizontal: 60.0),
                child: FlatButton(
                    color: MfColors.dark,
                    textColor: MfColors.white,
                    padding: EdgeInsets.all(8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    onPressed: () {
                      _launchMap(lat: '51.5', long: '-0.09');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.directions_walk,
                          color: MfColors.white,
                          size: 18.0,
                        ),
                        Text(
                          "Ruta a pie",
                          style: TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.bold),
                        ),
                        FutureBuilder<int>(
                            future: LocationService.instance
                                .getDistance(39.426734, -0.361707),
                            builder: (BuildContext context,
                                AsyncSnapshot<int> snapshot) {
                              if (snapshot.data != null) {
                                return Text(
                                  " (menos de ${snapshot.data}m)",
                                  style: TextStyle(fontSize: 14.0),
                                );
                              } else {
                                return Text('...');
                              }
                            }),
                      ],
                    )))
          ],
        ));
  }

  Container _titleSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              'APDHA (Asociación Pro Derechos Humanos de Andalucía)',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: MfColors.dark,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ),
          Text(
            'Información, defensa de derechos.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: MfColors.dark,
              fontWeight: FontWeight.normal,
              fontSize: 16,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 3.0),
                  child: Chip(
                    backgroundColor: Color(0xFFE1EFFF),
                    label: Text(
                      'Jurídico',
                      style: TextStyle(color: MfColors.dark),
                    ),
                  )),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 3.0),
                  child: Chip(
                    backgroundColor: Color(0xFFFEF3DE),
                    label: Text(
                      'LGTBI+',
                      style: TextStyle(color: MfColors.dark),
                    ),
                  )),
            ],
          )
        ],
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      iconTheme: IconThemeData(color: MfColors.dark),
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.search, size: 30, color: MfColors.dark),
          onPressed: () {
            print('SEARCH...');
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for the major Material Components.
    return Scaffold(
        body: Stack(children: <Widget>[
      SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              _mapSection(),
              _titleSection(),
              _actionSection(context),
              _dataSection()
            ],
          ),
        ),
      ),
      Container(
          alignment: Alignment.topCenter,
          child: Container(
            height: 100.0,
            child: _appBar(),
          ))
    ]));
  }
}
