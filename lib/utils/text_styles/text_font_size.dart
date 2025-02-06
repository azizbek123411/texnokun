
import 'package:texnokun/utils/sizes/screen_utils.dart';

class FontSizeConst {
  static final FontSizeConst _instance = FontSizeConst._init();

  static FontSizeConst get instance => _instance;

  FontSizeConst._init();

  double tinyFont = 10.h;
  double extraSmallFont = 12.h;
  double smallFont = 14.h;
  double mediumFont = 17.h;

  double largeFont = 20.h;
  double extraLargeFont = 24.h;
  double biggestFont = 24.h;
}