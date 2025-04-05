import 'package:flutter/material.dart';

import '../service/quiz_service.dart';

class QuizProvider with ChangeNotifier {

bool _isLoading=false;
bool  get isLoading =>_isLoading;

  final QuranService _quranService = QuranService();
  List<AyahModel> _questions = [];
  int _currentIndex = 0;
  int _score = 0;

  List<AyahModel> get questions => _questions;
  int get currentIndex => _currentIndex;
  int get score => _score;

  void startQuiz(int surahNumber) {
    _isLoading=true;
    notifyListeners();
    _questions =  _quranService.getRandomAyahs(surahNumber, 6);
    _currentIndex = 0;
    _score = 0;
    _isLoading=false;
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