import 'package:flutter/material.dart';
import 'package:texnokun/ui/widgets/rectangle_icon.dart';

import '../../models/surahs.dart';

class SurahDetail extends StatefulWidget {
  final Surahs surah;
  const SurahDetail({super.key, required this.surah});

  @override
  State<SurahDetail> createState() => _SurahDetailState();
}

class _SurahDetailState extends State<SurahDetail> {
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
      child: Column(
        children: [
          Row(
            children: [
              // RectangleIcon(icon: , onTap: onTap)
            ],
          ),
        ],
      ),
    );
  }
}
