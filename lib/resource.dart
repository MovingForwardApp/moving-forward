import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'theme.dart';

class Resource extends StatelessWidget {
  ListTile _dataRow(IconData icon, String title) {
    return ListTile(
      leading: Icon(
        icon,
        size: 24.0,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14,
        ),
      ),
      dense: true,
    );
  }

  Container _dataSection() {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
        child: Column(
          children: [
            _dataRow(Icons.location_on, 'Calle Barbate, 62, 1oC, 11012'),
            _dataRow(Icons.call, '915 123 456'),
            _dataRow(Icons.access_time, 'L - V de 9:00h a 18:00h'),
            _dataRow(Icons.mail_outline, 'cadiz@apdha.org'),
            _dataRow(Icons.whatshot, '667 123 456'),
            _dataRow(Icons.public, 'apdhacadiz. wordpress.com'),
            _dataRow(Icons.public, 'http://es-la.facebook.com/apdha.cadiz.1'),
          ],
        ));
  }

  Column _actionIcon(IconData icon, String text) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(8.0),
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, 1),
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          child: Icon(
            icon,
            color: Color.fromRGBO(255, 255, 255, 1),
            size: 18.0,
          ),
        ),
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Container _actionSection() {
    return Container(
        color: Color.fromRGBO(219, 235, 230, 1),
        padding: EdgeInsets.all(32.0),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _actionIcon(Icons.call, 'Llamar'),
              _actionIcon(Icons.mail_outline, 'Escribir e-mail'),
              _actionIcon(Icons.public, 'Visitar web'),
              _actionIcon(Icons.bookmark_border, 'Guardar'),
            ]));
  }

  Container _mapSection() {
    return Container(
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
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for the major Material Components.
    return Scaffold(
        body: Center(
            child: ListView(
      shrinkWrap: true,
      children: [
        _mapSection(),
        _titleSection(),
        _actionSection(),
        _dataSection()
      ],
    )));
  }
}
