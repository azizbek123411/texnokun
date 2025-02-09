import 'package:flutter/material.dart';
import 'package:quran_flutter/quran.dart';
import 'package:texnokun/ui/pages/navbar_pages/mainnavbar.dart';
import 'package:texnokun/utils/app_styles/app_colors.dart';

Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Quran.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.mainColor),
        useMaterial3: false,
      ),
      home: MainNavBar(),
    );
  }
}

