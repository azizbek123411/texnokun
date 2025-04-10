import 'package:flutter/material.dart';
import 'package:quran_flutter/enums/quran_language.dart';
import 'package:quran_flutter/models/verse.dart';
import 'package:quran_flutter/quran.dart';
import 'package:texnokun/ui/widgets/surah_detail.dart';

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