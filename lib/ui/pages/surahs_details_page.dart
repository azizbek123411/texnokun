import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:texnokun/models/surahs.dart';
import 'package:texnokun/ui/widgets/surah_detail.dart';
import 'package:texnokun/utils/app_styles/app_colors.dart';
import 'package:texnokun/utils/text_styles/text_styles.dart';

import '../../utils/text_styles/text_font_size.dart';

class SurahsDetailsPage extends StatefulWidget {
  final SurahsModel surah;
  const SurahsDetailsPage({super.key, required this.surah});

  @override
  State<SurahsDetailsPage> createState() => _SurahsDetailsPageState();
}

class _SurahsDetailsPageState extends State<SurahsDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            IconlyLight.arrowLeft2,
            color: Colors.black,
          ),
        ),
        backgroundColor: AppColors.whiteColor,
        title: Text(
          widget.surah.surahName.toString(),
          style: AppTextStyle.instance.w900.copyWith(
            color: AppColors.mainColor,
            fontSize: FontSizeConst.instance.largeFont,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SurahDetail(surah: widget.surah),
        ),
      ),
    );
  }
}
