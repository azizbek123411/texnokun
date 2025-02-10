import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:quran_flutter/enums/quran_language.dart';
import 'package:quran_flutter/models/verse.dart';
import 'package:quran_flutter/quran.dart';
import 'package:texnokun/ui/widgets/surah_detail.dart';
import 'package:texnokun/utils/app_styles/app_colors.dart';
import 'package:texnokun/utils/sizes/app_padding.dart';
import 'package:texnokun/utils/sizes/screen_utils.dart';
import 'package:texnokun/utils/text_styles/text_styles.dart';

import '../../utils/text_styles/text_font_size.dart';

class SurahsDetailsPage extends StatefulWidget {
  final int surahNumber;
  const SurahsDetailsPage({super.key, required this.surahNumber});

  @override
  State<SurahsDetailsPage> createState() => _SurahsDetailsPageState();
}

class _SurahsDetailsPageState extends State<SurahsDetailsPage> {
  @override
  Widget build(BuildContext context) {
    String surahName = Quran.getSurahNameEnglish(widget.surahNumber);
    int verseCount = Quran.getTotalVersesInSurah(widget.surahNumber);
    return Scaffold(
      backgroundColor: AppColors.backColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            IconlyLight.arrowLeft2,
            color: Colors.black,
          ),
        ),
        backgroundColor: AppColors.whiteColor,
        title: Text(
          surahName.toString(),
          style: AppTextStyle.instance.w900.copyWith(
            color: AppColors.mainColor,
            fontSize: FontSizeConst.instance.largeFont,
          ),
        ),
      ),
      body: Padding(
        padding: Dis.only(
          lr: 10.w,
          top: 8.h,
        ),
        child: ListView.builder(
            itemCount: verseCount,
            itemBuilder: (context, index) {
              Verse verseEnglish = Quran.getVerse(
                surahNumber: widget.surahNumber,
                verseNumber: index + 1,
                language: QuranLanguage.english,
              );
              Verse verse = Quran.getVerse(
                surahNumber: widget.surahNumber,
                verseNumber: index + 1,
              );
              Verse verseRussian = Quran.getVerse(
                surahNumber: widget.surahNumber,
                verseNumber: index + 1,
                language: QuranLanguage.russian,
              );
              return SurahDetail(
                verseCount: index + 1,
                russianAyahs: verseRussian.text,
                arabicAyahs: verse.text,
                englishAyahs: verseEnglish.text,
                surahCount: widget.surahNumber,
              );
            }),
      ),
    );
  }
}
