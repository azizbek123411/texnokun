import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:texnokun/models/ayah.dart';
import 'package:texnokun/provider/provider.dart';
import 'package:texnokun/ui/widgets/rectangle_icon.dart';
import 'package:texnokun/utils/app_styles/app_colors.dart';
import 'package:texnokun/utils/sizes/app_padding.dart';
import 'package:texnokun/utils/sizes/screen_utils.dart';
import 'package:texnokun/utils/text_styles/text_font_size.dart';
import 'package:texnokun/utils/text_styles/text_styles.dart';


class SurahDetail extends StatefulWidget {
  final int verseCount;
  final String arabicAyahs;
  final String russianAyahs;
  final String englishAyahs;
  const SurahDetail({
    super.key,
    required this.arabicAyahs,
    required this.russianAyahs,
    required this.englishAyahs,
    required this.verseCount,
  });

  @override
  State<SurahDetail> createState() => _SurahDetailState();
}

class _SurahDetailState extends State<SurahDetail> {
  @override
  Widget build(BuildContext context) {
    final ayah = Ayah(
      arabicText: widget.arabicAyahs,
      englishText: widget.englishAyahs,
      russianText: widget.russianAyahs,
    );

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RectangleIcon(
                icon: Text('20x'),
                onTap: () {},
                height: 35.h,
                width: 35.w,
              ),
              RectangleIcon(
                icon: Text('15x'),
                onTap: () {},
                height: 35.h,
                width: 35.w,
              ),
              RectangleIcon(
                icon: Text('10x'),
                onTap: () {},
                height: 35.h,
                width: 35.w,
              ),
              RectangleIcon(
                icon: Text('5x'),
                onTap: () {},
                height: 35.h,
                width: 35.w,
              ),
              RectangleIcon(
                icon: Icon(Icons.play_arrow_outlined),
                onTap: () {},
                height: 35.h,
                width: 35.w,
              ),
              RectangleIcon(
                icon: Icon(Icons.games_outlined),
                onTap: () {},
                height: 35.h,
                width: 35.w,
              ),
              Consumer<BookmarkProvider>(
                builder: (context, bookmarkProvider, child) {
                  final isBookmarked = bookmarkProvider.isBookmarked(ayah);
                  return RectangleIcon(
                    icon: Icon(
                      isBookmarked
                          ? Icons.bookmark
                          : Icons.bookmark_border_outlined,
                      color: isBookmarked ? Colors.red : Colors.black,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.verseCount.toString(),
                style: AppTextStyle.instance.w700.copyWith(
                  color: AppColors.appColor,
                  fontSize: FontSizeConst.instance.mediumFont,
                ),
              ),
              Flexible(
                child: Text(
                  widget.arabicAyahs.toString(),
                  style: AppTextStyle.instance.w700.copyWith(
                    fontSize: FontSizeConst.instance.extraLargeFont,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15.h,
          ),
          Text(
            widget.englishAyahs.toString(),
            style: AppTextStyle.instance.w300.copyWith(
              fontSize: FontSizeConst.instance.extraSmallFont,
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            widget.russianAyahs.toString(),
            style: AppTextStyle.instance.w300.copyWith(
              fontSize: FontSizeConst.instance.extraSmallFont,
            ),
          ),
        ],
      ),
    );
  }
}
