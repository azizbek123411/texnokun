import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:quran_flutter/quran.dart';
import 'package:texnokun/ui/widgets/rectangle_icon.dart';
import 'package:texnokun/ui/widgets/surah_card.dart';
import 'package:texnokun/utils/app_styles/app_colors.dart';
import 'package:texnokun/utils/sizes/app_padding.dart';
import 'package:texnokun/utils/sizes/screen_utils.dart';
import 'package:texnokun/utils/text_styles/text_font_size.dart';
import 'package:texnokun/utils/text_styles/text_styles.dart';

import '../surahs_details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final List<String> surahNames = List.generate(
    Quran.surahCount,
    (index) => Quran.getSurahNameEnglish(index + 1), // Surah numbers start from 1
  );

  List<String> filteredSurahNames = [];
  TextEditingController searchController = TextEditingController();
  bool isGridView = true;

  @override
  void initState() {
    super.initState();
    filteredSurahNames = surahNames;
  }

  void filterSurahs(String query) {
    final filtered = surahNames.where((surah) {
      final surahLower = surah.toLowerCase();
      final queryLower = query.toLowerCase();
      return surahLower.contains(queryLower);
    }).toList();

    setState(() {
      filteredSurahNames = filtered;
    });
  }

  void toggleView() {
    setState(() {
      isGridView = !isGridView;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backColor,
        body: Padding(
          padding: Dis.only(
            lr: 15.w,
            top: 10.h,
          
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
                  child: Row(
                    children: [
                      SizedBox(
                        height: 40.h,
                        width: 250.w,
                        child: TextField(
                          controller: searchController,
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
                          onChanged: filterSurahs,
                        ),
                      ),
                      SizedBox(
                        width: 30.w,
                      ),
                      RectangleIcon(
                        icon: Icon(
                          IconlyLight.category,
                          color: isGridView ? AppColors.mainColor : Colors.grey,
                        ),
                        onTap: toggleView,
                        height: 35.h,
                        width: 35.w,
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      RectangleIcon(
                        icon: Icon(
                          Icons.menu,
                          color: !isGridView ? AppColors.mainColor : Colors.grey,
                        ),
                        onTap: toggleView,
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
                  child: isGridView
                      ? GridView.builder(
                          itemCount: filteredSurahNames.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 2.6,
                            crossAxisCount: 2,
                            mainAxisSpacing: 10.0,
                            crossAxisSpacing: 10.0,
                          ),
                          itemBuilder: (context, index) {
                            return SurahCard(
                              surahName: filteredSurahNames[index],
                              surahNumber: surahNames.indexOf(filteredSurahNames[index]) + 1,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SurahsDetailsPage(
                                      surahNumber: surahNames.indexOf(filteredSurahNames[index]) + 1,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        )
                      : ListView.builder(
                          itemCount: filteredSurahNames.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(filteredSurahNames[index]),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SurahsDetailsPage(
                                      surahNumber: surahNames.indexOf(filteredSurahNames[index]) + 1,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
