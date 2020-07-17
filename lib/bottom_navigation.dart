import 'package:flutter/material.dart';
import 'theme.dart';

class TabInfo {
  final String name;
  final IconData icon;
  const TabInfo(this.name, this.icon);
}

enum TabItem { saved, home, info }

const Map<TabItem, TabInfo> TabItemsInfo = {
  TabItem.saved: TabInfo('Saved', Icons.bookmark),
  TabItem.home: TabInfo('Home', Icons.home),
  TabItem.info: TabInfo('Info', Icons.info_outline),
};

class BottomNavigation extends StatelessWidget {
  BottomNavigation({this.currentTab, this.onSelectTab});
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

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
          iconSize: 30,
          items: [
            _buildItem(tabItem: TabItem.saved),
            _buildItem(tabItem: TabItem.home),
            _buildItem(tabItem: TabItem.info),
          ],
          onTap: (index) => onSelectTab(
            TabItem.values[index],
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildItem({TabItem tabItem}) {
    String text = TabItemsInfo[tabItem].name;
    IconData icon = TabItemsInfo[tabItem].icon;
    Color color = currentTab == tabItem ? MfColors.primary : MfColors.dark;

    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        color: color,
      ),
      title: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    );
  }
}
