import 'package:flutter/material.dart';
import 'theme.dart';
import 'package:moving_forward/services/localization.dart';
import 'package:flutter_matomo/flutter_matomo.dart';

class TabInfo {
  final String name;
  final IconData icon;
  const TabInfo(this.name, this.icon);
}

enum TabItem { saved, home, info }

class BottomNavigation extends StatelessWidget {
  BottomNavigation({this.currentTab, this.onSelectTab});
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

  final Map<TabItem, TabInfo> tabItemsInfo = {
    TabItem.saved: TabInfo('Saved', Icons.bookmark),
    TabItem.home: TabInfo('Home', Icons.home),
    TabItem.info: TabInfo('Info', Icons.info_outline),
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        border: Border.all(
          color: MfColors.primary[100],
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
        child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: MfColors.white,
            fixedColor: MfColors.primary,
            unselectedLabelStyle: TextStyle(color: MfColors.dark),
            unselectedItemColor: MfColors.dark,
            iconSize: 30,
            currentIndex: currentTab.index,
            items: [
              _buildItem(tabItem: TabItem.saved, context: context),
              _buildItem(tabItem: TabItem.home, context: context),
              _buildItem(tabItem: TabItem.info, context: context),
            ],
            onTap: (index) async {
              await FlutterMatomo.trackEvent(
                  context,
                  TabItem.values[index].toString().split('.').last,
                  'Tab Clicked');
              FlutterMatomo.dispatchEvents();
              return onSelectTab(TabItem.values[index]);
            }),
      ),
    );
  }

  BottomNavigationBarItem _buildItem({TabItem tabItem, BuildContext context}) {
    String text =
        AppLocalizations.of(context).translate(tabItemsInfo[tabItem].name);
    IconData icon = tabItemsInfo[tabItem].icon;

    return BottomNavigationBarItem(
      icon: Icon(
        icon,
      ),
      label: text,
    );
  }
}
