import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:texnokun/service/audio_service.dart';
import 'package:texnokun/ui/pages/navbar_pages/favourites_page.dart';
import 'package:texnokun/ui/pages/navbar_pages/home_page.dart';
import 'package:texnokun/ui/pages/navbar_pages/quiz_page.dart';
import 'package:texnokun/ui/pages/navbar_pages/settings_page.dart';
import 'package:texnokun/ui/pages/navbar_pages/vocabulary_page.dart';
import 'package:texnokun/ui/widgets/settings_drawer.dart';
import 'package:texnokun/utils/app_styles/app_colors.dart';
import 'package:texnokun/utils/text_styles/text_font_size.dart';
import 'package:texnokun/utils/text_styles/text_styles.dart';

class MainNavBar extends StatefulWidget {

 static  String id='home';

  @override
  _MainNavBarState createState() => _MainNavBarState();
}

class _MainNavBarState extends State<MainNavBar> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  static List<Widget> _pages() {
    return [
      const HomePage(),
      const QuizPage(),
      VocabularyPage(),
      FavouritesPage(),
      SettingsPage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(
          IconlyLight.home,
        ),
        title: 'Home',
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: AppColors.backColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          IconlyLight.tickSquare,
        ),
        title: 'Quiz',
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: AppColors.backColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          IconlyLight.paper,
        ),
        title: 'Vocublary',
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: AppColors.backColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          IconlyLight.bookmark,
        ),
        title: 'Favourites',
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: AppColors.backColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          IconlyLight.setting,
        ),
        title: 'Settings',
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: AppColors.backColor,
      ),
    ];
  }

  void _onItemTapped(int index) async {
    if (index == 4) {
      _scaffoldKey.currentState?.openEndDrawer();
      _controller.jumpToTab(0);
    } else {
      setState(() {
      });
    }
  }

  @override
  void initState() {
    super.initState();
    initPermiPermission();
  }

  void initPermiPermission() async {
    await AudioServices().initPermission();
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
      body: PersistentTabView(

        
      context,
        onItemSelected: _onItemTapped,
        screens: _pages(),
        controller: _controller,
        items: _navBarItems(),
        navBarStyle: NavBarStyle.style9,
      ),
      endDrawer: SettingsDrawer(),
    );
  }
}
