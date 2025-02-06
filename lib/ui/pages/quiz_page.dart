import 'package:flutter/material.dart';
import 'package:texnokun/utils/app_styles/app_colors.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backColor,
      body: Center(
        child: Text(
          'Quiz Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
