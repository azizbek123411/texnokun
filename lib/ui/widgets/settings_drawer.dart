import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:texnokun/utils/app_styles/app_colors.dart';
import 'package:texnokun/utils/text_styles/text_font_size.dart';
import 'package:texnokun/utils/text_styles/text_styles.dart';

class SettingsDrawer extends StatefulWidget {
  SettingsDrawer({super.key});

  @override
  State<SettingsDrawer> createState() => _SettingsDrawerState();
}

class _SettingsDrawerState extends State<SettingsDrawer> {
  double _arabicFontSize = 16.0;
  double _translateFontSize = 16.0;
  bool _showEnglishTranslation = true;
  bool _showRussianTranslation = false;
  bool _autoScrollToCurrentAyah = false;
  bool _showAyahCounter = true;

  @override
  Widget build(BuildContext context) {
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
            title: Text('Arabic Font Size', style: AppTextStyle.instance.w600.copyWith(
              fontSize: FontSizeConst.instance.smallFont,
            )),
            subtitle: Slider(
              value: _arabicFontSize,
              min: 10.0,
              max: 30.0,
              activeColor: AppColors.mainColor,
              inactiveColor: AppColors.backColor,
              onChanged: (double value) {
                setState(() {
                  _arabicFontSize = value;
                });
              },
            ),
          ),
          ListTile(
            title: Text('Translate Font Size', style: AppTextStyle.instance.w600.copyWith(
              fontSize: FontSizeConst.instance.smallFont,
            )),
            subtitle: Slider(
              value: _translateFontSize,
              min: 10.0,
              max: 30.0,
              activeColor: AppColors.mainColor,
              inactiveColor: AppColors.backColor,
              onChanged: (double value) {
                setState(() {
                  _translateFontSize = value;
                });
              },
            ),
          ),
          SwitchListTile(
                        activeColor: AppColors.mainColor,

            title: Text('Show English Translation', style: AppTextStyle.instance.w600.copyWith(
              fontSize: FontSizeConst.instance.smallFont,
            )),
            value: _showEnglishTranslation,
            onChanged: (bool value) {
              setState(() {
                _showEnglishTranslation = value;
              });
            },
          ),
          SwitchListTile(
                        activeColor: AppColors.mainColor,

            title: Text('Show Russian Translation', style: AppTextStyle.instance.w600.copyWith(
              fontSize: FontSizeConst.instance.smallFont,
            )),
            value: _showRussianTranslation,
            onChanged: (bool value) {
              setState(() {
                _showRussianTranslation = value;
              });
            },
          ),
          SwitchListTile(
                        activeColor: AppColors.mainColor,

            title: Text('Auto Scroll to Current Ayah', style: AppTextStyle.instance.w600.copyWith(
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
            title: Text('Show Ayah Counter', style: AppTextStyle.instance.w600.copyWith(
              fontSize: FontSizeConst.instance.smallFont,
            )),
            value: _showAyahCounter,
            onChanged: (bool value) {
              setState(() {
                _showAyahCounter = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
