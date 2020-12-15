import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:moving_forward/services/localization.dart';
import 'package:moving_forward/theme.dart';
import 'package:provider/provider.dart';
import 'state/favorites.dart';
import 'package:flutter_matomo/flutter_matomo.dart';
import 'package:moving_forward/services/db.dart';
import 'package:moving_forward/models/resource.dart';
import 'package:moving_forward/resource_detail.dart';
import 'package:moving_forward/services/location.dart';
import 'package:moving_forward/utils.dart';

class SavedResources extends StatelessWidget {
  final _db = DBService.instance;

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
            backgroundColor: Colors.transparent
        ),
        body: Consumer<FavoritesState>(
          builder: (context, favorites, child) {
            return FutureBuilder<List<Resource>>(
                future: _db.listResourcesById(
                    favorites.resources,
                    lang: AppLocalizations.locale.languageCode
                ),
                builder: (
                    BuildContext context,
                    AsyncSnapshot<List<Resource>> snapshot
                ) {
                    if (snapshot.data != null) {
                        return ListView(
                            children: [
                                for (var resource in snapshot.data) _resourceCard(context, resource)
                            ]
                        );
                    } else {
                        return _emptyResources(context);
                    }
                }
            );
          },
        )
    );
 }

  Container _emptyResources(BuildContext context) {
    return Container(
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
        )
    );
  }

  Card _resourceCard(BuildContext context, Resource resource) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 6,
      shadowColor: Colors.grey[100],
      child: new InkWell(
        onTap: () async {
          await FlutterMatomo.trackEventWithName(
              'CategoryDetail', '${resource.name}', 'Clicked');
          FlutterMatomo.dispatchEvents();
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ResourceDetailPage(resource: resource)),
          );
        },
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    if (resource.lat != null && resource.long != null)
                      FutureBuilder<int>(
                          future: LocationService.instance
                              .getDistance(resource.lat, resource.long),
                          builder: (BuildContext context,
                              AsyncSnapshot<int> snapshot) {
                            if (snapshot.data != null) {
                              return Container(
                                alignment: Alignment.topLeft,
                                child: Chip(
                                  backgroundColor: MfColors.primary[100],
                                  label: Text(
                                      "${AppLocalizations.of(context).translate('resource_distance')} ${getFormatedDistance(snapshot.data)}"),
                                ),
                              );
                            } else {
                              return Text('');
                            }
                          }),
                    Container(
                      alignment: Alignment.topRight,
                      child: Icon(Icons.bookmark_border, size: 30.0),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    resource.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                if (resource.description != '')
                  Container(
                    padding: const EdgeInsets.only(
                      top: 10,
                    ),
                    child: Text(
                      resource.description,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                if (resource.address != '')
                  Container(
                    padding: const EdgeInsets.only(
                      top: 20,
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.location_on, color: MfColors.gray),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              resource.address,
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
