import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:moving_forward/theme.dart';

import 'package:url_launcher/url_launcher.dart';


void showMovingForwardAboutDialog(BuildContext context) {
  final ThemeData themeData = Theme.of(context);
  final TextStyle aboutTextStyle = themeData.textTheme.bodyText1;
  final TextStyle linkStyle = themeData.textTheme.bodyText1.copyWith(
      color: MfColors.primary);

  showAboutDialog(
    context: context,
    applicationIcon: Image(
      image: AssetImage("assets/foreground.png"),
      height: 48,
      width: 48,
    ),
    applicationName: 'Moving Forward',
    applicationVersion: '1.0.0',
    applicationLegalese: '© 2020 CEAR & Kaleidos',
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                style: aboutTextStyle,
                text:
                'MovingFordware es un proyecto open-source desarrollado en las XVIII y XIX ediciones de la ',
              ),
              LinkTextSpan(
                style: linkStyle,
                url: 'https://piweek.com',
                text: 'PiWeek',
              ),
              TextSpan(
                style: aboutTextStyle,
                text: ' de ',
              ),
              LinkTextSpan(
                style: linkStyle,
                url: 'https://kaleidos.net',
                text: 'Kaleidos',
              ),
              TextSpan(
                style: aboutTextStyle,
                text: '. \n\nDetrás de Moving Forward se encuentra un equipo de personas pertenecientes a ',
              ),
              LinkTextSpan(
                style: linkStyle,
                url: 'https://www.cear.es/',
                text: 'CEAR',
              ),
              TextSpan(
                style: aboutTextStyle,
                text: ' y ',
              ),
              LinkTextSpan(
                style: linkStyle,
                url: 'https://kaleidos.net',
                text: 'Kaleidos',
              ),
              TextSpan(
                style: aboutTextStyle,
                text: ":  Xavi, Andrés, María, Tere, Sara, Dani, David, Bárbara, Carolina y Marta. "
                      "Además de muchas otras personas que han colaborado con su tiempo en la tradución y "
                      "el testeo por lo que les estamos muy agradecidos."
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

class LinkTextSpan extends TextSpan {

  // Beware!
  //
  // This class is only safe because the TapGestureRecognizer is not
  // given a deadline and therefore never allocates any resources.
  //
  // In any other situation -- setting a deadline, using any of the less trivial
  // recognizers, etc -- you would have to manage the gesture recognizer's
  // lifetime and call dispose() when the TextSpan was no longer being rendered.
  //
  // Since TextSpan itself is @immutable, this means that you would have to
  // manage the recognizer from outside the TextSpan, e.g. in the State of a
  // stateful widget that then hands the recognizer to the TextSpan.

  LinkTextSpan({ TextStyle style, String url, String text }) : super(
      style: style,
      text: text ?? url,
      recognizer: TapGestureRecognizer()..onTap = () {
        launch(url, forceSafariVC: false);
      }
  );
}
