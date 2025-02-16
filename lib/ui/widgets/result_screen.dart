import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/quiz_provider.dart';



class ResultDialog extends StatelessWidget {
  const ResultDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Quiz Result"),
      content: Text("Your score is ${Provider.of<QuizProvider>(context).score}"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Close"),
        ),
      ],
    );
  }
}



class ResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final score = Provider.of<QuizProvider>(context).score;
    return Scaffold(
      appBar: AppBar(title: Text("Quiz Result")),
      body: Center(
        child: Text("Your Score: $score", style: TextStyle(fontSize: 24)),
      ),
    );
  }
}