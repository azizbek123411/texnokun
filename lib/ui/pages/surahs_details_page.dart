import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quran_flutter/enums/quran_language.dart';
import 'package:quran_flutter/models/surah.dart';
import 'package:quran_flutter/models/verse.dart';
import 'package:quran_flutter/quran.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:texnokun/ui/widgets/rectangle_icon.dart';
import 'package:texnokun/ui/widgets/surah_detail.dart';
import 'package:texnokun/utils/app_styles/app_colors.dart';
import 'package:texnokun/utils/sizes/app_padding.dart';

import 'package:texnokun/utils/text_styles/text_styles.dart';

import '../../service/audio_service.dart';
import '../../utils/text_styles/text_font_size.dart';

class SurahsDetailsPage extends StatefulWidget {
  final int surahNumber;

  const SurahsDetailsPage({
    super.key,
    required this.surahNumber,
  });

  @override
  State<SurahsDetailsPage> createState() => _SurahsDetailsPageState();
}

class _SurahsDetailsPageState extends State<SurahsDetailsPage> {
  bool _isFabVisible = false;

  late Verse _initialVerse;
  bool _isPlaying = false;
  int _repeatCount = 1;
  int _currentRepeat = 0;
  final player = AudioPlayer();
  final _audioService = AudioServices();
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  late FToast fToast;
  late int currentIndex;
  late PageController _pageController;
  int currentSurahIndex = 0;
  Surah get surah => Quran.getSurah(widget.surahNumber);

  List<ItemScrollController> scrollControllers =
      List.generate(114, (_) => ItemScrollController(), growable: true);

  List<ItemPositionsListener> positionsListeners =
      List.generate(114, (_) => ItemPositionsListener.create());

  List<ScrollOffsetController> scrollOffsetControllers =
      List.generate(114, (_) => ScrollOffsetController());

  List<ScrollOffsetListener> scrollOffsetListeners =
      List.generate(114, (_) => ScrollOffsetListener.create());

  int _initialIndex = 0;

  void chooseVerse(int index) {
    scrollControllers[widget.surahNumber].scrollTo(
        index: index,
        duration: const Duration(
          milliseconds: 150,
        ),
        curve: Curves.bounceIn);
  }

  _showToasT() {
    final toast = Container(
      padding: Dis.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: AppColors.mainColor,
      ),
      child: const Text(
        'Please,wait until loading',
        style: TextStyle(
          color: AppColors.whiteColor,
        ),
      ),
    );

    fToast.showToast(
      child: toast,
      toastDuration: const Duration(seconds: 3),
      gravity: ToastGravity.CENTER,
    );
    return;
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter bottomSheetSetState) {
            player.onPositionChanged.listen(
              (newPosition) {
                bottomSheetSetState(
                  () {
                    position = newPosition;
                  },
                );
              },
            );
            return Container(
              padding: const EdgeInsets.all(16.0),
              height: MediaQuery.of(context).size.height * 0.15,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Slider(
                    onChanged: (value) async {
                      final newPosition = Duration(seconds: value.toInt());
                      await player.seek(newPosition);
                      setState(() {
                        position = newPosition;
                      });
                    },
                    autofocus: true,
                    activeColor: AppColors.mainColor,
                    min: 0,
                    value: position.inSeconds
                        .clamp(0, duration.inSeconds)
                        .toDouble(),
                    max: duration.inSeconds.toDouble(),
                    onChangeStart: (value) {
                      player.pause();
                    },
                    onChangeEnd: (value) async {
                      final newPosition = Duration(seconds: value.toInt());
                      await player.seek(newPosition);
                      await player.resume();
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          icon: const Icon(Icons.skip_previous),
                          onPressed: () async {
                            if (_currentRepeat < _repeatCount - 1) {
                              _currentRepeat++;
                              if (_initialVerse.verseNumber > 1) {
                                final audioPath =
                                    await _audioService.downloadAudio(
                                        widget.surahNumber,
                                        _initialVerse.verseNumber);
                                await player
                                    .play(DeviceFileSource(audioPath))
                                    .then(
                                      (_) => setState(() => _isPlaying = true),
                                    );
                              } else {
                                return;
                              }
                            }
                            if (_initialVerse.verseNumber > 0) {
                              if (surah.verseCount >
                                  _initialVerse.verseNumber) {
                                _currentRepeat = 0;

                                final oldVerseNumber =
                                    _initialVerse.verseNumber - 1;
                                _initialVerse = Quran.getVerse(
                                    surahNumber: surah.number,
                                    verseNumber: oldVerseNumber);
                                final audioPath =
                                    await _audioService.downloadAudio(
                                        widget.surahNumber,
                                        _initialVerse.verseNumber);
                                await player
                                    .play(DeviceFileSource(audioPath))
                                    .then(
                                      (_) => setState(() => _isPlaying = true),
                                    );

                                scrollControllers[widget.surahNumber].scrollTo(
                                  index: _initialVerse.verseNumber - 1,
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeInOutCubic,
                                );
                              }
                            } else {
                              setState(() {
                                _isPlaying = false;
                              });
                            }
                          }),
                      IconButton(
                        icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                        onPressed: () {
                          if (_isPlaying) {
                            player.pause();
                          } else {
                            player.resume();
                          }
                          setState(() {
                            _isPlaying = !_isPlaying;
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.skip_next),
                        onPressed: () async {
                          _showToasT();
                          if (_currentRepeat < _repeatCount - 1) {
                            _currentRepeat++;

                            final audioPath = await _audioService.downloadAudio(
                                widget.surahNumber, _initialVerse.verseNumber);
                            await player.play(DeviceFileSource(audioPath)).then(
                                  (_) => setState(() => _isPlaying = true),
                                );
                          } else if (surah.verseCount >
                              _initialVerse.verseNumber) {
                            _currentRepeat = 0;

                            final oldVerseNumber =
                                _initialVerse.verseNumber + 1;
                            _initialVerse = Quran.getVerse(
                                surahNumber: surah.number,
                                verseNumber: oldVerseNumber);
                            final audioPath = await _audioService.downloadAudio(
                                widget.surahNumber, _initialVerse.verseNumber);
                            await player.play(DeviceFileSource(audioPath)).then(
                                  (_) => setState(() => _isPlaying = true),
                                );

                            scrollControllers[widget.surahNumber].scrollTo(
                              index: _initialVerse.verseNumber - 1,
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeInOutCubic,
                            );
                          } else {
                            setState(() {
                              _isPlaying = false;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    ).whenComplete(() {
      player.stop();
      setState(() {
        _isPlaying = false;
      });
    });
  }

  void _onPressedPlayButton(Verse verse) async {
    setState(() {});
    if (_isPlaying) {
      await player.stop().then((_) => setState(() => _isPlaying = false));

      return;
    }
    _showToasT();
    _initialVerse = verse;
    final audioPath = await _audioService.downloadAudio(
        widget.surahNumber, verse.verseNumber);

    await player
        .play(DeviceFileSource(audioPath))
        .then((_) => setState(() => _isPlaying = true));

    _showBottomSheet();
  }

  void _audioPlayerListener() {
    player.onPlayerComplete.listen((event) async {
      if (_currentRepeat < _repeatCount - 1) {
        _currentRepeat++;

        final audioPath = await _audioService.downloadAudio(
            widget.surahNumber, _initialVerse.verseNumber);
        await player.play(DeviceFileSource(audioPath)).then(
              (_) => setState(() => _isPlaying = true),
            );
      } else if (surah.verseCount > _initialVerse.verseNumber) {
        _currentRepeat = 0;

        final oldVerseNumber = _initialVerse.verseNumber + 1;
        _initialVerse = Quran.getVerse(
            surahNumber: surah.number, verseNumber: oldVerseNumber);
        final audioPath = await _audioService.downloadAudio(
            widget.surahNumber, _initialVerse.verseNumber);
        await player.play(DeviceFileSource(audioPath)).then(
              (_) => setState(() => _isPlaying = true),
            );

        scrollControllers[widget.surahNumber].scrollTo(
          index: _initialVerse.verseNumber - 1,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOutCubic,
        );
      } else {
        setState(() {
          _isPlaying = false;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    currentIndex = widget.surahNumber - 1;
    _pageController = PageController(initialPage: currentIndex);
    fToast = FToast();
    currentSurahIndex = widget.surahNumber;
    fToast.init(context);

    player.onPlayerStateChanged.listen((state) {
      setState(() {
        _isPlaying = state == PlayerState.playing;
      });
    });

    player.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    player.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
    positionsListeners[widget.surahNumber].itemPositions.addListener(() {
      final positions =
          positionsListeners[widget.surahNumber].itemPositions.value;

      if (positions.isNotEmpty && positions.first.index > 1) {
        if (!_isFabVisible) {
          setState(() {
            _isFabVisible = true;
          });
        }
      } else {
        if (_isFabVisible) {
          setState(() {
            _isFabVisible = false;
          });
        }
      }
    });

    setState(() {
      _initialVerse =
          Quran.getVerse(surahNumber: widget.surahNumber, verseNumber: 1);
    });

    _audioPlayerListener();
  }

  @override
  void dispose() {
    player.dispose();
    _pageController.dispose();
    scrollOffsetControllers[widget.surahNumber];
    scrollOffsetListeners[widget.surahNumber];
    positionsListeners[widget.surahNumber];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final list = Quran.getSurahVersesAsList(widget.surahNumber);

    return Scaffold(
      backgroundColor: AppColors.backColor,
      body: SurahContentPage(
        surahNumber: widget.surahNumber,
        scrollController: scrollControllers[widget.surahNumber],
        positionsListener: positionsListeners[widget.surahNumber],
        list: list,
        initialVerse: _initialVerse,
        isPlaying: _isPlaying,
        repeatCount: _repeatCount,
        onPressedPlayButton: () {
          _onPressedPlayButton(_initialVerse);
        },
        play5: () {
          setState(() {
            _repeatCount = 5;
            _currentRepeat = 0;
          });
          _onPressedPlayButton(_initialVerse);
        },
        play10: () {
          setState(() {
            _repeatCount = 10;
            _currentRepeat = 0;
          });
          _onPressedPlayButton(_initialVerse);
        },
        play15: () {
          setState(() {
            _repeatCount = 15;
            _currentRepeat = 0;
          });
          _onPressedPlayButton(_initialVerse);
        },
        play20: () {
          setState(() {
            _repeatCount = 20;
            _currentRepeat = 0;
          });
          _onPressedPlayButton(_initialVerse);
        },
        scrollOffsetController: scrollOffsetControllers[widget.surahNumber],
        scrollOffsetListener: scrollOffsetListeners[widget.surahNumber],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _isFabVisible
          ? Container(
              padding: Dis.only(tb: 8, lr: 5),
              decoration: BoxDecoration(
                  color: AppColors.backColor,
                  borderRadius: BorderRadius.circular(10)),
              height: MediaQuery.of(context).size.height * 0.09,
              width: MediaQuery.of(context).size.width * 0.7,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: Dis.only(lr: 3),
                      child: RectangleIcon(
                        icon: Text('${index + 1}'),
                        onTap: () {
                          chooseVerse(index);
                          setState(() {
                            _initialIndex = index;
                          });
                        },
                        height: 40,
                        width: 50,
                        color: _initialIndex == index
                            ? AppColors.mainColor
                            : AppColors.whiteColor,
                      ),
                    );
                  }),
            )
          : null,
    );
  }
}

class SurahContentPage extends StatelessWidget {
  final int surahNumber;
  final ItemScrollController scrollController;
  final ItemPositionsListener positionsListener;
  final List list;
  final Verse initialVerse;
  bool isPlaying;
  int repeatCount;
  final void Function() play5;
  final void Function() onPressedPlayButton;
  final void Function() play10;
  final void Function() play15;
  final void Function() play20;
  final ScrollOffsetController scrollOffsetController;
  final ScrollOffsetListener scrollOffsetListener;

  SurahContentPage({
    super.key,
    required this.surahNumber,
    required this.scrollController,
    required this.positionsListener,
    required this.list,
    required this.initialVerse,
    required this.isPlaying,
    required this.repeatCount,
    required this.onPressedPlayButton,
    required this.play5,
    required this.play10,
    required this.play15,
    required this.play20,
    required this.scrollOffsetController,
    required this.scrollOffsetListener,
  });

  @override
  Widget build(BuildContext context) {
    String surahName = Quran.getSurahNameEnglish(surahNumber);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            IconlyLight.arrowLeft2,
            color: Colors.black,
          ),
        ),
        backgroundColor: AppColors.whiteColor,
        title: Text(
          surahName.toString(),
          style: AppTextStyle.instance.w900.copyWith(
            color: AppColors.mainColor,
            fontSize: FontSizeConst.instance.largeFont,
          ),
        ),
      ),
      body: ScrollablePositionedList.builder(
          itemCount: list.length,
          itemScrollController: scrollController,
          scrollOffsetController: scrollOffsetController,
          itemPositionsListener: positionsListener,
          scrollOffsetListener: scrollOffsetListener,
          itemBuilder: (context, index) {
            final item = list[index];

            return SurahDetailItemScreen(
              verse: item,
              initialVerse: initialVerse,
              isPlaying: isPlaying,
              repeatCount: repeatCount,
              surahNumber: surahNumber,
              onPressedPlayButton: onPressedPlayButton,
              play10: play10,
              play20: play20,
              play15: play15,
              play5: play5,
            );
          }),
    );
  }
}

class SurahDetailItemScreen extends StatelessWidget {
  final Verse verse;
  final int surahNumber;
  final int repeatCount;
  final Verse initialVerse;
  final bool isPlaying;
  final void Function() onPressedPlayButton;
  final void Function() play5;
  final void Function() play10;
  final void Function() play15;
  final void Function() play20;

  const SurahDetailItemScreen(
      {super.key,
      required this.verse,
      required this.surahNumber,
      required this.initialVerse,
      required this.isPlaying,
      required this.onPressedPlayButton,
      required this.repeatCount,
      required this.play10,
      required this.play5,
      required this.play20,
      required this.play15});

  @override
  Widget build(BuildContext context) {
    final itemEnglishVerse = Quran.getVerse(
        surahNumber: verse.surahNumber,
        verseNumber: verse.verseNumber,
        language: QuranLanguage.english);
    final itemRussianVerse = Quran.getVerse(
        surahNumber: verse.surahNumber,
        verseNumber: verse.verseNumber,
        language: QuranLanguage.russian);
    final itemArabicVerse = Quran.getVerse(
      surahNumber: verse.surahNumber,
      verseNumber: verse.verseNumber,
    );

    return SurahDetail(
      arabicAyahs: itemArabicVerse.text,
      englishAyahs: itemEnglishVerse.text,
      russianAyahs: itemRussianVerse.text,
      verseCount: verse.verseNumber,
      surahCount: surahNumber,
      isPlaying: ((verse == initialVerse) && isPlaying),
      repeatCount: (verse == initialVerse) ? repeatCount : 0,
      togglePlayPause: () => onPressedPlayButton(),
      play10: play10,
      play15: play15,
      play20: play20,
      play5: play5,
      verse: verse,
    );
  }
}
