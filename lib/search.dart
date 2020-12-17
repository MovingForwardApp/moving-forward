import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_matomo/flutter_matomo.dart';
import 'package:moving_forward/models/resource.dart';
import 'package:moving_forward/resource_detail.dart';
import 'package:moving_forward/services/db.dart';
import 'package:moving_forward/services/localization.dart';
import 'package:moving_forward/services/location.dart';
import 'package:moving_forward/state/favorites.dart';
import 'package:moving_forward/theme.dart';
import 'package:moving_forward/utils.dart';
import 'package:provider/provider.dart';

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
        child: SearchFormWidget(),
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

class SearchFormWidget extends StatefulWidget {
  @override
  _SearchFormWidgetState createState() => _SearchFormWidgetState();
}

class _SearchFormWidgetState extends State<SearchFormWidget> {
  final _db = DBService.instance;

  String _searchedText;

  void _updateSearchedText(String searchText) {
    setState(() {
      _searchedText = searchText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16,0,16,0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            alignment: Alignment(1.2, 0.0),
            child: RaisedButton(
              onPressed: () => Navigator.pop(context),
              elevation: 0.0,
              color: MfColors.white,
              child:
                Padding(
                  padding: const EdgeInsets.fromLTRB(10,0,0,0),
                  child: Icon(Icons.close, size: 30, color: MfColors.dark),
                ),
            ),
          ),
          TextField(
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black
            ),
            obscureText: false,
            autofocus: false,
            decoration: InputDecoration(
              hintText:
                AppLocalizations.of(context).translate('search_placeholder'),
              hintStyle:
                TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w100),
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(10.0),
                ),
                borderSide: BorderSide(
                    color: Color(0xFFDBEBE6), width: 3.0
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(10.0),
                ),
                borderSide: BorderSide(
                  color: Color(0xFF18AC91), width: 3.0,
                ),
              ),
              suffixIcon: Icon(Icons.search, size: 25, color: MfColors.gray)
            ),
            onChanged: _updateSearchedText,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: SingleChildScrollView(
                child: _buildSearchResults(context)
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults(BuildContext context) {
    if (_searchedText == null || _searchedText.length < 3) {
      return null;
    }

    return Container(
        color: MfColors.white,
        child: FutureBuilder<List<Resource>>(
            future: _db.listResourcesByText(
                _searchedText,
                LocationService.instance.locationLat,
                LocationService.instance.locationLong,
                lang: AppLocalizations.locale.languageCode),
            builder: (BuildContext context, AsyncSnapshot<List<Resource>> snapshot) {
              // Loading
              if (!snapshot.hasData) {
                return _buildLoadingIndicator();
              }

              // No result
              if (snapshot.data.length  == 0) {
                return _buildNoResults();
              }

              // With results
              return _buildResults(snapshot.data);
            }
        )
    );
  }

  Widget _buildLoadingIndicator() {
    return Padding(
        padding: EdgeInsets.only(top: 20),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FittedBox(
                fit: BoxFit.contain,
                child: CircularProgressIndicator(
                  value: null,
                  strokeWidth: 4.0,
                  valueColor: AlwaysStoppedAnimation<Color>(MfColors.light),
                ),
              )
            ]
        )
    );
  }

  Widget _buildNoResults() {
    return Padding(
        padding:  EdgeInsets.only(top: 20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search, size: 52, color: MfColors.light),
              Text(
                AppLocalizations.of(context).translate('no_search_result'),
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              )
            ]
        )
    );
  }

  Widget _buildResults(List<Resource> results) {
    return Column(
      children: results.map((resource) =>
          Container(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
              child: _buildResourceCard(context, resource)
          )
      ).toList(),
    );
  }

  Widget _buildResourceCard(BuildContext context, Resource resource) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 6,
      shadowColor: Colors.grey[100],
      child: new InkWell(
        onTap: () async {
          await FlutterMatomo.trackEventWithName(
              'CategoryDetail', 'CATEGORY.NAME/${resource.name}', 'Clicked');
          FlutterMatomo.dispatchEvents();
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ResourceDetailPage(resource: resource)),
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
                    Consumer<FavoritesState>(
                      builder: (context, favorites, child) {
                        if (favorites.isFavorite(resource.id)) {
                          return Container(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              icon: Icon(Icons.bookmark, size: 30.0),
                              onPressed: () async {
                                await FlutterMatomo.trackEventWithName(
                                    'savedResources', 'remove', 'Clicked');
                                FlutterMatomo.dispatchEvents();
                                Provider.of<FavoritesState>(context,
                                    listen: false)
                                    .remove(resource.id);
                              },
                            ),
                          );
                        } else {
                          return Container(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              icon: Icon(Icons.bookmark_border_outlined,
                                  size: 30.0),
                              onPressed: () async {
                                await FlutterMatomo.trackEventWithName(
                                    'savedResources', 'save', 'Clicked');
                                FlutterMatomo.dispatchEvents();
                                Provider.of<FavoritesState>(context,
                                    listen: false)
                                    .add(resource.id);
                              },
                            ),
                          );
                        }
                      },
                    )
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
