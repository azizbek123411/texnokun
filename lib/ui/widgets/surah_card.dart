import 'package:flutter/material.dart';
import 'package:texnokun/utils/sizes/app_padding.dart';
import 'package:texnokun/utils/text_styles/text_font_size.dart';
import 'package:texnokun/utils/text_styles/text_styles.dart';



class SurahCard extends StatelessWidget {
  final String surahName;
  final int surahNumber;
  void Function() onTap;
   SurahCard({
    super.key,
    required this.surahName,
    required this.onTap,
    required this.surahNumber,
  });

  @override
  Widget build(BuildContext context) {
  
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: Dis.only(bottom: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 1,
              blurRadius: 5,
              offset:  Offset(0, 3),
            ),
          ],
        ),
        child: ListTile(
          title: Text(surahName.toString(),style: AppTextStyle.instance.w900.copyWith(
            fontSize: FontSizeConst.instance.largeFont,
          ),),
          subtitle: Text('Surah ${surahNumber.toString()}',style: AppTextStyle.instance.w300.copyWith(
            fontSize: FontSizeConst.instance.smallFont,
          ),),
        ),
      ),
    );
  }
}
