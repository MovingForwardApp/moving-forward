import 'package:flutter/material.dart';
import 'bottom_navigation.dart';
import 'tab_navigator.dart';
import 'package:flutter_matomo/flutter_matomo.dart';

class AppLayout extends StatefulWidget {
  AppLayout({Key key}) : super(key: key) {
    initPage('home');
  }

  Future<void> initPage(String route) async {
    await FlutterMatomo.trackScreenWithName(route, "Screen opened");
  }

  @override
  State<StatefulWidget> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  TabItem _currentTab = TabItem.home;

  Map<TabItem, GlobalKey<NavigatorState>> _navigatorKeys = {
    TabItem.saved: GlobalKey<NavigatorState>(),
    TabItem.home: GlobalKey<NavigatorState>(),
    TabItem.info: GlobalKey<NavigatorState>(),
  };

  void _selectTab(TabItem tabItem) {
    initPage(tabItem.toString().split('.').last);
    if (tabItem == _currentTab) {
      // pop to first route
      _navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = tabItem);
    }
  }

  Future<void> initPage(String route) async {
    await FlutterMatomo.trackScreenWithName(route, "Screen opened");
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_currentTab].currentState.maybePop();
        if (isFirstRouteInCurrentTab) {
          // if not on the 'main' tab
          if (_currentTab != TabItem.home) {
            // select 'main' tab
            _selectTab(TabItem.home);
            // back button handled by app
            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: Stack(children: <Widget>[
          _buildOffstageNavigator(TabItem.saved),
          _buildOffstageNavigator(TabItem.home),
          _buildOffstageNavigator(TabItem.info),
        ]),
        bottomNavigationBar: BottomNavigation(
          currentTab: _currentTab,
          onSelectTab: _selectTab,
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(TabItem tabItem) {
    return Offstage(
      offstage: _currentTab != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }
}
