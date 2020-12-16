import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:moving_forward/services/localization.dart';
import 'package:moving_forward/models/category.dart';
import 'package:moving_forward/models/resource.dart';
import 'package:moving_forward/services/db.dart';
import 'package:moving_forward/services/location.dart';
import 'package:moving_forward/state/favorites.dart';
import 'package:moving_forward/theme.dart';
import 'package:moving_forward/utils.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_matomo/flutter_matomo.dart';

class ResourceDetailPage extends StatelessWidget {
  ResourceDetailPage({Key key, @required this.resource}) : super(key: key);

  final Resource resource;
  final _db = DBService.instance;

  _launchMap({String googlemapUrl}) async {
    if (await canLaunch(googlemapUrl)) {
      await launch(googlemapUrl);
    } else {
      throw 'Could not launch $googlemapUrl';
    }
  }

  _executeAction(String action, BuildContext context, Resource resource) async {
    if (action == 'save') {
      Provider.of<FavoritesState>(context, listen: false).add(resource.id);
    } else if (action == 'remove') {
      Provider.of<FavoritesState>(context, listen: false).remove(resource.id);
    } else {
      if (await canLaunch(action)) {
        await launch(action);
      } else {
        throw 'Could not execute action';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  if (resource.lat != null && resource.long != null)
                    _mapSection(context),
                  _titleSection(),
                  _actionSection(context),
                  _dataSection(context)
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            child: Container(
              height: 100.0,
              child: _appBar(),
            ),
          )
        ],
      ),
    );
  }

  SizedBox _mapSection(BuildContext context) {
    return SizedBox(
      height: 230,
      child: Stack(
        children: <Widget>[
          Container(
            child: FlutterMap(
              options: MapOptions(
                center: LatLng(resource.lat, resource.long),
                zoom: 15.0,
              ),
              children: <Widget>[
                TileLayerWidget(
                  options: TileLayerOptions(
                    /* OpenStreetMap Tile */
                    urlTemplate:
                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c'],
                  ),
                ),
                MarkerLayerWidget(
                  options: MarkerLayerOptions(
                    markers: [
                      Marker(
                        width: 16.0,
                        height: 22.0,
                        point: LatLng(resource.lat, resource.long),
                        builder: (ctx) => Container(
                          child: Image(
                            image: AssetImage('assets/marker.png'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.symmetric(horizontal: 60.0),
            child: FlatButton(
              color: MfColors.dark,
              textColor: MfColors.white,
              padding: EdgeInsets.all(8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              onPressed: () async {
                await FlutterMatomo.trackEventWithName(
                    'ResourceDetail', 'launchMap', 'Clicked');
                FlutterMatomo.dispatchEvents();
                _launchMap(googlemapUrl: resource.googlemapUrl);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context).translate('route'),
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  FutureBuilder<int>(
                      future: LocationService.instance
                          .getDistance(resource.lat, resource.long),
                      builder:
                          (BuildContext context, AsyncSnapshot<int> snapshot) {
                        if (snapshot.data != null) {
                          return Text(
                            " (${AppLocalizations.of(context).translate('resource_distance')} ${getFormatedDistance(snapshot.data)})"
                                .toLowerCase(),
                            style: TextStyle(fontSize: 14.0),
                          );
                        } else {
                          return Text('...');
                        }
                      }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _titleSection() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              resource.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: MfColors.dark,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ),
          Text(
            resource.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: MfColors.dark,
              fontWeight: FontWeight.normal,
              fontSize: 16,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
            child: FutureBuilder<List<Category>>(
                future: _db.listCategoriesByResource(resource.id,
                    lang: AppLocalizations.locale.languageCode),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Category>> snapshot) {
                  if (snapshot.data != null) {
                    List<Category> categories = snapshot.data;
                    return Wrap(
                        spacing: 4.0, // gap between adjacent chips
                        runSpacing: 0.0, // gap between lines
                        alignment: WrapAlignment.center,
                        runAlignment: WrapAlignment.center,
                        children: categories
                            .map((Category category) => Chip(
                                  backgroundColor:
                                      Color(int.parse(category.color)),
                                  label: Text(
                                    category.name,
                                    style: TextStyle(color: MfColors.dark),
                                  ),
                                ))
                            .toList());
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
          ),
        ],
      ),
    );
  }

  Container _actionSection(BuildContext context) {
    return Container(
      color: MfColors.primary[100],
      padding: EdgeInsets.all(32.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          if (resource.mainPhone != '')
            _actionIcon(
                Icons.call,
                AppLocalizations.of(context).translate("phone_call"),
                'tel:${resource.mainPhone}',
                context),
          if (resource.mainEmail != '')
            _actionIcon(
                Icons.mail_outline,
                AppLocalizations.of(context).translate("send_email"),
                'mailto:${resource.mainEmail}',
                context),
          if (resource.mainWeb != '')
            _actionIcon(
                Icons.public,
                AppLocalizations.of(context).translate("browse_web"),
                resource.mainWeb,
                context),
          if (resource.id != null) _favoritesIcon(resource),
        ],
      ),
    );
  }

  Consumer _favoritesIcon(Resource resource) {
    return Consumer<FavoritesState>(builder: (context, favorites, child) {
      if (favorites.isFavorite(resource.id)) {
        return _actionIcon(Icons.bookmark_border_outlined,
            AppLocalizations.of(context).translate("Saved"), 'remove', context);
      } else {
        return _actionIcon(Icons.bookmark_border_outlined,
            AppLocalizations.of(context).translate("save"), 'save', context);
      }
    });
  }

  Column _actionIcon(
      IconData icon, String text, String action, BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 8.0),
          decoration: BoxDecoration(
            color: action == 'remove' ? MfColors.primary : MfColors.dark,
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          child: IconButton(
            color: MfColors.white,
            icon: Icon(icon),
            tooltip: text,
            onPressed: () async {
              await FlutterMatomo.trackEventWithName(
                  'ResourcesDetail', action, 'Clicked');
              FlutterMatomo.dispatchEvents();
              _executeAction(action, context, resource);
            },
          ),
        ),
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Container _dataSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 10.0),
      child: Column(
        children: [
          if (resource.address != '' && resource.googlemapUrl != '')
            _dataMap(Icons.location_on, resource.address),
          if (resource.mainPhone != '')
            for (var phone in resource.phone)
              _dataRow(Icons.call, phone, 'tel:', context),
          if (resource.mainEmail != '')
            for (var email in resource.email)
              _dataRow(Icons.mail_outline, email, 'mailto:', context),
          if (resource.mainWeb != '')
            for (var web in resource.web)
              _dataRow(Icons.public, web, '', context),
        ],
      ),
    );
  }

  ListTile _dataMap(IconData icon, String text) {
    return ListTile(
      leading: Icon(
        icon,
        size: 24.0,
        color: MfColors.gray,
      ),
      title: GestureDetector(
        onTap: () async {
          await FlutterMatomo.trackEventWithName(
              'ResourceDetail', 'launchMap', 'Clicked');
          FlutterMatomo.dispatchEvents();
          _launchMap(googlemapUrl: resource.googlemapUrl);
        },
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: MfColors.primary[400],
          ),
        ),
      ),
      dense: true,
    );
  }

  ListTile _dataRow(
      IconData icon, String text, String action, BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        size: 24.0,
        color: MfColors.gray,
      ),
      title: Row(
        children: [
          Expanded(
              child: GestureDetector(
            onTap: () async {
              await FlutterMatomo.trackEventWithName(
                  'ResourcesDetail', action + text, 'Clicked');
              FlutterMatomo.dispatchEvents();
              _executeAction(action + text, context, resource);
            },
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                color: MfColors.primary[400],
              ),
            ),
          ))
        ],
      ),
      dense: true,
    );
  }

  AppBar _appBar() {
    return AppBar(
      iconTheme: IconThemeData(color: MfColors.dark),
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.share, size: 30, color: MfColors.dark),
          onPressed: () async {
            await FlutterMatomo.trackEventWithName(
                'ResouceDetail', 'Share', 'Clicked');
            FlutterMatomo.dispatchEvents();
            Share.share(
                '${resource.name} ${resource.description}, ${resource.address}, ${resource.googlemapUrl}');
          },
        )
      ],
    );
  }
}
