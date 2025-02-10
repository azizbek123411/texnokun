import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quran_flutter/quran.dart';
import 'package:texnokun/provider/font_size_provider.dart';
import 'package:texnokun/provider/provider.dart';
import 'package:texnokun/ui/pages/navbar_pages/mainnavbar.dart';
import 'package:texnokun/utils/app_styles/app_colors.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Quran.initialize();
  await Hive.initFlutter();
  await Hive.openBox('bookmarkBox');
  await Hive.openBox('vocabularyBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BookmarkProvider()),
        ChangeNotifierProvider(create: (_) => FontSizeProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.mainColor),
          useMaterial3: false,
        ),
        home: MainNavBar(),
      ),
    );
  }
}

