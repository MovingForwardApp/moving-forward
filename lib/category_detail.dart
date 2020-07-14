import 'package:flutter/material.dart';

class CategoryDetail extends StatelessWidget {
  final resourceCard = Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 10,
      shadowColor: Colors.grey[100],
      child: Container(
          padding: const EdgeInsets.all(25),
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(
                      'APDHA (Asociación Pro Derechos Humanos de Andalucía)',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text('Información, defensa de derechos')
                  ]))
            ],
          )));

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Icon(Icons.add_circle, size: 40, color: Colors.black),
      Text(
        'Alojamiento de urgencia',
        style:
          TextStyle(
            fontWeight:FontWeight.bold,
            fontSize: 20
          ),
      ),
      Text('Para familias o personas no acompañadas'),
      Expanded(
          child: ListView(
              scrollDirection: Axis.vertical,
              children: List.generate(10, (index) {
                return Container(
                    padding: const EdgeInsets.all(8), child: resourceCard);
              })))
    ]);
  }
}
