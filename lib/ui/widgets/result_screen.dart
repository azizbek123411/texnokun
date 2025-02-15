import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/quiz_provider.dart';

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