import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:texnokun/ui/widgets/saved_ayah.dart';
import 'package:texnokun/utils/app_styles/app_colors.dart';
import 'package:texnokun/utils/sizes/app_padding.dart';
import 'package:texnokun/utils/sizes/screen_utils.dart';
import '../../../provider/provider.dart';

class FavouritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backColor,
      body: Padding(
        padding: Dis.only(lr: 10.w, top: 10.h),
        child: Consumer<BookmarkProvider>(
          builder: (context, bookmarkProvider, child) {
            return ListView.builder(
              itemCount: bookmarkProvider.bookmarkedAyahs.length,
              itemBuilder: (context, index) {
                final ayah = bookmarkProvider.bookmarkedAyahs.toList()[index];
                return SavedAyah(
                  arabicAyahs: ayah.arabicText,
                  russianAyahs: ayah.russianText,
                  englishAyahs: ayah.englishText,
                 
                );
              },
            );
          },
        ),
      ),
    );
  }
}
