import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:texnokun/ui/widgets/rectangle_icon.dart';
import 'package:texnokun/utils/app_styles/app_colors.dart';
import 'package:texnokun/utils/sizes/app_padding.dart';
import 'package:texnokun/utils/sizes/screen_utils.dart';
import 'package:texnokun/utils/text_styles/text_font_size.dart';
import 'package:texnokun/utils/text_styles/text_styles.dart';
import '../../models/ayah.dart';
import '../../provider/font_size_provider.dart';
import '../../provider/provider.dart';
import 'package:quran/quran.dart' as quran;

class SurahDetail extends StatefulWidget {
   int verseCount;
  final int surahCount;
  final String arabicAyahs;
  final String russianAyahs;
  final String englishAyahs;
   SurahDetail({
    super.key,
    required this.arabicAyahs,
    required this.russianAyahs,
    required this.englishAyahs,
    required this.verseCount,
    required this.surahCount,
  });

  @override
  State<SurahDetail> createState() => _SurahDetailState();
}

class _SurahDetailState extends State<SurahDetail> {
bool isPlaying = false;

  
int repeatCount=1;
int currentRepeat=0;
Duration currentPosition=Duration.zero;
  final player = AudioPlayer();

  late Ayah ayah;

  @override
  void initState() {
    super.initState();
    ayah = Ayah(
      arabicText: widget.arabicAyahs,
      englishText: widget.englishAyahs,
      russianText: widget.russianAyahs,
    );
     player.onPlayerComplete.listen((event) {
      setState(() {
        currentPosition = Duration.zero;
        if (currentRepeat < repeatCount - 1) {
          currentRepeat++;
          _playCurrentAyah();
        } else {
          isPlaying = false;
          currentRepeat = 0;
          _playNextAyah();
        }
      });
    });
  
  }

  void _playCurrentAyah() async {
    await player.play(
      UrlSource(
        quran.getAudioURLByVerse(
          widget.surahCount,
          widget.verseCount,
        ),
      ),
    );
    setState(() {
      isPlaying = true;
    });
  }
  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  void _playNextAyah() async {
    if (widget.verseCount < quran.getVerseCount(widget.surahCount)) {
      await player.play(
        UrlSource(
          quran.getAudioURLByVerse(
            widget.surahCount,
            widget.verseCount ++,
          ),
        ),
      );
      setState(() {
        isPlaying = true;
      });
    }
  }

  void _togglePlayPause() async {
    if (isPlaying) {
      await player.pause();
    } else {
      _playCurrentAyah();
    }
    setState(() {
      isPlaying = !isPlaying;
    });
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                 RectangleIcon(
                icon: const Text('20x'),
                onTap: () {
                  setState(() {
                    repeatCount = 20;
                  });
                  _playCurrentAyah();
                },
                height: 35.h,
                width: 35.w,
              ),
              RectangleIcon(
                icon: const Text('15x'),
                onTap: () {
                  setState(() {
                    repeatCount = 15;
                  });
                  _playCurrentAyah();
                },
                height: 35.h,
                width: 35.w,
              ),
              RectangleIcon(
                icon: const Text('10x'),
                onTap: () {
                  setState(() {
                    repeatCount = 10;
                  });
                  _playCurrentAyah();
                },
                height: 35.h,
                width: 35.w,
              ),
              RectangleIcon(
                icon: const Text('5x'),
                onTap: () {
                  setState(() {
                    repeatCount = 5;
                  });
                  _playCurrentAyah();
                },
                height: 35.h,
                width: 35.w,
              ),
              RectangleIcon(
                icon:Icon(isPlaying?Icons.pause: Icons.play_arrow_outlined),
                onTap: (){
                  _togglePlayPause();
                
                },
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
