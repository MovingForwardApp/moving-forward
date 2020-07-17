import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:moving_forward/localization.dart';
import 'package:moving_forward/theme.dart';

class Saved extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: false,
            elevation: 0,
            automaticallyImplyLeading: false,
            leading: null,
            title: Text(
              AppLocalizations.of(context).translate('resources_saved'),
              style: TextStyle(color: MfColors.dark),
            ),
            backgroundColor: Colors.transparent),
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.bookmark_border,
                  color: MfColors.light,
                  size: 60,
                ),
                Text(
                  AppLocalizations.of(context).translate('saved_resource'),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: MfColors.dark),
                ),
              ],
            )));
  }
}
