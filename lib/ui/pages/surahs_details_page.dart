import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:quran_flutter/enums/quran_language.dart';
import 'package:quran_flutter/models/surah.dart';
import 'package:quran_flutter/models/verse.dart';
import 'package:quran_flutter/quran.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:texnokun/ui/widgets/surah_detail.dart';
import 'package:texnokun/utils/app_styles/app_colors.dart';
import 'package:texnokun/utils/sizes/app_padding.dart';
import 'package:texnokun/utils/sizes/screen_utils.dart';
import 'package:texnokun/utils/text_styles/text_styles.dart';

import '../../service/audio_service.dart';
import '../../utils/text_styles/text_font_size.dart';

class SurahsDetailsPage extends StatefulWidget {
  final int surahNumber;

  const SurahsDetailsPage({super.key, required this.surahNumber});

  @override
  State<SurahsDetailsPage> createState() => _SurahsDetailsPageState();
}

class _SurahsDetailsPageState extends State<SurahsDetailsPage> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ScrollOffsetController scrollOffsetController =
      ScrollOffsetController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final ScrollOffsetListener scrollOffsetListener =
      ScrollOffsetListener.create();

  late Verse _initialVerse;
  bool _isPlaying = false;
  int _repeatCount = 1;
  int _currentRepeat = 0;
  final _player = AudioPlayer();
  final _audioService = AudioServices();

  Surah get surah => Quran.getSurah(widget.surahNumber);
  final ScrollController scrollController = ScrollController();

  void _onPressedPlayButton(Verse verse) async {
    setState(() {});
    if (_isPlaying) {
      await _player.stop().then((_) => setState(() => _isPlaying = false));
      return;
    }

    _initialVerse = verse;
    final audioPath = await _audioService.downloadAudio(
        widget.surahNumber, verse.verseNumber);
    await _player
        .play(DeviceFileSource(audioPath))
        .then((_) => setState(() => _isPlaying = true));

    print(((verse == _initialVerse) && _isPlaying));
  }

  void _audioPlayerListener() {
    _player.onPlayerComplete.listen((event) async {
      if (_currentRepeat < _repeatCount - 1) {
        _currentRepeat++;

        final audioPath = await _audioService.downloadAudio(
            widget.surahNumber, _initialVerse.verseNumber);
        await _player.play(DeviceFileSource(audioPath)).then(
              (_) => setState(() => _isPlaying = true),
            );
      } else if (surah.verseCount > _initialVerse.verseNumber) {
        _currentRepeat = 0;

        final oldVerseNumber = _initialVerse.verseNumber + 1;
        _initialVerse = Quran.getVerse(
            surahNumber: surah.number, verseNumber: oldVerseNumber);
        final audioPath = await _audioService.downloadAudio(
            widget.surahNumber, _initialVerse.verseNumber);
        await _player.play(DeviceFileSource(audioPath)).then(
              (_) => setState(() => _isPlaying = true),
            );

        itemScrollController.scrollTo(
          index: _initialVerse.verseNumber - 1,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutCubic,
        );
      } else {
        setState(() {
          _isPlaying = false;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _initialVerse =
          Quran.getVerse(surahNumber: widget.surahNumber, verseNumber: 1);
    });

    _audioPlayerListener();
  }

  @override
  Widget build(BuildContext context) {
    String surahName = Quran.getSurahNameEnglish(widget.surahNumber);
    final list = Quran.getSurahVersesAsList(widget.surahNumber);

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
      body: ScrollablePositionedList.builder(
        itemCount: list.length,
        itemScrollController: itemScrollController,
        scrollOffsetController: scrollOffsetController,
        itemPositionsListener: itemPositionsListener,
        scrollOffsetListener: scrollOffsetListener,
        itemBuilder: (context, index) {
          final item = list[index];

          return SurahDetailItemScreen(
            verse: item,
            initialVerse: _initialVerse,
            isPlaying: _isPlaying,
            repeatCount: _repeatCount,
            surahNumber: widget.surahNumber,
            onPressedPlayButton: () {
              _onPressedPlayButton(item);
            },
            play10: () {
              setState(() {
                _repeatCount = 10;
                _currentRepeat = 0;
              });
              _onPressedPlayButton(item);
            },
            play20: () {
              setState(() {
                _repeatCount = 20;
                _currentRepeat = 0;
              });
              _onPressedPlayButton(item);
            },
            play15: () {
              setState(() {
                _repeatCount = 15;
                _currentRepeat = 0;
              });
              _onPressedPlayButton(item);
            },
            play5: () {
              setState(() {
                _repeatCount = 5;
                _currentRepeat = 0;
              });
              _onPressedPlayButton(item);
            },
          );
        },
      ),
    );
  }
}

class SurahDetailItemScreen extends StatelessWidget {
  final Verse verse;
  final int surahNumber;
  final int repeatCount;
  final Verse initialVerse;
  final bool isPlaying;
  final void Function() onPressedPlayButton;
  final void Function() play5;
  final void Function() play10;
  final void Function() play15;
  final void Function() play20;

  const SurahDetailItemScreen(
      {super.key,
      required this.verse,
      required this.surahNumber,
      required this.initialVerse,
      required this.isPlaying,
      required this.onPressedPlayButton,
      required this.repeatCount,
      required this.play10,
      required this.play5,
      required this.play20,
      required this.play15});

  @override
  Widget build(BuildContext context) {
    final itemEnglishVerse = Quran.getVerse(
        surahNumber: verse.surahNumber,
        verseNumber: verse.verseNumber,
        language: QuranLanguage.english);
    final itemRussianVerse = Quran.getVerse(
        surahNumber: verse.surahNumber,
        verseNumber: verse.verseNumber,
        language: QuranLanguage.russian);
    final itemArabicVerse = Quran.getVerse(
      surahNumber: verse.surahNumber,
      verseNumber: verse.verseNumber,
    );

    return SurahDetail(
      arabicAyahs: itemArabicVerse.text,
      englishAyahs: itemEnglishVerse.text,
      russianAyahs: itemRussianVerse.text,
      verseCount: verse.verseNumber,
      surahCount: surahNumber,
      isPlaying: ((verse == initialVerse) && isPlaying),
      repeatCount: (verse == initialVerse) ? repeatCount : 0,
      togglePlayPause: () => onPressedPlayButton(),
      play10: play10,
      play15: play15,
      play20: play20,
      play5: play5,
      verse: verse,
    );
  }
}
