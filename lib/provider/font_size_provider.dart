import 'package:flutter/material.dart';

class FontSizeProvider with ChangeNotifier {
  double _arabicFontSize = 24.0;
  double _translateFontSize = 16.0;

  double get arabicFontSize => _arabicFontSize;
  double get translateFontSize => _translateFontSize;

  void setArabicFontSize(double size) {
    _arabicFontSize = size;
    notifyListeners();
  }

  void setTranslateFontSize(double size) {
    _translateFontSize = size;
    notifyListeners();
  }
}