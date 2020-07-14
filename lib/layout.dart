import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'category_list.dart';
import 'home.dart';
import 'info.dart';

class Destination {
  Destination(this.title, this.icon, this.color, this.component);
  final String title;
  final IconData icon;
  final MaterialColor color;
  final Widget component;
}

List<Destination> allDestinations = <Destination>[
  Destination('Guardados', Icons.bookmark, Colors.cyan, Home()),
  Destination('Inicio', Icons.home, Colors.teal, CategoryList()),
  Destination('Información', Icons.info_outline, Colors.orange, Info())
];

class DestinationView extends StatefulWidget {
  const DestinationView({Key key, this.destination}) : super(key: key);

  final Destination destination;

  @override
  _DestinationViewState createState() => _DestinationViewState();
}

class _DestinationViewState extends State<DestinationView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.destination.title} Text',
            style: TextStyle(color: Color.fromRGBO(6, 17, 52, 1))),
        backgroundColor: widget.destination.color[50],
      ),
      body: Container(
        padding: const EdgeInsets.all(5),
        alignment: Alignment.center,
        child: widget.destination.component,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class LayoutPage extends StatefulWidget {
  @override
  _LayoutPageState createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage>
    with TickerProviderStateMixin<LayoutPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: IndexedStack(
          index: _currentIndex,
          children: allDestinations.map<Widget>((Destination destination) {
            return DestinationView(destination: destination);
          }).toList(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        elevation: 10,
        iconSize: 30,
        unselectedItemColor: Color.fromRGBO(6, 17, 52, 1),
        selectedItemColor: Color.fromRGBO(24, 172, 145, 1),
        items: allDestinations.map((Destination destination) {
          return BottomNavigationBarItem(
              icon: Icon(destination.icon),
              backgroundColor: destination.color,
              title: Text(
                destination.title,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ));
        }).toList(),
      ),
    );
  }
}
