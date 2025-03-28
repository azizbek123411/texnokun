// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:texnokun/utils/text_styles/text_font_size.dart';
// import 'package:texnokun/utils/text_styles/text_styles.dart';

// import '../../../provider/quiz_provider.dart';
// import '../../../service/quiz_service.dart';
// import '../../widgets/quiz_screen.dart';

// class QuizPage extends StatefulWidget {
//   @override
//   _QuizPageState createState() => _QuizPageState();
// }

// class _QuizPageState extends State<QuizPage> {
//   late Future<List<SurahModel>> _surahsFuture;

//   @override
//   void initState() {
//     super.initState();
//     _surahsFuture = _loadSurahs();
//   }

//   Future<List<SurahModel>> _loadSurahs() async {
//     return QuranService().getAllSurahs();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder<List<SurahModel>>(
//         future: _surahsFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (snapshot.hasError) {
//             return const Center(child: Text("Xatolik yuz berdi"));
//           } else if (snapshot.hasData) {
//             final surahs = snapshot.data!;
//             return ListView.builder(
//               itemCount: surahs.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   trailing: const Icon(Icons.arrow_forward_ios, size: 20),
//                   title: Text(
//                     surahs[index].name,
//                     style: AppTextStyle.instance.w700.copyWith(
//                       fontSize: FontSizeConst.instance.mediumFont
//                     ),
//                   ),
//                   onTap: () async {
//                     showDialog(
//                       context: context,
//                       builder: (context) => const Center(
//                         child: CircularProgressIndicator(),
//                       ),
//                     );

//                     await Future.delayed(const Duration(milliseconds: 500));

//                     Provider.of<QuizProvider>(context, listen: false)
//                         .startQuiz(surahs[index].number);

//                     Navigator.pop(context);
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute (
//                         builder: (context) => QuizScreen(),
//                       ),
//                     );
//                   },
//                 );
//               },
//             );
//           } else {
//             return const Center(child: const Text("No data available"));
//           }
//         },
//       ),
//     );
//   }
// }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backColor,
      body: ListView.builder(
          itemCount: surahList.length,
          itemBuilder: (context, index) {
            final surahName = Quran.getSurahNameEnglish(index + 1);
            return ListTile(
              onTap: ()async{
                showDialog(
                      context: context,
                      builder: (context) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );

                    await Future.delayed(const Duration(milliseconds: 300));

                    Provider.of<QuizProvider>(context, listen: false)
                        .startQuiz(index+1);

                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute (
                        builder: (context) => QuizScreen(),
                      ),
                    );
                  },
              
              trailing:  const Icon(Icons.arrow_forward_ios,size: 20,),
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
