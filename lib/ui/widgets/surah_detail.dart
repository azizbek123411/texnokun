
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_flutter/quran_flutter.dart';
import 'package:texnokun/ui/widgets/rectangle_icon.dart';
import 'package:texnokun/utils/app_styles/app_colors.dart';
import 'package:texnokun/utils/sizes/app_padding.dart';
import 'package:texnokun/utils/sizes/screen_utils.dart';
import 'package:texnokun/utils/text_styles/text_font_size.dart';
import 'package:texnokun/utils/text_styles/text_styles.dart';
import '../../models/ayah.dart';
import '../../provider/font_size_provider.dart';
import '../../provider/provider.dart';

class SurahDetail extends StatefulWidget {
  final void Function() togglePlayPause;
  final void Function() play20;
  final void Function() play15;
  final void Function() play10;
  final void Function() play5;
  final bool isPlaying;
  final int repeatCount;
  final int verseCount;
  final int surahCount;
  final String arabicAyahs;
  final String russianAyahs;
  final String englishAyahs;
  final Verse verse;
  const SurahDetail(
      {super.key,
      required this.play10,
      required this.play5,
      required this.play20,
      required this.play15,
      required this.arabicAyahs,
      required this.russianAyahs,
      required this.englishAyahs,
      required this.verseCount,
      required this.surahCount,
      required this.isPlaying,
      required this.repeatCount,
      required this.togglePlayPause,
      required this.verse});

  @override
  State<SurahDetail> createState() => _SurahDetailState();
}

class _SurahDetailState extends State<SurahDetail> {
  @override
  Widget build(BuildContext context) {
    final versee = Ayah(
      arabicText: Quran.getVerse(
        surahNumber: widget.verse.surahNumber,
        verseNumber: widget.verse.verseNumber,
      ).text,
      englishText: Quran.getVerse(
              surahNumber: widget.verse.surahNumber,
              verseNumber: widget.verse.verseNumber,
              language: QuranLanguage.english)
          .text,
      russianText: Quran.getVerse(
              surahNumber: widget.verse.surahNumber,
              verseNumber: widget.verse.verseNumber,
              language: QuranLanguage.russian)
          .text,
    );
    return Container(
      margin: Dis.only(
        bottom: 10.h,
        top: 8,
        lr: 16,
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
                color: widget.repeatCount == 20
                    ? AppColors.mainColor
                    : AppColors.backColor,
                icon: const Text('20x'),
                onTap: widget.play20,
                height: 35.h,
                width: 35.w,
              ),
              RectangleIcon(
                icon: const Text('15x'),
                onTap: widget.play15,
                height: 35.h,
                width: 35.w,
                color: widget.repeatCount == 15
                    ? AppColors.mainColor
                    : AppColors.backColor,
              ),
              RectangleIcon(
                color: widget.repeatCount == 10
                    ? AppColors.mainColor
                    : AppColors.backColor,
                icon: const Text('10x'),
                onTap: widget.play10,
                height: 35.h,
                width: 35.w,
              ),
              RectangleIcon(
                color: widget.repeatCount == 5
                    ? AppColors.mainColor
                    : AppColors.backColor,
                icon: const Text('5x'),
                onTap: widget.play5,
                height: 35.h,
                width: 35.w,
              ),
              RectangleIcon(
                icon: Icon(
                    widget.isPlaying ? Icons.pause : Icons.play_arrow_outlined),
                onTap: widget.togglePlayPause,
                height: 35.h,
                width: 35.w,
              ),
              Consumer<BookmarkProvider>(
                builder: (context, bookmarkProvider, child) {
                  final isBookmarked = bookmarkProvider.isBookmarked(versee);
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
                        bookmarkProvider.removeBookmark(versee);
                      } else {
                        bookmarkProvider.addBookmark(versee);
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
