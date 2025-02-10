import 'package:flutter/material.dart';
import 'package:quran_flutter/quran.dart';
import 'package:texnokun/utils/app_styles/app_colors.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
   final List<String> surahNames = List.generate(
    Quran.surahCount, 
    (index) => Quran.getSurahName(index + 1), // Surah numbers start from 1
  );

  List surahs = Quran.getSurahAsList();
  Map surahMap = Quran.getSurahAsMap();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backColor,
      body: ListView.builder(
        itemCount: surahNames.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("${index + 1}. ${surahNames[index]}"),
          );
        },
      ),
    );
    
  }
}
