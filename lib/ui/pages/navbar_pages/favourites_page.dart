import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:texnokun/ui/widgets/saved_ayah.dart';
import 'package:texnokun/utils/app_styles/app_colors.dart';
import 'package:texnokun/utils/sizes/app_padding.dart';
import 'package:texnokun/utils/sizes/screen_utils.dart';
import 'package:texnokun/utils/text_styles/text_font_size.dart';
import 'package:texnokun/utils/text_styles/text_styles.dart';
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
            return  bookmarkProvider.bookmarkedAyahs.isNotEmpty? ListView.builder(
              itemCount: bookmarkProvider.bookmarkedAyahs.length,
              itemBuilder: (context, index) {
                final ayah = bookmarkProvider.bookmarkedAyahs.toList()[index];
                return  SavedAyah(
                  arabicAyahs: ayah.arabicText,
                  russianAyahs: ayah.russianText,
                  englishAyahs: ayah.englishText,
                 
                );
              },
            ):Center(
              child: Text('No favourites yet',style: AppTextStyle.instance.w700.copyWith(
                fontSize: FontSizeConst.instance.largeFont
              ),),
            );
          },
        ),
      ),
    );
  }
}
