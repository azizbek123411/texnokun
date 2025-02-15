import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/quiz_provider.dart';
import '../../../service/quiz_service.dart';
import '../../widgets/quiz_screen.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
     final quranService = QuranService();
    final surahs = quranService.getAllSurahs();
    return Scaffold(
    
      body: ListView.builder(
        itemCount: surahs.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(surahs[index].name),
            onTap: () {
              Provider.of<QuizProvider>(context, listen: false)
                  .startQuiz(surahs[index].number);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QuizScreen()),
              );
            },
          );
        },
      ),
    );
  }
}