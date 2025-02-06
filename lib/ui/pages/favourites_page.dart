import 'package:flutter/material.dart';
import 'package:texnokun/utils/app_styles/app_colors.dart';

class FavouritesPage extends StatefulWidget {
  @override
  _FavouritesPageState createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backColor,
      body: Center(
        child: Text('Favourites Page', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}