import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CategoryList extends StatelessWidget {
  final categoryCard = Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 10,
      shadowColor: Colors.grey[100],
      child: Container(
          padding: const EdgeInsets.all(25),
          child: Row(
            children: <Widget>[
              Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: Icon(Icons.add_circle, size: 40, color: Colors.black)),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(
                      'Categoría',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text('6 recursos')
                  ]))
            ],
          )));

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        child: Text('BUSCA RECURSOS EN LA CATEGORÍAS'),
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      ),
      Expanded(
          child: ListView(
              children: List.generate(10, (index) {
        return Container(
            padding: const EdgeInsets.all(10), child: categoryCard);
      })))
    ]);
  }
}
