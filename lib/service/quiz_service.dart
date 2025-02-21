import 'package:quran/quran.dart' as quran;

class SurahModel {
  final int number;
  final String name;
  final List<AyahModel> ayahs;

  SurahModel({required this.number, required this.name, required this.ayahs});
}

class AyahModel {
  final int number;
  final String arabic;
  final String translation;

  AyahModel({required this.number, required this.arabic, required this.translation});
}

class QuranService {
  List<SurahModel>? _cachedSurahs;
   List<SurahModel> getAllSurahs() {
    if (_cachedSurahs != null) {
      return _cachedSurahs!;
    }

    _cachedSurahs = List.generate(114, (index) {
      int surahNumber = index + 1;
      List<AyahModel> ayahs = List.generate(quran.getVerseCount(surahNumber), (i) {
        return AyahModel(
          number: i + 1,
          arabic: quran.getVerse(surahNumber, i + 1),
          translation: quran.getVerseTranslation(surahNumber, i + 1),
        );
      });
      return SurahModel(
        number: surahNumber,
        name: quran.getSurahName(surahNumber),
        ayahs: ayahs,
      );
    });

    return _cachedSurahs!;
  }


  List<AyahModel> getRandomAyahs(int surahNumber, int count) {
    List<AyahModel> ayahs = getAllSurahs()
        .firstWhere((s) => s.number == surahNumber)
        .ayahs;
    ayahs.shuffle();
    return ayahs.take(count).toList();
  }

  List<String> generateOptions(AyahModel correctAyah, List<AyahModel> allAyahs) {
    List<String> options = [correctAyah.translation];
    allAyahs.shuffle();
    for (var ayah in allAyahs) {
      if (options.length >= 4) break;
      if (ayah.translation != correctAyah.translation) {
        options.add(ayah.translation);
      }
    }
    options.shuffle();
    return options;
  }
}
