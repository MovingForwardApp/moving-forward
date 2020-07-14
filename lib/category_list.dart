import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CategoryList extends StatelessWidget {
  final resourceCard = Card(
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.add_circle, size: 50, color: Colors.grey),
          Text(
            'Categoría',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text('6 recursos')
        ],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
          scrollDirection: Axis.vertical,
          crossAxisCount: 2,
          children: List.generate(50, (index) {
            return Container(
                padding: const EdgeInsets.all(5), child: resourceCard);
          })),
    );
  }
}
