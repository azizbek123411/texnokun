import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:texnokun/utils/app_styles/app_colors.dart';
import 'package:texnokun/utils/sizes/app_padding.dart';
import 'package:texnokun/utils/sizes/screen_utils.dart';
import 'package:texnokun/utils/text_styles/text_styles.dart';

import '../../../utils/text_styles/text_font_size.dart';

class VocabularyPage extends StatefulWidget {
  @override
  _VocabularyPageState createState() => _VocabularyPageState();
}

class _VocabularyPageState extends State<VocabularyPage> {
  List<Map<dynamic, dynamic>> words = [];
  TextEditingController wordController = TextEditingController();
  TextEditingController meaningController = TextEditingController();
  late Box box;

  @override
  void initState() {
    super.initState();
    box = Hive.box('vocabularyBox');
    _loadWords();
  }

  void _loadWords() {
    final savedWords = box.get('words', defaultValue: []);
    setState(() {
      words = List<Map<dynamic, dynamic>>.from(savedWords);
    });
  }

  void _saveWords() {
    box.put('words', words);
  }

  void _addWord(String word, String meaning) {
    setState(() {
      words.add({'word': word, 'meaning': meaning});
      _saveWords();
    });
  }

  void _showAddWordDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Word'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: wordController,
                decoration: InputDecoration(
                  labelText: 'New Word',
                ),
              ),
              TextField(
                controller: meaningController,
                decoration: InputDecoration(
                  labelText: 'Meaning',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _addWord(wordController.text, meaningController.text);
                wordController.clear();
                meaningController.clear();
                Navigator.of(context).pop();
              },
              child: Text('Add Word'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backColor,
      
      body: words.isNotEmpty? ListView.builder(
        itemCount: words.length,
        itemBuilder: (context, index) {
          return Container(
            margin: Dis.only(top: 8.h,lr: 10.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.backColor),
            ),
            child: ListTile(
              title: Text(words[index]['word']!,style: AppTextStyle.instance.w700.copyWith(
                fontSize: FontSizeConst.instance.largeFont,
              ),),
              subtitle: Text(words[index]['meaning']!,style: AppTextStyle.instance.w400.copyWith(
                fontSize: FontSizeConst.instance.mediumFont,),
            ),
          ),
          );
        },
      ):Center(
        child: Text('No words added yet!',style: AppTextStyle.instance.w600.copyWith(
          fontSize: 20,
          color: AppColors.appColor  
        ),),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.mainColor,
        onPressed: _showAddWordDialog,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}