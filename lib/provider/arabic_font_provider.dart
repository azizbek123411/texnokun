import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class ArabicFontProvider with ChangeNotifier {
  final Box settingsBox = Hive.box('settings');
  String _selectedFont = 'Amiri';

  FontProvider() {
    _selectedFont = settingsBox.get('settings', defaultValue: 'Amiri');
  }

  TextStyle get arabicFont {
    switch (_selectedFont) {
      case 'Scheherazade':
        return GoogleFonts.scheherazadeNew();
      case 'Lateef':
        return GoogleFonts.lateef();
      case 'Qahiri':
        return GoogleFonts.lateef();
      default:
        return GoogleFonts.amiri();
    }
  }

  String get selectedFont=>_selectedFont;

  void changeFont(String fontName){
    _selectedFont=fontName;
    settingsBox.put('settings', fontName);
    notifyListeners();
  }
}
