import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:texnokun/ui/widgets/rectangle_icon.dart';
import 'package:texnokun/utils/sizes/screen_utils.dart';

import '../../models/ayah.dart';
import '../../provider/font_size_provider.dart';
import '../../provider/provider.dart';
import '../../utils/app_styles/app_colors.dart';
import '../../utils/sizes/app_padding.dart';
import '../../utils/text_styles/text_styles.dart';

class SavedAyah extends StatefulWidget {
  final String arabicAyahs;
  final String russianAyahs;
  final String englishAyahs;

  const SavedAyah({
    super.key,
    required this.arabicAyahs,
    required this.russianAyahs,
    required this.englishAyahs,
  });

  @override
  State<SavedAyah> createState() => _SavedAyahState();
}

class _SavedAyahState extends State<SavedAyah> {
  late Ayah ayah;

  @override
  void initState() {
    super.initState();
    ayah = Ayah(
      arabicText: widget.arabicAyahs,
      englishText: widget.englishAyahs,
      russianText: widget.russianAyahs,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: Dis.only(
        bottom: 10.h,
      ),
      padding: Dis.only(
        lr: 10.w,
        tb: 10.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Consumer<BookmarkProvider>(
                builder: (context, bookmarkProvider, child) {
                  final isBookmarked = bookmarkProvider.isBookmarked(ayah);
                  return RectangleIcon(
                    icon: Icon(
                      isBookmarked
                          ? Icons.bookmark
                          : Icons.bookmark_border_outlined,
                      color: isBookmarked
                          ? AppColors.mainColor
                          : AppColors.appColor,
                    ),
                    onTap: () {
                      if (isBookmarked) {
                        bookmarkProvider.removeBookmark(ayah);
                      } else {
                        bookmarkProvider.addBookmark(ayah);
                      }
                    },
                    height: 35.h,
                    width: 35.w,
                  );
                },
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                child: Consumer<FontSizeProvider>(
                  builder: (context, fontSizeProvider, child) {
                    return Text(
                      widget.arabicAyahs.toString(),
                      style: AppTextStyle.instance.w700.copyWith(
                        fontSize: fontSizeProvider.arabicFontSize,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15.h,
          ),
          Consumer<FontSizeProvider>(
            builder: (context, fontSizeProvider, child) {
              return Text(
                widget.englishAyahs.toString(),
                style: AppTextStyle.instance.w300.copyWith(
                  fontSize: fontSizeProvider.translateFontSize,
                ),
              );
            },
          ),
          SizedBox(
            height: 8.h,
          ),
          Consumer<FontSizeProvider>(
            builder: (context, fontSizeProvider, child) {
              return Text(
                widget.russianAyahs.toString(),
                style: AppTextStyle.instance.w300.copyWith(
                  fontSize: fontSizeProvider.translateFontSize,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
