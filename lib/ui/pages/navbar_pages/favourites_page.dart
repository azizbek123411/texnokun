import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:texnokun/utils/app_styles/app_colors.dart';
import 'package:texnokun/utils/sizes/screen_utils.dart';
import '../../../provider/provider.dart';
import '../../../utils/sizes/app_padding.dart';
import '../../widgets/surah_detail.dart';

class FavouritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backColor,
      body: Consumer<BookmarkProvider>(
        builder: (context, bookmarkProvider, child) {
          return Padding(
            padding: Dis.only(
            lr: 10.w,
           top: 8.h,
          ),
            child: ListView.builder(
              itemCount: bookmarkProvider.bookmarkedAyahs.length,
              itemBuilder: (context, index) {
                final ayah = bookmarkProvider.bookmarkedAyahs[index];
                return SurahDetail(
                  arabicAyahs: ayah.arabicText,
                  russianAyahs: ayah.russianText,
                  englishAyahs: ayah.englishText,
                  verseCount: index + 1,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
