import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_flutter/models/verse.dart';
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
import 'package:quran/quran.dart' as quran;
import '../../service/audio_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SurahDetail extends StatefulWidget {
  void Function() nextVerse;
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
    required this.nextVerse,
  });

  @override
  State<SurahDetail> createState() => _SurahDetailState();
}

class _SurahDetailState extends State<SurahDetail> {
  bool isPlaying = false;
  int repeatCount = 1;
  int currentRepeat = 0;
  Duration currentPosition = Duration.zero;
  Duration totalDuration = Duration.zero;
  final player = AudioPlayer();
  final audioService = AudioServices();
  late Ayah ayah;
  final fToast = FToast();
  late Verse inititalVerse;

  @override
  void initState() {
    super.initState();
   setState(() {
      inititalVerse = Quran.getVerse(
      surahNumber: widget.surahCount,
      verseNumber: widget.verseCount,
    );
   });
    fToast.init(context);
    ayah = Ayah(
      arabicText: widget.arabicAyahs,
      englishText: widget.englishAyahs,
      russianText: widget.russianAyahs,
    );

    player.onPositionChanged.listen((position) {
      setState(() {
        currentPosition = position;
      });
    });

    player.onDurationChanged.listen((duration) {
      setState(() {
        totalDuration = duration;
      });
    });

    player.onPlayerComplete.listen((event) {
      widget.nextVerse();
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

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  void showToast() {
    if (isPlaying) {
      fToast.showToast(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            color: Colors.black54,
          ),
          child: Text(
            "Playing",
            style: AppTextStyle.instance.w300.copyWith(
              color: AppColors.whiteColor,
            ),
          ),
        ),
        gravity: ToastGravity.BOTTOM,
        toastDuration: const Duration(seconds: 4),
      );
    }
  }

  void _playCurrentAyah() async {
    var path = await audioService.downloadAudio(
      widget.surahCount,
      widget.verseCount,
    );
    if (path.isNotEmpty) {
      await player.play(DeviceFileSource(path));
      setState(() {
        isPlaying = true;
      });
      // showToast();
    }
  }

  void _playNextAyah() async {
    if (widget.verseCount < quran.getVerseCount(widget.surahCount)) {
      setState(() {
        widget.verseCount++;
              inititalVerse = Quran.getVerse(
      surahNumber: widget.surahCount,
      verseNumber: widget.verseCount,
    );
      });
      _playCurrentAyah();
    }
  }

  void _togglePlayPause() async {
    if (isPlaying) {
      await player.stop();
    } else {
      _playCurrentAyah();
    }
    setState(() {
      isPlaying = !isPlaying;
    });
    showToast();
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
                color: repeatCount == 20
                    ? AppColors.mainColor
                    : AppColors.backColor,
                icon: const Text('20x'),
                onTap: () {
                  showToast();
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
                color: repeatCount == 15
                    ? AppColors.mainColor
                    : AppColors.backColor,
              ),
              RectangleIcon(
                color: repeatCount == 10
                    ? AppColors.mainColor
                    : AppColors.backColor,
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
                color: repeatCount == 5
                    ? AppColors.mainColor
                    : AppColors.backColor,
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
                icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow_outlined),
                onTap: _togglePlayPause,
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
