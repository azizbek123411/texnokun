import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../../utils/app_styles/app_colors.dart';
import '../../utils/sizes/app_padding.dart';

class RectangleIcon extends StatelessWidget {
  final IconData icon;
  void Function() onTap;
  RectangleIcon({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: Dis.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          shape: BoxShape.rectangle,
          color: AppColors.whiteColor,
        ),
        child: Icon(icon),
      ),
    );
  }
}
