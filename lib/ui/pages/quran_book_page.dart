import 'package:flutter/material.dart';
import 'package:texnokun/utils/app_styles/app_colors.dart';

class QuranBookPage extends StatelessWidget {
  const QuranBookPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Rasm fayllarining ro'yxati
    final List<String> imagePaths = List.generate(
      604,
      (index) => 'assets/images/page${(index + 1).toString().padLeft(3, '0')}.png',
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: const Text('Quran Book'),
        centerTitle: true,
      ),
      body: PageView.builder(
        itemCount: imagePaths.length,
        itemBuilder: (context, index) {
          return Center(
            child: Image.asset(
              imagePaths[index],
              fit: BoxFit.contain,
            ),
          );
        },
      ),
    );
  }
}