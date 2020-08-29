import 'package:flutter/material.dart';
import '../../screens/dashboard/dashboard.dart';
import '../../screens/organization/exploreorg.dart';
import '../../screens/donate_screen/donation_list.dart';
import '../../screens/dashboard/UserProfile.dart';
import '../../theme/theme.dart';

class BottomTabBar extends StatefulWidget {
  @override
  _BottomTabBarState createState() => _BottomTabBarState();
}

class _BottomTabBarState extends State<BottomTabBar> {
  int _currentIndex = 0;
  final tabs = [
    Dashboard(),
    ExploreOrganization(),
    DonationList(),
    UserProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: AppTheme.lightTheme.backgroundColor,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            title: Text('Home'),
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            title: Text('Explore'),
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            title: Text('Donations'),
            icon: Icon(Icons.monetization_on),
          ),
          BottomNavigationBarItem(
            title: Text('Profile'),
            icon: Icon(Icons.account_circle),
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
