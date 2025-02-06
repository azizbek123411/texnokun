import 'package:flutter/material.dart';
import 'package:texnokun/utils/sizes/screen_utils.dart';
import 'package:texnokun/utils/text_styles/text_font_size.dart';
import 'package:texnokun/utils/text_styles/text_styles.dart';

import '../../models/surahs.dart';

class SurahCard extends StatelessWidget {
  final Surahs sura;
  const SurahCard({
    super.key,
    required this.sura,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
    
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        title: Text(sura.surahName.toString(),style: AppTextStyle.instance.w900.copyWith(
          fontSize: FontSizeConst.instance.largeFont,
        ),),
        subtitle: Text('Surah ${sura.surahNumber.toString()}',style: AppTextStyle.instance.w300.copyWith(
          fontSize: FontSizeConst.instance.smallFont,
        ),),
      ),
    );
  }
}
