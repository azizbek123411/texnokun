import 'package:flutter/material.dart';

import '../models/ayah.dart';


class BookmarkProvider with ChangeNotifier {
  List<Ayah> _bookmarkedAyahs = [];

  List<Ayah> get bookmarkedAyahs => _bookmarkedAyahs;

  void addBookmark(Ayah ayah) {
    _bookmarkedAyahs.add(ayah);
    notifyListeners();
  }

  void removeBookmark(Ayah ayah) {
    _bookmarkedAyahs.remove(ayah);
    notifyListeners();
  }

  bool isBookmarked(Ayah ayah) {
    return _bookmarkedAyahs.contains(ayah);
  }
}