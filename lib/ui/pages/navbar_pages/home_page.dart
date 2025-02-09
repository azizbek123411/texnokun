import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:texnokun/models/surahs.dart';
import 'package:texnokun/ui/widgets/rectangle_icon.dart';
import 'package:texnokun/ui/widgets/surah_card.dart';
import 'package:texnokun/utils/app_styles/app_colors.dart';
import 'package:texnokun/utils/sizes/app_padding.dart';
import 'package:texnokun/utils/sizes/screen_utils.dart';
import 'package:texnokun/utils/text_styles/text_font_size.dart';
import 'package:texnokun/utils/text_styles/text_styles.dart';

import '../surahs_details_page.dart';

class HomePage extends StatefulWidget {
  final SurahsModel surahs;
  const HomePage({
    super.key,
    required this.surahs,
  });

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backColor,
      body: Padding(
        padding: Dis.only(
          lr: 15.w,
          tb: 10.h,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Quran Surahs",
                style: AppTextStyle.instance.w700.copyWith(
                  fontSize: FontSizeConst.instance.extraLargeFont,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                height: 40.h,
                // width: 50.w,
                child: Row(
                  children: [
                    SizedBox(
                      height: 40.h,
                      width: 250.w,
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: Dis.only(top: 10.h, right: 5.w),
                          prefixIcon: const Icon(
                            IconlyLight.search,
                            size: 20,
                          ),
                          hintText: 'Search surahs...',
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.mainColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30.w,
                    ),
                    RectangleIcon(
                      icon: const Icon(IconlyLight.category),
                      onTap: () {},
                      height: 35.h,
                      width: 35.w,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    RectangleIcon(
                      icon: const Icon(Icons.menu),
                      onTap: () {},
                      height: 35.h,
                      width: 35.w,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                height: 1000.h,
                width: 800.w,
                child: GridView.builder(
                    itemCount: surahsData.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 2.6,
                      crossAxisCount: 2,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                    ),
                    itemBuilder: (context, index) {
                      return SurahCard(
                        sura: surahsData[index],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SurahsDetailsPage(
                                surah: surahsData[index],
                              ),
                            ),
                          );
                        },
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
