import 'package:fast/local_storage/story_operation.dart';
import 'package:fast/model/my_services.dart';
import 'package:fast/model/stories_by_subject.dart';
import 'package:fast/model/story.dart';
import 'package:fast/utlis/constant.dart';
import 'package:fast/views/widgets/myWidgets.dart';
import 'package:fast/views/widgets/show_toast.dart';

import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum TtsState { playing, stopped, paused, continued }

class PlayStoryTap extends StatefulWidget {
  final TabController tabController;
  const PlayStoryTap({Key? key, required this.tabController}) : super(key: key);
  @override
  State<PlayStoryTap> createState() => _PlayStoryTapState();
}

class _PlayStoryTapState extends State<PlayStoryTap> {
  late StoryOperations storyOperations;
  late FlutterTts _flutterTts;
  late double rate;
  late TtsState _ttsState;
  late MyService myService;
  late Story selectedStory;
  late int indexOfSelectedStory;
  late StoriesBySubject selectedStoriesBySubject;



  @override
  void initState() {
    super.initState();
    myService = MyService();
    storyOperations = StoryOperations();
    selectedStoriesBySubject = myService.getSelectedStoriesBySubject;
    selectedStory = myService.getSelectedStory;
    indexOfSelectedStory = selectedStoriesBySubject.stories.indexOf(selectedStory);

    rate = 0.5;
    _ttsState = TtsState.stopped;
    initTts();
  }

  @override
  void dispose() {
    super.dispose();
    _flutterTts.stop();
  }

  initTts() async {
    _flutterTts = FlutterTts();
    await _flutterTts.awaitSpeakCompletion(true);

    _flutterTts.setStartHandler(() {
      setState(() {
        print("Playing");
        _ttsState = TtsState.playing;
      });
    });

    _flutterTts.setCompletionHandler(() {
      setState(() {
        print("Complete");
        _ttsState = TtsState.stopped;
      });
    });

    _flutterTts.setCancelHandler(() {
      setState(() {
        print("Cancel");
        _ttsState = TtsState.stopped;
      });
    });

    _flutterTts.setErrorHandler((message) {
      setState(() {
        print("Error: $message");
        _ttsState = TtsState.stopped;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    selectedStory = selectedStoriesBySubject.stories[indexOfSelectedStory];

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              child: Row(
                children: [
                  Container(
                    height: 35,
                    padding:const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: DarkBlue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        selectedStoriesBySubject.subject.ar_title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      storyOperations.insertStory(
                          id: selectedStory.id,
                          arText: selectedStory.arText,
                          enText: selectedStory.enText,
                          title: selectedStory.title,
                          image: selectedStory.image,
                          object_id: selectedStory.object_id);
                    },
                    child: SvgPicture.asset(
                      "assets/icons/add_to.svg",
                      width: 20,
                      height: 25,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'تعلم عبر القصص',
                    style: TextStyle(
                        fontSize: 14,
                        color: DarkBlue,
                        fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      onPressed: () {
                        widget.tabController.animateTo(9);
                      },
                      icon: const Icon(Icons.arrow_forward)),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Visibility(
                      visible: indexOfSelectedStory == 0 ? false : true,
                      child: GestureDetector(
                        child: SvgPicture.asset('assets/icons/back_icon.svg'),
                        onTap: () {
                          stop();
                          if (indexOfSelectedStory > 0) {
                            setState(() {
                              indexOfSelectedStory--;
                              print(indexOfSelectedStory);
                            });
                          }
                        },
                      )),
                ),
                Expanded(
                  flex: 8,
                  child: Container(
                    height: width * 0.65,
                    width: width * 0.65,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage(
                              'assets/images/bgstory.png',
                            ),
                            fit: BoxFit.contain)),
                    child: Center(
                      child: Container(
                        height: width * 0.4,
                        width: width * 0.4,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(
                                    StoryImgUrl + selectedStory.image),
                                fit: BoxFit.cover)),
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Visibility(
                        visible:
                            (indexOfSelectedStory != selectedStoriesBySubject.stories.length - 1) ? true : false,
                        child: GestureDetector(
                          child: SvgPicture.asset('assets/icons/next.svg'),
                          onTap: () {
                            if (indexOfSelectedStory < selectedStoriesBySubject.stories.length) {
                              stop();
                              setState(() {
                                indexOfSelectedStory ++;
                                print(indexOfSelectedStory);
                              });
                            }
                          },
                        ))),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  selectedStory.title,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: IconButton(
                    onPressed: decreaseRate,
                    icon: SvgPicture.asset('assets/icons/slower.svg'),
                  ),
                ),
                button(
                  selectedStory.enText,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: increaseRate,
                    child: SvgPicture.asset('assets/icons/faster.svg'),
                  ),
                ),
              ],
            ),
            ShowText(
              txet: selectedStory.enText, titleText: 'عرض النص',
            ),const SizedBox(
              height: 5,
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: ShowText(
                txet: selectedStory.arText, titleText: 'عرض الترجمة',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget button(String tts) {
    if (_ttsState == TtsState.stopped) {
      return InkWell(
        onTap: () => speak(tts),
        child: SizedBox(
          height: 70,
          width: 70,
          child: Card(
            elevation: 4,
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            child: Icon(
              Icons.play_arrow,
              color: DarkBlue,
              size: 35,
            ),
          ),
        ),
      );
    } else {
      return InkWell(
        onTap: stop,
        child: SizedBox(
          height: 70,
          width: 70,
          child: Card(
            elevation: 4,
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            child: Icon(
              Icons.stop,
              color: Orange,
              size: 35,
            ),
          ),
        ),
      );
    }
  }

  void increaseRate() {
    stop();
    if (rate < 1) {
      setState(() {
        rate = rate + 0.1;
      });
      showToast(
          toastGravity: ToastGravity.SNACKBAR,
          textColor: Colors.grey,
          color: Colors.transparent,
          text: rate.toString());
    } else {
      rate = rate;
    }
  }

  void decreaseRate() {
    stop();
    if (rate > 0) {
      setState(() {
        rate = rate - 0.1;
      });
      showToast(
          toastGravity: ToastGravity.SNACKBAR,
          textColor: Colors.grey,
          color: Colors.transparent,
          text: rate.toString());
    } else {
      rate = rate;
    }
  }

  Future speak(String _tts) async {
    await _flutterTts.setVolume(1);
    await _flutterTts.setSpeechRate(rate);
    await _flutterTts.setPitch(1);

    if (_tts != null) {
      if (_tts.isNotEmpty) {
        await _flutterTts.speak(_tts);
      }
    }
  }

  Future stop() async {
    var result = await _flutterTts.stop();
    if (result == 1) {
      setState(() {
        _ttsState = TtsState.stopped;
      });
    }
  }
}
