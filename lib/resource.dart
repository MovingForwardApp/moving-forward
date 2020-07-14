
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';


Widget mapSection = Container(
  child:
  FlutterMap(
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
              builder: (ctx) =>
                  Container(
                    child: FlutterLogo(),
                  ),
            ),
          ],
        ),
      ],
      children: <Widget>[
        TileLayerWidget(
            options: TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c']
            )
        ),
        MarkerLayerWidget(
            options: MarkerLayerOptions(
              markers: [
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: LatLng(51.5, -0.09),
                  builder: (ctx) =>
                  Container(
                    child: FlutterLogo(),
                  ),
                ),
              ],
            )
        ),
      ],
  )
);

Widget titleSection = Container(
  padding: const EdgeInsets.all(32),
  child: Row(
    children: [
      Expanded(
        /*1*/
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /*2*/
            Container(
              child: Text(
                'MZC (Mujeres en Conflicto)',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
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
      /*3*/
      Column(
        children: <Widget>[
          Icon(
            Icons.favorite_border,
            color: Colors.redAccent[500],
          ),
          Text(
            'Guardar',
          ),
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
            titleSection,
            Flexible(
              child: mapSection
            )
          ],
        )
    );
  }
}
