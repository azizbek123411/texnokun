import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:texnokun/ui/widgets/result_screen.dart';

import '../../provider/quiz_provider.dart';
import '../../service/quiz_service.dart';

class QuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, quizProvider, child) {
        if (quizProvider.questions.isEmpty) {
          return Scaffold(body: Center(child: Text("Loading questions...")));
        }

        final currentQuestion = quizProvider.questions[quizProvider.currentIndex];
        final options = QuranService().generateOptions(currentQuestion, quizProvider.questions);

        return Scaffold(
          appBar: AppBar(title: Text("Quiz")),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  currentQuestion.arabic,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                ...options.map((option) => ElevatedButton(
                      onPressed: () {
                        quizProvider.answerQuestion(option);
                        if (quizProvider.currentIndex >= quizProvider.questions.length - 1) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => ResultScreen()),
                          );
                        }
                      },
                      child: Text(option),
                    )),
              ],
            ),
          ),
        );
      },
    );
  }
}