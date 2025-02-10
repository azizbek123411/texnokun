import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/ayah.dart';

class BookmarkProvider with ChangeNotifier {
  List<Ayah> _bookmarkedAyahs = [];

  List<Ayah> get bookmarkedAyahs => _bookmarkedAyahs;

  BookmarkProvider() {
    _loadBookmarks();
  }

  void addBookmark(Ayah ayah) {
    _bookmarkedAyahs.add(ayah);
    _saveBookmarks();
    notifyListeners();
  }

  void removeBookmark(Ayah ayah) {
    _bookmarkedAyahs.remove(ayah);
    _saveBookmarks();
    notifyListeners();
  }

  bool isBookmarked(Ayah ayah) {
    return _bookmarkedAyahs.contains(ayah);
  }

  void _saveBookmarks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> bookmarks = _bookmarkedAyahs
        .map(
          (ayah) => jsonEncode(
            ayah.toJson(),
          ),
        )
        .toList();
    prefs.setStringList('bookmarks', bookmarks);
  }

  void _loadBookmarks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? bookmarks = prefs.getStringList('bookmarks');
    if (bookmarks != null) {
      _bookmarkedAyahs = bookmarks
          .map(
            (bookmark) => Ayah.fromJson(
              jsonDecode(
                bookmark,
              ),
            ),
          )
          .toList();
      notifyListeners();
    }
  }
}
