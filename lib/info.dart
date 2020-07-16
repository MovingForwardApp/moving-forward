import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'theme.dart';
import 'package:url_launcher/url_launcher.dart';

class Info extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        Text(
          'Información',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.room, size: 30, color: MfColors.gray),
          title: Text('Idioma', style: TextStyle(fontSize: 14)),
          subtitle: Text('Español', style: TextStyle(fontSize: 18, color: MfColors.dark)),
          trailing: Icon(Icons.keyboard_arrow_right),
          dense: true,
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.language, size: 30, color: MfColors.gray),
          title: Text('Ubicación', style: TextStyle(fontSize: 14)),
          subtitle: Text('28012, Madrid', style: TextStyle(fontSize: 18, color: MfColors.dark)),
          trailing: Icon(Icons.keyboard_arrow_right),
          dense: true,
        ),
        Divider(),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
          child: Text('Sobre Moving Forward',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
          child: Text(
              'Moving Forward es una iniciativa impulsada por CEAR (Comisión Española de Ayuda al Refugiado, www.cear.es) con la motivación de hacer más accesibles los recursos sociales a los que tienen derecho las personas migrantes y refugiadas.', style: TextStyle(fontSize: 16)),
        ),
        Text(
            'Todo el contenido (recursos de distintos tipos como emergencia, jurídicos, sanitarios, alojamiento y otros) está extraído de las guías oficiales de CEAR.', style: TextStyle(fontSize: 16)),
        GestureDetector(
            onTap: () {
              launch('https://www.cear.es/');
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Image(
                image: AssetImage('assets/cear.jpg'),
              ),
            ))
      ],
    )));
  }
}
