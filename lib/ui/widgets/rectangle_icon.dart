import 'package:flutter/material.dart';

import '../../utils/app_styles/app_colors.dart';
import '../../utils/sizes/app_padding.dart';

class RectangleIcon extends StatelessWidget {
  final Widget icon;
  final double height;
  final double width;
  final Color? color;
  void Function() onTap;
  RectangleIcon({
    super.key,
    required this.icon,
    required this.onTap,
    required this.height, 
    required this.width,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,

        padding: Dis.all(5),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey, 
            width: 1,
          ),
          borderRadius: BorderRadius.circular(5),
          shape: BoxShape.rectangle,
         color: color ?? AppColors.whiteColor,
        ),
        child: Center(child: icon),
      ),
    );
  }
}
