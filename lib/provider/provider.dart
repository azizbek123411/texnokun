import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/ayah.dart';

class BookmarkProvider with ChangeNotifier {
  List<Ayah> _bookmarkedAyahs = [];
  late Box box;

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
    _bookmarkedAyahs.removeWhere((item) => item.arabicText == ayah.arabicText);
    _saveBookmarks();
    notifyListeners();
  }

  bool isBookmarked(Ayah ayah) {
    return _bookmarkedAyahs.any((item) => item.arabicText == ayah.arabicText);
  }

  void _saveBookmarks() async {
    box = await Hive.openBox('bookmarkBox');
    List<Map<String, dynamic>> bookmarks = _bookmarkedAyahs
        .map((ayah) => ayah.toJson())
        .toList();
    box.put('bookmarks', bookmarks);
  }

  void _loadBookmarks() async {
    box = await Hive.openBox('bookmarkBox');
    List<dynamic>? bookmarks = box.get('bookmarks');
    if (bookmarks != null) {
      _bookmarkedAyahs = bookmarks
          .map((bookmark) => Ayah.fromJson(Map<String, dynamic>.from(bookmark)))
          .toList();
      notifyListeners();
    }
  }
}
