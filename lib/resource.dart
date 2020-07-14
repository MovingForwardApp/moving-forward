import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

Widget dataSection = Expanded(
    child: Container(
        padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
        color: Color.fromRGBO(219, 235, 230, 1),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  Icons.location_on,
                  size: 24.0,
                ),
                Expanded(
                  child: Text(
                    'Calle Barbate, 62, 1oC, 11012',
                    style: TextStyle(
                      color: Color.fromRGBO(6, 17, 52, 1),
                      fontSize: 14,
                    ),
                  ),
                )
              ],
            )
          ],
        )
    )
);

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
  child: Expanded(
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
              color: Color.fromRGBO(6, 17, 52, 1),
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
        Text(
          'Información, defensa de derechos.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color.fromRGBO(88, 84, 107, 1),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Row(
          children: <Widget>[
            Chip(
              label: Text(
                'Jurídico',
                style: TextStyle(
                  color: Colors.grey[500],
                ),
              ),
            ),
            Chip(
              label: Text(
                'LGTBI+',
                style: TextStyle(
                  color: Colors.grey[500],
                ),
              ),
            ),
          ],
        )
      ],
    ),
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
        dataSection,
      ],
    ));
  }
}
