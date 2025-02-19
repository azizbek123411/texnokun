import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:quran/surah_data.dart';
import 'package:quran_flutter/enums/quran_language.dart';
import 'package:quran_flutter/models/verse.dart';
import 'package:quran_flutter/quran.dart';
import 'package:scroll_to_id/scroll_to_id.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
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



late ScrollToId scrollToId;
  final ScrollController scrollController = ScrollController();

@override
  void initState() {

    super.initState();
       scrollToId = ScrollToId(scrollController: scrollController);
  }

  @override
  Widget build(BuildContext context) {
    String surahName = Quran.getSurahNameEnglish(widget.surahNumber);
    
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
        child: InteractiveScrollViewer(
          scrollToId: scrollToId,
        children: [
         for(final item in Quran.getSurahVersesAsList(widget.surahNumber))
          ScrollContent(id:'${item.surahNumber }  ${item.verseNumber}', child: surahDetail(item,(){
            scrollToId.jumpToNext();
          }),)
        ],)
      )
     
    );
  }


Widget surahDetail(Verse verse,void Function() nextVerse){  
final itemEnglishVerse=Quran.getVerse(surahNumber:verse.surahNumber,verseNumber:verse.verseNumber,language: QuranLanguage.english);
final itemRussianVerse=Quran.getVerse(surahNumber:verse.surahNumber,verseNumber:verse.verseNumber,language: QuranLanguage.russian);
final itemArabicVerse=Quran.getVerse(surahNumber:verse.surahNumber,verseNumber:verse.verseNumber,);

  return SurahDetail(
                arabicAyahs: itemArabicVerse.text,
                englishAyahs: itemEnglishVerse.text,
                russianAyahs: itemRussianVerse.text,
                verseCount: verse.verseNumber,
                surahCount: widget.surahNumber, nextVerse: nextVerse,
              );
}

}
