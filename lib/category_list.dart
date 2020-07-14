import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CategoryList extends StatelessWidget {
  final resourceCard = Card(
      child: Container(
          padding: const EdgeInsets.all(20),
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
    return Container(
      child: ListView(
          scrollDirection: Axis.vertical,
          children: List.generate(50, (index) {
            return Container(
                padding: const EdgeInsets.all(5), child: resourceCard);
          })),
    );
  }
}
