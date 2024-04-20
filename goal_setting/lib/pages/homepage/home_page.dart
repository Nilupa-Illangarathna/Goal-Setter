import 'package:flutter/material.dart';
import 'package:goal_setting/pages/homepage/pages/report_page.dart';
import '../../data_state/dataState.dart';
import '../../global/global_settings.dart';
import '../../main.dart';
// import '../page_viewer.dart';
import 'pages/set_new_goals.dart';
import 'pages/settings_page.dart';
import 'pages/user_home_page.dart';
import '../../utils/theme.dart';
import '../app_drawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  PageController _pageController = PageController();

  bool _isAnimating = false;


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false; // Prevent going back
      },
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          children: [
            UserHomePage(),
            ToSetGoalPage(),
            ReportPage(),
            SettingsPage(),
          ],
        ),
        drawer: globalData.enableDrawer ? AppDrawer() : null,
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: AppTheme.themeData.primaryColor,
          unselectedItemColor: Colors.grey,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Overview',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.edit),
              label: 'Set Goals',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.analytics),
              label: 'Reports',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }

  void _onItemTapped(int pageIndex) {
    int currentPageIndex = _pageController.page!.round();
    int difference = (pageIndex - currentPageIndex).abs();
    int transitionTimeInMilisec = difference * globalData.homePageViewTransTime;
    if (!_isAnimating) {
      _isAnimating = true;
      Future.delayed(Duration(milliseconds: transitionTimeInMilisec), () {
        setState(() {
          _selectedIndex = pageIndex;
        });

      });
      _animateToPage(pageIndex, transitionTimeInMilisec);
    }
  }

  void _animateToPage(int pageIndex, int transitionTimeInMilisec) {
    _pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: transitionTimeInMilisec), // Adjust duration for smoother animation
      curve: Curves.easeInOut,
    ).then((value) {
      setState(() {
        _isAnimating = false;
      });
    });
  }
}

// class Page1 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('Page 1'),
//     );
//   }
// }

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Page 2'),
    );
  }
}

class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Page 3'),
    );
  }
}

class Page4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Page 4'),
    );
  }
}
