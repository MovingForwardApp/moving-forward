import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'theme.dart';

import 'category_detail.dart';

class CategoryList extends StatelessWidget {
  Card _categoryCard(BuildContext context, int id, String title,
      String description, IconData icon, Color color) {
    return Card(
      child: new InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CategoryDetail()));
          },
          child: Container(
              padding: const EdgeInsets.all(25),
              child: Row(
                children: <Widget>[
                  Container(
                      padding: const EdgeInsets.all(10),
                      color: color,
                      margin: const EdgeInsets.only(right: 20),
                      child: Icon(icon, size: 40, color: Colors.black)),
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text(
                          title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(description)
                      ]))
                ],
              ))),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 10,
      shadowColor: Colors.grey[100],
    );
  }

  final List<Map<String, Object>> _categoryList = [
    {
      'id': 0,
      'title': 'Información general',
      'description': 'Asilo, extranjería, derechos',
      'icon': Icons.info_outline,
      'color': MfColors.yellow
    },
    {
      'id': 1,
      'title': 'Alojamiento de urgencia',
      'description': 'Sólo o en familia',
      'icon': Icons.local_hotel,
      'color': MfColors.blue
    },
    {
      'id': 2,
      'title': 'Violencia contra la mujer',
      'description': 'Urgencias, prostitución, violencia',
      'icon': Icons.report_problem,
      'color': MfColors.red
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        color: MfColors.primary[100],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Encuentra tu ayuda',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
            ),
            Text('Busca recursos sociales gratuitos.')
          ],
        ),
      ),
      Container(
        child: Text('BUSCA RECURSOS EN LA CATEGORÍAS'),
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      ),
      Expanded(
          child: ListView(children: [
        Container(
            padding: const EdgeInsets.all(10),
            child: _categoryCard(
                context,
                _categoryList[0]['id'],
                _categoryList[0]['title'],
                _categoryList[0]['description'],
                _categoryList[0]['icon'],
                _categoryList[0]['color'])),
        Container(
            padding: const EdgeInsets.all(10),
            child: _categoryCard(
                context,
                _categoryList[1]['id'],
                _categoryList[1]['title'],
                _categoryList[1]['description'],
                _categoryList[1]['icon'],
                _categoryList[1]['color'])),
        Container(
            padding: const EdgeInsets.all(10),
            child: _categoryCard(
                context,
                _categoryList[2]['id'],
                _categoryList[2]['title'],
                _categoryList[2]['description'],
                _categoryList[2]['icon'],
                _categoryList[2]['color']))
      ]))
    ]);
  }
}
