import 'package:flutter/material.dart';

import 'bottom_navigation.dart';

import 'saved.dart';
import 'category_list.dart';
import 'category_detail.dart';
import 'resource.dart';
import 'info.dart';


Map<TabItem, Map<String, WidgetBuilder>> TabItemsRoutes = {
  TabItem.saved: {
    '/': (context) => Saved(),
  },
  TabItem.home: {
    '/': (context) => CategoryList(),
    '/category': (context) => CategoryDetail(),
    '/resource': (context) => Resource(),
  },
  TabItem.info: {
    '/': (context) => Info()
  }
};


class TabNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final TabItem tabItem;

  TabNavigator({this.navigatorKey, this.tabItem});

  /* DELETE ME
  void _push(BuildContext context) {
    var routeBuilders = _routeBuilders(context);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => routeBuilders[TabNavigatorRoutes.detail](context),
      ),
    );
  }
  */

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context) {
    return TabItemsRoutes[this.tabItem];

    /*  DELETE ME
    return {
      TabNavigatorRoutes.root: (context) => ColorsListPage(
        color: activeTabColor[tabItem],
        title: tabName[tabItem],
        onPush: (materialIndex) => _push(context, materialIndex: materialIndex),
      ),
      TabNavigatorRoutes.detail: (context) => ColorDetailPage(
        color: activeTabColor[tabItem],
        title: tabName[tabItem],
        materialIndex: materialIndex,
      ),
    };
    */
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders(context);
    return Navigator(
      key: navigatorKey,
      initialRoute: '/',
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => routeBuilders[routeSettings.name](context),
        );
      },
    );
  }
}