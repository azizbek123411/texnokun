import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_flutter/quran.dart';
import 'package:texnokun/utils/app_styles/app_colors.dart';
import 'package:texnokun/utils/text_styles/text_font_size.dart';
import 'package:texnokun/utils/text_styles/text_styles.dart';

import '../../../provider/quiz_provider.dart';
import '../../widgets/quiz_screen.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final surahList = Quran.getSurahAsList();
_showCircular(){
  return showDialog(context: context, builder: (context){
    return const Center(
      child: CircularProgressIndicator()
    ) ;
  });
  
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backColor,
      body: ListView.builder(
          itemCount: surahList.length,
          itemBuilder: (context, index) {
            final surahName = Quran.getSurahNameEnglish(index + 1);
            return ListTile(
              onTap: () async {
                _showCircular();
                await Future.delayed(const Duration(milliseconds: 300),
                
                );
                
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizScreen(),
                  ),
                );
                Provider.of<QuizProvider>(context, listen: false)
                    .startQuiz(index + 1);
              },
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 20,
              ),
              title: Text(
                surahName,
                style: AppTextStyle.instance.w600
                    .copyWith(fontSize: FontSizeConst.instance.mediumFont),
              ),
            );
          }),
    );
  }
}
