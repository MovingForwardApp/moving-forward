import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:moving_forward/services/localization.dart';
import 'package:moving_forward/models/category.dart';
import 'package:moving_forward/models/resource.dart';
import 'package:moving_forward/services/db.dart';
import 'package:moving_forward/services/location.dart';
import 'package:moving_forward/theme.dart';
import 'package:moving_forward/utils.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_matomo/flutter_matomo.dart';

class ResourceDetailPage extends StatelessWidget {
  ResourceDetailPage(
      {Key key, @required this.category, @required this.resource})
      : super(key: key);

  final Resource resource;
  final Category category;
  final _db = DBService.instance;

  Future<void> initPage() async {
    await FlutterMatomo.trackScreenWithName(
        "ResourceDetail - ${category.name}/${resource.name} ", "Screen opened");
  }

  _displayIcon(int resourceId) {
    // String resource = resourceId.toString();
    // return _savedResources.contains(resource) ? Icons.bookmark : Icons.bookmark_border_outlined;
    print('_displayIcon');
  }

  _toggleResource(int resourceId) {
    // String resource = resourceId.toString();
    // _getSavedBookmarks();
    print('_toggleResource');
  }

  // _getSavedBookmarks () {
  //   // List resources = sharedPrefs.getList('saved');
  //   // _savedResourcesList(resources);
  //   print('_getSavedBookmarks');
  // }

  _launchMap({double lat = 47.6, double long = -122.3}) async {
    var mapSchema = 'geo:$lat,$long';
    if (await canLaunch(mapSchema)) {
      await launch(mapSchema);
    } else {
      throw 'Could not launch $mapSchema';
    }
  }

  _executeAction(String action) async {
    if (await canLaunch(action)) {
      await launch(action);
    } else {
      throw 'Could not execute action';
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
                    _mapSection(),
                  _titleSection(),
                  _actionSection(context),
                  _dataSection()
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

  SizedBox _mapSection() {
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
                    urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
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
                _launchMap(lat: resource.lat, long: resource.long);
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
          if (resource.phone != '')
            _actionIcon(
              Icons.call,
              AppLocalizations.of(context).translate("phone_call"),
              'tel:${resource.phone}',
            ),
          if (resource.email != '')
            _actionIcon(
              Icons.mail_outline,
              AppLocalizations.of(context).translate("send_email"),
              'mailto:${resource.email}',
            ),
          if (resource.web != '')
            _actionIcon(
              Icons.public,
              AppLocalizations.of(context).translate("browse_web"),
              resource.web,
            ),
          if (resource.id != null)
            _actionIcon(_displayIcon(resource.id),
                AppLocalizations.of(context).translate("save"), 'save'),
        ],
      ),
    );
  }

  Column _actionIcon(
    IconData icon,
    String text,
    String action,
  ) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 8.0),
          decoration: BoxDecoration(
            color: MfColors.dark,
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
              if (action != 'save') {
                _executeAction(action);
              } else {
                _toggleResource(resource.id);
              }
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

  Container _dataSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 10.0),
      child: Column(
        children: [
          if (resource.address != '')
            _dataRow(
              Icons.location_on,
              resource.address,
              MfColors.dark,
            ),
          if (resource.phone != '')
            _dataRow(
              Icons.call,
              resource.phone,
              MfColors.dark,
            ),
          _dataRow(
            Icons.access_time,
            'L - V de 9:00h a 18:00h',
            MfColors.dark,
          ),
          if (resource.email != '')
            _dataRow(
              Icons.mail_outline,
              resource.email,
              MfColors.primary[400],
            ),
          if (resource.phone != '')
            _dataRow(
              Icons.whatshot,
              resource.phone,
              MfColors.dark,
            ),
          if (resource.web != '')
            _dataRow(
              Icons.public,
              resource.web,
              MfColors.primary[400],
            ),
        ],
      ),
    );
  }

  ListTile _dataRow(IconData icon, String title, Color color) {
    return ListTile(
      leading: Icon(
        icon,
        size: 24.0,
        color: MfColors.gray,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: color,
        ),
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
