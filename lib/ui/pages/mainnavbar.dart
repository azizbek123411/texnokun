import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:texnokun/models/surahs.dart';
import 'package:texnokun/ui/pages/favourites_page.dart';
import 'package:texnokun/ui/pages/home_page.dart';
import 'package:texnokun/ui/pages/quiz_page.dart';
import 'package:texnokun/ui/pages/settings_page.dart';
import 'package:texnokun/ui/pages/vocabulary_page.dart';
import 'package:texnokun/ui/widgets/settings_drawer.dart';
import 'package:texnokun/utils/app_styles/app_colors.dart';
import 'package:texnokun/utils/text_styles/text_font_size.dart';
import 'package:texnokun/utils/text_styles/text_styles.dart';

class MainNavBar extends StatefulWidget {
  @override
  _MainNavBarState createState() => _MainNavBarState();
}

class _MainNavBarState extends State<MainNavBar> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  static   final List<Widget> _pages = [
     HomePage(surahs: Surahs(),),
    QuizPage(),
    VocabularyPage(),
    FavouritesPage(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    if (index == 4) {
      _scaffoldKey.currentState?.openEndDrawer();
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        title: Text(
          'Quran Learn',
          style: AppTextStyle.instance.w900.copyWith(
            color: AppColors.mainColor,
            fontSize: FontSizeConst.instance.largeFont,
          ),
        ),
      ),
      body: _pages[_selectedIndex],
      endDrawer: SettingsDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(IconlyLight.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(IconlyLight.infoSquare),
            label: 'Quiz',
          ),
          BottomNavigationBarItem(
            icon: Icon(IconlyLight.tickSquare),
            label: 'Vocabulary',
          ),
          BottomNavigationBarItem(
            icon: Icon(IconlyLight.bookmark),
            label: 'Favourites',
          ),
          BottomNavigationBarItem(
            icon: Icon(IconlyLight.setting),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
