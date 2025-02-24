import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
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
        ],
      ),
    );
  }
}
