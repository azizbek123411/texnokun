import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:texnokun/utils/app_styles/app_colors.dart';
import '../../../provider/provider.dart';
import '../../widgets/surah_detail.dart';

class FavouritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backColor,
      body: Consumer<BookmarkProvider>(
        builder: (context, bookmarkProvider, child) {
          return ListView.builder(
            itemCount: bookmarkProvider.bookmarkedAyahs.length,
            itemBuilder: (context, index) {
              final ayah = bookmarkProvider.bookmarkedAyahs.toList()[index];
              return SurahDetail(
                arabicAyahs: ayah.arabicText,
                russianAyahs: ayah.russianText,
                englishAyahs: ayah.englishText,
                verseCount: index + 1,
              );
            },
          );
        },
      ),
    );
  }
}
