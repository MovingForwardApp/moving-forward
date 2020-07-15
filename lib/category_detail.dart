import 'package:flutter/material.dart';
import 'theme.dart';

Widget categoryTitle = Container(
    padding: const EdgeInsets.only(top: 50, bottom: 30),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Column(children: [
        Container(
            padding: const EdgeInsets.only(bottom: 20),
            child: Icon(Icons.local_hotel, size: 40, color: Colors.black)),
        Container(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              'Alojamiento de urgencia',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            )),
        Text('Para familias o personas no acompañadas'),
      ])
    ]));

Widget resourceCard = Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    elevation: 10,
    shadowColor: Colors.grey[100],
    child: Container(
        padding: const EdgeInsets.all(25),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
                Container(
                  alignment: Alignment.topRight,
                  child: Icon(Icons.bookmark_border, size: 30.0),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Chip(
                    avatar: const Icon(Icons.directions_walk),
                    backgroundColor: MfColors.primary[100],
                    label: Text('A menos de 500 metros'),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    'APDHA (Asociación Pro Derechos Humanos de Andalucía)',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 10, bottom: 20),
                  child: Text('Información, defensa de derechos')),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: MfColors.gray
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Calle Barbate, 62, 1oC, 11012',
                        style: TextStyle(fontSize: 14)
                      )
                    ),
                  ]
                ),
            ]))));

Widget resourcesList = Expanded(
    child: Container(
      child: Column(children: [
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: MfColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24)
          ),
          border: Border.all(
            color: MfColors.white,
            width: 1,
          ),
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('12 RECURSOS EN BARCELONA'), 
              Text(
                'Cambiar', 
                style: TextStyle(color: MfColors.primary[400],)
              )
            ],
          )
        ),
      Expanded(
        child: Container(
          color: MfColors.white,
          child: ListView(
            scrollDirection: Axis.vertical,
            children: List.generate(10, (index) {
              return Container(
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                child: resourceCard
              );
            })
          )
        )
      )
    ])
));

class CategoryDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color: Color.fromRGBO(225, 239, 255, 1),
          child: Column(
            children: [
              categoryTitle,
              resourcesList,
            ],
          )
        )
    );
  }
}
