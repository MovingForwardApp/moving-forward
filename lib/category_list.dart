import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'theme.dart';

import 'category_detail.dart';

class CategoryList extends StatelessWidget {
  Card _categoryCard(BuildContext context) {
    return Card(
      child: new InkWell(
          onTap: () {
            print('tapped');
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CategoryDetail()));
          },
          child: Container(
              padding: const EdgeInsets.all(25),
              child: Row(
                children: <Widget>[
                  Container(
                      margin: const EdgeInsets.only(right: 20),
                      child: Icon(Icons.add_circle,
                          size: 40, color: Colors.black)),
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text(
                          'Categoría',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text('6 recursos')
                      ]))
                ],
              ))),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 10,
      shadowColor: Colors.grey[100],
    );
  }

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
          child: ListView(
              children: List.generate(10, (index) {
        return Container(
            padding: const EdgeInsets.all(10), child: _categoryCard(context));
      })))
    ]);
  }
}
