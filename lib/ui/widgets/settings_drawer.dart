import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:texnokun/provider/arabic_font_provider.dart';
import 'package:texnokun/utils/app_styles/app_colors.dart';
import 'package:texnokun/utils/text_styles/text_font_size.dart';
import 'package:texnokun/utils/text_styles/text_styles.dart';

import '../../provider/font_size_provider.dart';

class SettingsDrawer extends StatefulWidget {
  SettingsDrawer({super.key});

  @override
  State<SettingsDrawer> createState() => _SettingsDrawerState();
}

class _SettingsDrawerState extends State<SettingsDrawer> {
  bool _autoScrollToCurrentAyah = false;
  bool _showAyahCounter = true;

  @override
  Widget build(BuildContext context) {
    final changeFont = Provider.of<ArabicFontProvider>(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        size: 30,
                        IconlyLight.closeSquare,
                      ),
                    )
                  ],
                ),
                Text(
                  'Advanced Settings',
                  style: AppTextStyle.instance.w600.copyWith(
                    fontSize: FontSizeConst.instance.largeFont,
                  ),
                ),
                Text(
                  textAlign: TextAlign.center,
                  'Customize your Quran reading experiment',
                  style: AppTextStyle.instance.w400.copyWith(
                    fontSize: FontSizeConst.instance.smallFont,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text('Arabic Font Size',
                style: AppTextStyle.instance.w600.copyWith(
                  fontSize: FontSizeConst.instance.smallFont,
                )),
            subtitle: Consumer<FontSizeProvider>(
              builder: (context, fontSizeProvider, child) {
                return Slider(
                  value: fontSizeProvider.arabicFontSize,
                  min: 10.0,
                  max: 50.0,
                  activeColor: AppColors.mainColor,
                  inactiveColor: AppColors.backColor,
                  onChanged: (value) {
                    fontSizeProvider.setArabicFontSize(value);
                  },
                );
              },
            ),
          ),
          ListTile(
            title: Text('Translate Font Size',
                style: AppTextStyle.instance.w600.copyWith(
                  fontSize: FontSizeConst.instance.smallFont,
                )),
            subtitle: Consumer<FontSizeProvider>(
              builder: (context, fontSizeProvider, child) {
                return Slider(
                  value: fontSizeProvider.translateFontSize,
                  min: 10.0,
                  max: 50.0,
                  activeColor: AppColors.mainColor,
                  inactiveColor: AppColors.backColor,
                  onChanged: (value) {
                    fontSizeProvider.setTranslateFontSize(value);
                  },
                );
              },
            ),
          ),
          SwitchListTile(
            activeColor: AppColors.mainColor,
            title: Text('Auto Scroll to Current Ayah',
                style: AppTextStyle.instance.w600.copyWith(
                  fontSize: FontSizeConst.instance.smallFont,
                )),
            value: _autoScrollToCurrentAyah,
            onChanged: (bool value) {
              setState(() {
                _autoScrollToCurrentAyah = value;
              });
            },
          ),
          SwitchListTile(
            activeColor: AppColors.mainColor,
            title: Text('Show Ayah Counter',
                style: AppTextStyle.instance.w600.copyWith(
                  fontSize: FontSizeConst.instance.smallFont,
                )),
            value: _showAyahCounter,
            onChanged: (bool value) {
              setState(() {
                _showAyahCounter = value;
              });
            },
          ),
          Text(
            'Arabic Font Styles',
            textAlign: TextAlign.center,
            style: AppTextStyle.instance.w600.copyWith(
              fontSize: FontSizeConst.instance.mediumFont,
            ),
          ),
          CheckboxListTile(
            activeColor: AppColors.mainColor,
              title: Text(
                'Amiri font',
                style: GoogleFonts.amiri(),
              ),
              value: changeFont.selectedFont == 'Amiri',
              onChanged: (bool? selected) {
                if (selected == true) {
                  changeFont.changeFont('Amiri');
                }
              }),
          CheckboxListTile(
            activeColor: AppColors.mainColor,
              title: Text(
                'Scheherazade font',
                style: GoogleFonts.scheherazadeNew(),
              ),
              value: changeFont.selectedFont == 'Scheherazade',
              onChanged: (bool? selected) {
                if (selected == true) {
                  changeFont.changeFont('Scheherazade');
                }
              }),
          CheckboxListTile(
            activeColor: AppColors.mainColor,
             title: Text(
                'Lateef font',
                style: GoogleFonts.lateef(),
              ),
              value: changeFont.selectedFont == 'Lateef',
              onChanged: (bool? selected) {
                if (selected == true) {
                  changeFont.changeFont('Lateef');
                }
              }),
          CheckboxListTile(
            activeColor: AppColors.mainColor,
             title: Text(
                'Qahiri font',
                style: GoogleFonts.qahiri(),
              ),
              value: changeFont.selectedFont == 'Qahiri',
              onChanged: (bool? selected) {
                if (selected == true) {
                  changeFont.changeFont('Qahiri');
                }
              })
        ],
      ),
    );
  }
}
