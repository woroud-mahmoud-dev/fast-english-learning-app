import 'dart:math' as math;

import 'package:expandable/expandable.dart';
import 'package:fast/cubit/training/Learned_word_cubite.dart';
import 'package:fast/cubit/training/learned_words_states.dart';
import 'package:fast/local_storage/word_operation.dart';
import 'package:fast/model/my_services.dart';
import 'package:fast/network/local/chach_helper.dart';
import 'package:fast/utlis/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../model/word.dart';

Widget subjectWidget(
  BuildContext context, {
  required subjectAndCountOfWords,
}) {
  return Material(
    child: Container(
        margin: const EdgeInsets.only(bottom: 25, left: 15, right: 15),
        width: 300,
        // height: 110,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
              .withOpacity(0.5),
          //     color: Blue,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              width: 5,
            ),
            Container(
              height: 45,
              width: 45,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: CircularPercentIndicator(
                radius: 22.1,
                lineWidth: 1.2,
                percent: (subjectAndCountOfWords['countCorrect'] /
                    subjectAndCountOfWords['numberOfWords']),
                center: Text(
                  '${double.parse((subjectAndCountOfWords['countCorrect'] * 100 / subjectAndCountOfWords['numberOfWords']).toString()).isNaN ? 0.0 : double.parse((subjectAndCountOfWords['countCorrect'] * 100 / subjectAndCountOfWords['numberOfWords']).toString())}%',
                  style: TextStyle(
                      fontSize: 14,
                      color: DarkBlue,
                      fontWeight: FontWeight.w100),
                ),
                progressColor: DarkBlue,
                backgroundColor: Colors.white54,
              ),
            ),
            const Spacer(),
            Column(
              children: [
                Text(
                  subjectAndCountOfWords['subject'].ar_title,
                  style: TextStyle(
                      fontSize: 14,
                      color: DarkBlue,
                      fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Text(
                  '${subjectAndCountOfWords['numberOfWords']}/${subjectAndCountOfWords['countCorrect']} كلمة',
                  style: TextStyle(
                      fontSize: 12,
                      color: DarkBlue,
                      fontWeight: FontWeight.w100),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: DarkBlue,
                  border: Border.all(color: Grey)),
            ),
          ],
        )),
  );
}

Widget buildListIteam(
  context, {
  required Word word,
  required int index,
  void Function()? tap,
}) {
  WordOperations wordOperations = WordOperations();
  return Container(
    margin: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
    height: 50,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), color: Colors.white),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // const Spacer(),
        CacheHelper.getData(key: 'lanCode') == 'US-UK'
            ? Padding(
                padding: const EdgeInsets.only(top: 7, left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () async {
                        // widget.tts.pause();
                        LearnedWordsCubit.get(context).speckUK(
                          word.correct_word,
                        );
                      },
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/UK.svg",
                            width: 15,
                            height: 10,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 2),
                          SvgPicture.asset(
                            'assets/icons/person_icon.svg',
                            fit: BoxFit.fill,
                            width: MediaQuery.of(context).size.width * 0.05,
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 15),
                    InkWell(
                      onTap: () async {
                        LearnedWordsCubit.get(context).speakUS(
                          word.correct_word,
                        );
                      },
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/US.svg",
                            width: 15,
                            height: 10,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 2),
                          SvgPicture.asset(
                            'assets/icons/person_icon.svg',
                            fit: BoxFit.fill,
                            width: MediaQuery.of(context).size.width * 0.05,
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(left: 10),
                child: GestureDetector(
                  onTap: () {
                    if (CacheHelper.getData(key: 'lanCode') == 'en-UK') {
                      LearnedWordsCubit.get(context).speckUK(
                        word.correct_word,
                      );
                    } else if (CacheHelper.getData(key: 'lanCode') == 'en-US') {
                      LearnedWordsCubit.get(context).speakUS(
                        word.correct_word,
                      );
                    }

                    LearnedWordsCubit.get(context).speakOne(word.correct_word);
                  },
                  child: SvgPicture.asset('assets/icons/person_icon.svg',
                      fit: BoxFit.fill,
                      width: MediaQuery.of(context).size.width * 0.07,
                      height: 25),
                ),
              ),
        const SizedBox(
          width: 10,
        ),
        GestureDetector(
          onTap: () {
            word.type = 1;
            wordOperations.insertToDublicated(word: word);
          },
          child: SvgPicture.asset(
            'assets/icons/add_to.svg',
            fit: BoxFit.fill,
            width: MediaQuery.of(context).size.width * 0.07,
            height: 25,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        if (word.type == 1) Icon(Icons.check_box_outlined, color: Green),
        if (word.type == 2) Icon(Icons.front_hand_outlined, color: Blue),
        if (word.type == 3)
          Icon(Icons.record_voice_over_outlined, color: DarkBlue),

        const Spacer(),
        GestureDetector(
          onTap: tap ?? () {},
          child: Text(
            word.correct_word,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: DarkBlue,
            ),
          ),
        ),

        const Spacer(),
        Container(
            width: 42,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                color: Colors.green),
            child: Center(
                child: Text(
              '${index + 1}',
              style: TextStyle(fontSize: 18, color: DarkBlue),
            ))),
      ],
    ),
  );
}

class showAllWords extends StatelessWidget {
  final List<Word> myList;
  final TabController tabController;
  const showAllWords(
      {Key? key, required this.myList, required this.tabController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    WordOperations wordOperations = WordOperations();
    MyService myService = MyService();

    /*buildItem({required String enWord, required int}) {
      return GestureDetector(
        onTap: () {
          index = int;
          myService.setCorrectWord = myList[int - 1].correct_word;
          tabController.animateTo(7);
        },
        child: Container(
          margin:
              const EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 7),
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CacheHelper.getData(key: 'lanCode') == 'US-UK'
                  ? Padding(
                      padding: const EdgeInsets.only(top: 7, left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () async {
                              LearnedWordsCubit.get(context).speckUK(
                                enWord,
                              );
                            },
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/UK.svg",
                                  width: 15,
                                  height: 10,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(height: 2),
                                SvgPicture.asset(
                                  'assets/icons/person_icon.svg',
                                  fit: BoxFit.fill,
                                  width:
                                      MediaQuery.of(context).size.width * 0.05,
                                  height: 15,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 15),
                          InkWell(
                            onTap: () async {
                              LearnedWordsCubit.get(context).speakUS(enWord);
                            },
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/US.svg",
                                  width: 15,
                                  height: 10,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(height: 2),
                                SvgPicture.asset(
                                  'assets/icons/person_icon.svg',
                                  fit: BoxFit.fill,
                                  width:
                                      MediaQuery.of(context).size.width * 0.05,
                                  height: 15,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: GestureDetector(
                        onTap: () {
                          if (CacheHelper.getData(key: 'lanCode') == 'en-UK') {
                            LearnedWordsCubit.get(context).speckUK(
                              enWord,
                            );
                          } else if (CacheHelper.getData(key: 'lanCode') ==
                              'en-US') {
                            LearnedWordsCubit.get(context).speakUS(
                              enWord,
                            );
                          }

                          LearnedWordsCubit.get(context).speakOne(enWord);
                        },
                        child: SvgPicture.asset('assets/icons/person_icon.svg',
                            fit: BoxFit.fill,
                            width: MediaQuery.of(context).size.width * 0.07,
                            height: 25),
                      ),
                    ),
              const SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () {
                    // this is error
                  Word word = myList[int];
                  word.type = 1;
                  wordOperations.insertToDublicated(word:word);
                },
                child: SvgPicture.asset(
                  'assets/icons/add_to.svg',
                  fit: BoxFit.fill,
                  width: MediaQuery.of(context).size.width * 0.07,
                  height: 25,
                ),
              ),
              const Spacer(),
              Text(
                enWord,
                style: TextStyle(
                    fontSize: 14, fontWeight: FontWeight.bold, color: DarkBlue),
              ),
              const Spacer(),
              Container(
                  width: 42,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      color: Colors.grey),
                  child: Center(
                      child: Text(
                    '$int',
                    style: TextStyle(fontSize: 18, color: DarkBlue),
                  ))),
            ],
          ),
        ),
      );
    }*/

    buildList() {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: LightBlue,
        ),
        child: Column(
          children: <Widget>[
            for (var i in List.generate(myList.length, (index) => index))
              buildListIteam(context, word: myList[i], index: i),
          ],
        ),
      );
    }

    return Material(
      child: ExpandableNotifier(
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: ScrollOnExpand(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: <Widget>[
                ExpandablePanel(
                  theme: const ExpandableThemeData(
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      tapBodyToExpand: false,
                      tapBodyToCollapse: false,
                      alignment: Alignment.center,
                      hasIcon: false,
                      fadeCurve: Curves.bounceInOut),
                  header: Row(
                    children: [
                      const Spacer(),
                      ExpandableIcon(
                        theme: const ExpandableThemeData(
                          expandIcon: Icons.arrow_drop_down,
                          collapseIcon: Icons.arrow_drop_up,
                          iconColor: Colors.orangeAccent,
                          iconSize: 28.0,
                          iconRotationAngle: math.pi / 2,
                          iconPadding: EdgeInsets.only(right: 5),
                          hasIcon: false,
                        ),
                      ),
                      Expanded(
                        child: Text("عرض جميع الكلمات",
                            style: TextStyle(
                                color: Orange,
                                fontSize: 12,
                                fontWeight: FontWeight.bold)),
                      ),
                      const Spacer(),
                    ],
                  ),
                  collapsed: Container(),
                  expanded: buildList(),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
