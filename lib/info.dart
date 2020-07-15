import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Info extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        Text(
          'Información',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.room, size: 30),
          title: Text('Idioma'),
          subtitle: Text('Español'),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.language, size: 30),
          title: Text('Ubicación'),
          subtitle: Text('28012, Madrid'),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
        Divider(),
        Text('Sobre Moving Forward',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
          child: Text(
              'Moving Forward es una iniciativa impulsada por CEAR (Comisión Española de Ayuda al Refugiado, www.cear.es) con la motivación de hacer más accesibles los recursos sociales a los que tienen derecho las personas migrantes y refugiadas.'),
        ),
        Text(
            'Todo el contenido (recursos de distintos tipos como emergencia, jurídicos, sanitarios, alojamiento y otros) está extraído de las guías oficiales de CEAR.')
      ],
    ));
  }
}
