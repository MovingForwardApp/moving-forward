import 'package:flutter/material.dart';
import 'package:moving_forward/services/location.dart';
import 'localization.dart';
import 'theme.dart';
import 'resource.dart';

class CategoryDetail extends StatelessWidget {
  Container _categoryTitle() {
    return Container(
        padding: const EdgeInsets.only(top: 50, bottom: 30),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Column(children: [
            Container(
                padding: const EdgeInsets.only(bottom: 20),
                child: Icon(Icons.local_hotel, size: 55, color: MfColors.dark)),
            Container(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  'Alojamiento de urgencia',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                )),
            Text(
            'Para familias o personas no acompañadas',
              style: TextStyle(fontSize: 16),
            ),
          ])
        ]));
  }

  Card _resourceCard(BuildContext context) {
    return Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        elevation: 6,
        shadowColor: Colors.grey[100],
        child: new InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Resource()));
            },
            child: Container(
                padding: const EdgeInsets.all(25),
                child: Container(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topLeft,
                            child: Chip(
                              avatar: const Icon(Icons.directions_walk),
                              backgroundColor: MfColors.primary[100],
                              label: Text('A menos de 500 metros'),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topRight,
                            child: Icon(Icons.bookmark_border, size: 30.0),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          'APDHA (Asociación Pro Derechos Humanos de Andalucía)',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.only(top: 10, bottom: 20),
                          child: Text('Información, defensa de derechos')),
                      Row(children: [
                        Icon(Icons.location_on, color: MfColors.gray),
                        Container(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text('Calle Barbate, 62, 1oC, 11012',
                                style: TextStyle(fontSize: 14))),
                      ]),
                    ])))));
  }

  Container _resourcesList(BuildContext context) {
    final _resultCategory =
        AppLocalizations.of(context).translate("result_category");
    return Container(
        child: Column(children: [
      Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: MfColors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24), topRight: Radius.circular(24)),
            border: Border.all(
              color: MfColors.white,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(right: 4),
                  child: Text('8 $_resultCategory'),
                ),
                FutureBuilder<String>(
                    future: LocationService.instance.fetchCurrentLocality(),
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.data != null) {
                        return Text(
                            LocationService.instance.locality.toUpperCase());
                      } else {
                        return Text(AppLocalizations.of(context)
                            .translate('loading_location'));
                      }
                    }),
              ]),
              Text(AppLocalizations.of(context).translate("change_category"),
                  style: TextStyle(
                    color: MfColors.primary[400],
                  ))
            ],
          )),
      Container(
          color: MfColors.white,
          child: Column(
              children: List.generate(3, (index) {
            return Container(
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                child: _resourceCard(context));
          })))
    ]));
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
    return Scaffold(
        // appBar: _appBar(),
        body: Stack(children: <Widget>[
      SingleChildScrollView(
          child: Container(
              color: MfColors.blue,
              child: Column(
                children: [
                  _categoryTitle(),
                  _resourcesList(context),
                ],
              ))),
      Container(
          alignment: Alignment.topCenter,
          child: Container(
            height: 100.0,
            child: _appBar(),
          ))
    ]));
  }
}
