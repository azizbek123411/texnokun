class Surahs {
  final String? surahName;
  final int? surahNumber;
  final String? englishAyahs;
  final int? ayahsCount;
  final String? arabicAyahs;
  final String? russianAyahs;

  Surahs({
    this.surahName,
    this.surahNumber,
    this.englishAyahs,
    this.arabicAyahs,
    this.ayahsCount,
    this.russianAyahs
  });
}
  List surahsData=[

Surahs(
    surahName: 'Al-Fatihah',
    surahNumber: 1,
    englishAyahs: 'In the Name of Allah—the Most Compassionate, Most Merciful.',
    arabicAyahs: 'بِسْمِ ٱللَّهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ',
    russianAyahs: 'С именем Аллаха Милостивого, Милосердного!',
    ayahsCount: 7, 
  ),
  Surahs(
    surahName: 'Al-Baqarah',
    surahNumber: 2,
    englishAyahs: 'Alif-Lãm-Mĩm.',
    arabicAyahs: 'الٓمٓ',
    russianAyahs: 'Алиф лам мим.',
    ayahsCount: 286, 
  ),
    
  ];
  
