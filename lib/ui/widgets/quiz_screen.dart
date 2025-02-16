import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:texnokun/ui/widgets/result_screen.dart';
import 'package:texnokun/utils/app_styles/app_colors.dart';
import 'package:texnokun/utils/sizes/app_padding.dart';
import 'package:texnokun/utils/sizes/screen_utils.dart';
import 'package:texnokun/utils/text_styles/text_font_size.dart';
import 'package:texnokun/utils/text_styles/text_styles.dart';

import '../../provider/quiz_provider.dart';
import '../../service/quiz_service.dart';

class QuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, quizProvider, child) {
        if (quizProvider.questions.isEmpty) {
          return const Scaffold(body: Center(child: Text("Loading questions...")));
        }

        final currentQuestion =
            quizProvider.questions[quizProvider.currentIndex];
        final options = QuranService()
            .generateOptions(currentQuestion, quizProvider.questions);

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: AppColors.mainColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: Colors.white,
            title: const Text(
              "Quiz",
              style:  TextStyle(
                color: AppColors.mainColor,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  currentQuestion.arabic,
                  style: AppTextStyle.instance.w700.copyWith(fontSize: FontSizeConst.instance.extraLargeFont,),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ...options.map((option) => Padding(
                  padding: Dis.only(tb: 5.h),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.backColor,
                      border: Border.all(color: AppColors.backColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      onTap: () {
                        quizProvider.answerQuestion(option);
                        if (quizProvider.currentIndex >=
                            quizProvider.questions.length - 1) {
                        showDialog(context: context, builder: (context){
                          return const ResultDialog();
                        });
                        }
                        Navigator.pop(context);
                      }, 
                      title: Text(option), 
                    ),
                  ),
                ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
///Text(option),


/// onPressed: () {
                        // quizProvider.answerQuestion(option);
                        // if (quizProvider.currentIndex >=
                        //     quizProvider.questions.length - 1) {
                        //   Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => ResultScreen()),
                        //   );
                        // }
                      