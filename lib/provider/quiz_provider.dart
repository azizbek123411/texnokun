import 'package:flutter/material.dart';

import '../service/quiz_service.dart';

class QuizProvider with ChangeNotifier {
  final QuranService _quranService = QuranService();
  List<AyahModel> _questions = [];
  int _currentIndex = 0;
  int _score = 0;

  List<AyahModel> get questions => _questions;
  int get currentIndex => _currentIndex;
  int get score => _score;

  void startQuiz(int surahNumber) {
    _questions =  _quranService.getRandomAyahs(surahNumber, 5);
    _currentIndex = 0;
    _score = 0;
    notifyListeners();
  }

  void answerQuestion(String selectedAnswer) {
    if (_questions[_currentIndex].translation == selectedAnswer) {
      _score++;
    }
    if (_currentIndex < _questions.length - 1) {
      _currentIndex++;
    }
    notifyListeners();
  }
}