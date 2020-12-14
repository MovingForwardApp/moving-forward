import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:moving_forward/services/localization.dart';
import 'package:moving_forward/theme.dart';

class Search extends ModalRoute<void> {
  @override
  Duration get transitionDuration => Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => MfColors.white;

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.transparency,
      // make sure that the overlay content is not cut off
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment(1.2, 0.0),
            child: RaisedButton(
              onPressed: () => Navigator.pop(context),
              elevation: 0.0,
              color: MfColors.white,
              child: Text('X',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          ),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              hintText:
                  AppLocalizations.of(context).translate('search_placeholder'),
              border: OutlineInputBorder(),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0),
            child: Text(
              AppLocalizations.of(context).translate('search_hint'),
              style: TextStyle(color: MfColors.dark, fontSize: 14.0),
            ),
            alignment: Alignment(-1.0, 0.0),
          )
        ],
      ),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // You can add your own animations for the overlay content
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}
