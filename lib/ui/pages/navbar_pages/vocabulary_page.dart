import 'package:flutter/material.dart';
import 'package:texnokun/utils/app_styles/app_colors.dart';

class VocabularyPage extends StatefulWidget {
  @override
  _VocabularyPageState createState() => _VocabularyPageState();
}

class _VocabularyPageState extends State<VocabularyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backColor,
      body: Center(
        child: Text('Vocabulary Page', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}