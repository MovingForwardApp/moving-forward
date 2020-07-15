import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'theme.dart';

Widget dataSection = Expanded(
    child: ListView(
  padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
  children: <Widget>[
    Container(
        margin: EdgeInsets.only(bottom: 18.0),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 20.0),
              child: Icon(
                Icons.location_on,
                size: 24.0,
              ),
            ),
            Expanded(
              child: Text(
                'Calle Barbate, 62, 1oC, 11012',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            )
          ],
        )),
    Container(
        margin: EdgeInsets.only(bottom: 18.0),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 20.0),
              child: Icon(
                Icons.call,
                size: 24.0,
              ),
            ),
            Expanded(
              child: Text(
                '915 123 456',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            )
          ],
        )),
    Container(
        margin: EdgeInsets.only(bottom: 18.0),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 20.0),
              child: Icon(
                Icons.access_time,
                size: 24.0,
              ),
            ),
            Expanded(
              child: Text(
                'L - V de 9:00h a 18:00h',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            )
          ],
        )),
    Container(
        margin: EdgeInsets.only(bottom: 18.0),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 20.0),
              child: Icon(
                Icons.mail_outline,
                size: 24.0,
              ),
            ),
            Expanded(
              child: Text(
                'cadiz@apdha.org',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            )
          ],
        )),
    Container(
        margin: EdgeInsets.only(bottom: 18.0),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 20.0),
              child: Icon(
                Icons.whatshot,
                size: 24.0,
              ),
            ),
            Expanded(
              child: Text(
                '667 123 456',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            )
          ],
        )),
    Container(
        margin: EdgeInsets.only(bottom: 18.0),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 20.0),
              child: Icon(
                Icons.public,
                size: 24.0,
              ),
            ),
            Expanded(
              child: Text(
                'apdhacadiz. wordpress.com',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            )
          ],
        )),
    Container(
        margin: EdgeInsets.only(bottom: 18.0),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 20.0),
              child: Icon(
                Icons.public,
                size: 24.0,
              ),
            ),
            Expanded(
              child: Text(
                'http://es-la.facebook.com/apdha.cadiz.1',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            )
          ],
        ))
  ],
));

Widget actionSection = Container(
    color: Color.fromRGBO(219, 235, 230, 1),
    padding: EdgeInsets.all(32.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Column(children: [
          Container(
            margin: EdgeInsets.only(bottom: 8.0),
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 1),
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            child: Icon(
              Icons.call,
              color: Color.fromRGBO(255, 255, 255, 1),
              size: 18.0,
            ),
          ),
          Text(
            'Llamar',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ]),
        Column(children: [
          Container(
            margin: EdgeInsets.only(bottom: 8.0),
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 1),
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            child: Icon(
              Icons.mail_outline,
              color: Color.fromRGBO(255, 255, 255, 1),
              size: 20.0,
            ),
          ),
          Text(
            'Escribir e-mail',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ]),
        Column(children: [
          Container(
            margin: EdgeInsets.only(bottom: 8.0),
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 1),
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            child: Icon(
              Icons.public,
              color: Color.fromRGBO(255, 255, 255, 1),
              size: 20.0,
            ),
          ),
          Text(
            'Visitar web',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ]),
        Column(children: [
          Container(
            margin: EdgeInsets.only(bottom: 8.0),
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 1),
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            child: Icon(
              Icons.bookmark_border,
              color: Color.fromRGBO(255, 255, 255, 1),
              size: 20.0,
            ),
          ),
          Text(
            'Guardar',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ])
      ],
    ));

Widget mapSection = Container(
    height: 210.0,
    child: FlutterMap(
      options: MapOptions(
        center: LatLng(51.5, -0.09),
        zoom: 13.0,
      ),
      layers: [
        MarkerLayerOptions(
          markers: [
            Marker(
              width: 80.0,
              height: 80.0,
              point: LatLng(51.5, -0.09),
              builder: (ctx) => Container(
                child: FlutterLogo(),
              ),
            ),
          ],
        ),
      ],
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
              width: 80.0,
              height: 80.0,
              point: LatLng(51.5, -0.09),
              builder: (ctx) => Container(
                child: FlutterLogo(),
              ),
            ),
          ],
        )),
      ],
    ));

Widget titleSection = Container(
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
          fontWeight: FontWeight.bold,
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

class Resource extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for the major Material Components.
    return Scaffold(
        body: Column(
      children: [
        mapSection,
        titleSection,
        actionSection,
        dataSection,
      ],
    ));
  }
}
