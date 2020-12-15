import 'package:flutter/material.dart';

import 'bottom_navigation.dart';

import 'package:moving_forward/models/category.dart';
import 'package:moving_forward/models/resource.dart';
import 'saved.dart';
import 'category_list.dart';
import 'category_detail.dart';
import 'resource_detail.dart';
import 'info.dart';

Resource resource;
Category category;
Map<TabItem, Map<String, WidgetBuilder>> tabItemsRoutes = {
  TabItem.saved: {
    '/': (context) => SavedResources(),
  },
  TabItem.home: {
    '/': (context) => CategoryList(),
    '/category': (context) => CategoryDetail(category: category),
    '/resource': (context) =>
        ResourceDetailPage(resource: resource),
  },
  TabItem.info: {'/': (context) => Info()}
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
    return tabItemsRoutes[this.tabItem];

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
