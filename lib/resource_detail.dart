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
import 'services/storage.dart';

class ResourceDetailPage extends StatefulWidget {
  final Resource resource;
  final Category category;

  ResourceDetailPage(
      {Key key, @required this.category, @required this.resource})
      : super(key: key);

  @override
  _ResourceDetailState createState() => _ResourceDetailState();
}

class _ResourceDetailState extends State<ResourceDetailPage> {
  final _db = DBService.instance;
  List<String> _savedResources;

  _savedResourcesList(List resources) {
    setState(() {
      _savedResources = resources;
    });
  }

  Future<void> initPage() async {
    await FlutterMatomo.trackScreenWithName(
        "ResourceDetail - ${widget.category.name}/${widget.resource.name} ",
        "Screen opened");
  }

  _displayIcon(int resourceId) {
    String resource = resourceId.toString();
    return _savedResources.contains(resource)
        ? Icons.bookmark
        : Icons.bookmark_border_outlined;
  }

  _toggleResource(int resourceId) {
    String resource = resourceId.toString();
    var isBookmarked = sharedPrefs.contains('saved', resource);
    if (isBookmarked == false) {
      sharedPrefs.putIntoList('saved', resource);
    } else {
      sharedPrefs.deleteFromList('saved', resource);
    }
    _getSavedBookmarks();
  }

  _getSavedBookmarks() {
    List resources = sharedPrefs.getList('saved');
    _savedResourcesList(resources);
  }

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
  void initState() {
    super.initState();
    _getSavedBookmarks();
    initPage();
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
                  if (widget.resource.lat != null &&
                      widget.resource.long != null)
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
                center: LatLng(widget.resource.lat, widget.resource.long),
                zoom: 15.0,
              ),
              children: <Widget>[
                TileLayerWidget(
                  options: TileLayerOptions(
                    /* OpenStreetMap Tile */
                    /*
                    urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c'],
                    */
                    /* MapBox Tile */
                    urlTemplate:
                        "https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
                    additionalOptions: {
                      "accessToken":
                          "pk.eyJ1IjoiYmFtZWRhIiwiYSI6ImNrNDl2OGh4cjA4dzMzc3A4c2Q2N25wenUifQ.-9r_WubwqOJqqVl1sZdjtg",
                      "id": "mapbox.streets",
                    },
                  ),
                ),
                MarkerLayerWidget(
                  options: MarkerLayerOptions(
                    markers: [
                      Marker(
                        width: 16.0,
                        height: 22.0,
                        point:
                            LatLng(widget.resource.lat, widget.resource.long),
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
                _launchMap(
                    lat: widget.resource.lat, long: widget.resource.long);
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
                      future: LocationService.instance.getDistance(
                          widget.resource.lat, widget.resource.long),
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
              widget.resource.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: MfColors.dark,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ),
          Text(
            widget.resource.description,
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
                future: _db.listCategoriesByResource(widget.resource.id,
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
          if (widget.resource.phone != '')
            _actionIcon(
              Icons.call,
              AppLocalizations.of(context).translate("phone_call"),
              'tel:${widget.resource.phone}',
            ),
          if (widget.resource.email != '')
            _actionIcon(
              Icons.mail_outline,
              AppLocalizations.of(context).translate("send_email"),
              'mailto:${widget.resource.email}',
            ),
          if (widget.resource.web != '')
            _actionIcon(
              Icons.public,
              AppLocalizations.of(context).translate("browse_web"),
              widget.resource.web,
            ),
          if (widget.resource.id != null)
            _actionIcon(_displayIcon(widget.resource.id),
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
                _toggleResource(widget.resource.id);
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
          if (widget.resource.address != '')
            _dataRow(
              Icons.location_on,
              widget.resource.address,
              MfColors.dark,
            ),
          if (widget.resource.phone != '')
            _dataRow(
              Icons.call,
              widget.resource.phone,
              MfColors.dark,
            ),
          _dataRow(
            Icons.access_time,
            'L - V de 9:00h a 18:00h',
            MfColors.dark,
          ),
          if (widget.resource.email != '')
            _dataRow(
              Icons.mail_outline,
              widget.resource.email,
              MfColors.primary[400],
            ),
          if (widget.resource.phone != '')
            _dataRow(
              Icons.whatshot,
              widget.resource.phone,
              MfColors.dark,
            ),
          if (widget.resource.web != '')
            _dataRow(
              Icons.public,
              widget.resource.web,
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
                '${widget.resource.name} ${widget.resource.description}, ${widget.resource.address}, ${widget.resource.googlemapUrl}');
          },
        )
      ],
    );
  }
}
