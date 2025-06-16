import 'package:fast/cubit/wallet_cubit.dart';
import 'package:fast/local_storage/word_operation.dart';
import 'package:fast/model/my_services.dart';
import 'package:fast/model/object.dart';
import 'package:fast/model/stories_by_subject.dart';
import 'package:fast/model/story.dart';
import 'package:fast/model/word.dart';
import 'package:fast/network/local/chach_helper.dart';
import 'package:fast/utlis/constant.dart';
import 'package:fast/views/widgets/story_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TapNameWidget extends StatelessWidget {
  const TapNameWidget(
      {Key? key,
      required this.height,
      required this.width,
      required this.name,
      required this.backGroundColor,
      required this.borderColor,
      required this.textColor,
      required this.onPressed})
      : super(key: key);

  final double height;
  final double width;
  final String name;
  final Color borderColor;
  final Color backGroundColor;
  final Color textColor;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height * 0.06,
      width: width * 0.35,
      child: Material(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
            side: BorderSide(color: DarkBlue, width: 1)),
        elevation: 5.0,
        clipBehavior: Clip.hardEdge, // Add
        child: MaterialButton(
          color: backGroundColor,
          animationDuration: const Duration(milliseconds: 500),
          onPressed: onPressed,
          child: SizedBox(
              child: Center(
            child: FittedBox(
              child: Text(
                name,
                style: TextStyle(color: textColor),
              ),
            ),
          )),
        ),
      ),
    );
  }
}

class WordTapNameWidget extends StatelessWidget {
  const WordTapNameWidget(
      {Key? key,
      required this.height,
      required this.width,
      required this.name,
      required this.backGroundColor,
      required this.textColor,
      required this.onPressed,
      required this.numberOfWords})
      : super(key: key);

  final double height;
  final double width;
  final String name;
  final int numberOfWords;
  final Color backGroundColor;
  final Color textColor;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width * 0.3,
      height: height * 0.07,
      child: Material(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
            side: BorderSide(color: backGroundColor, width: 1)),

        clipBehavior: Clip.hardEdge, // Add
        child: MaterialButton(
          color: backGroundColor,
          hoverColor: Colors.blue,
          animationDuration: const Duration(milliseconds: 500),
          onPressed: onPressed,
          child: SizedBox(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FittedBox(
                child: Text(
                  name,
                  style: TextStyle(
                      color: textColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
              FittedBox(
                child: Text(
                  numberOfWords.toString(),
                  style: TextStyle(
                      color: textColor,
                      fontSize: 10,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}

class WordTypeModel {
  final String name;
  final int index;
  final int numberOfWords;
  final List<Map> wordList;
  WordTypeModel(
      {required this.index,
      required this.name,
      required this.numberOfWords,
      required this.wordList});
}

class ListWidget extends StatelessWidget {
  const ListWidget({
    Key? key,
    required this.wordsList,
    required this.wordOperations,
    required this.backGroundColor,
    required this.isHard,
  }) : super(key: key);

  final List<Map<String , dynamic>> wordsList;
  final WordOperations wordOperations;
  final Color backGroundColor;
  final bool isHard;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: backGroundColor.withAlpha(100)),
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: wordsList.length,
          padding: const EdgeInsets.all(5),
          itemBuilder: (BuildContext context, int index) {
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
                                  WalletCubit.get(context).speckBrtain(
                                    '${wordsList[index]['correct_word']}',
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
                                      width: MediaQuery.of(context).size.width *
                                          0.05,
                                      height: 15,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 15),
                              InkWell(
                                onTap: () async {
                                  WalletCubit.get(context).speakAmercan(
                                    '${wordsList[index]['correct_word']}',
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
                                      width: MediaQuery.of(context).size.width *
                                          0.05,
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
                              if (CacheHelper.getData(key: 'lanCode') ==
                                  'en-UK') {
                                WalletCubit.get(context).speckBrtain(
                                  wordsList[index]['correct_word'],
                                );
                              } else if (CacheHelper.getData(key: 'lanCode') ==
                                  'en-US') {
                                WalletCubit.get(context).speakAmercan(''
                                    // subjectWordsList[index]['correct_word'],
                                    );
                              }

                              WalletCubit.get(context)
                                  .speakOne(wordsList[index]['correct_word']);
                            },
                            child: SvgPicture.asset(
                                'assets/icons/person_icon.svg',
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
                      if (isHard) {
                        //delete from hard words
                        wordOperations.deleteFromDuplicated(wordsList[index]['id']);
                        WalletCubit.get(context).deleteFromHard();
                      } else {
                        Word word = Word.fromMap(wordsList[index]);
                        wordOperations.insertToDublicated(word: word);
                        WalletCubit.get(context).addToWallet();
                      }
                    },
                    child: isHard
                        ? Icon(
                            Icons.delete,
                            color: Orange,
                          )
                        : SvgPicture.asset(
                            'assets/icons/add_to.svg',
                            fit: BoxFit.fill,
                            width: MediaQuery.of(context).size.width * 0.07,
                            height: 25,
                          ),
                  ),

                  const Spacer(),
                  Text(
                    wordsList[index]['correct_word'],
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: DarkBlue),
                  ),

                  const Spacer(),
                  Container(
                      width: 42,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          color: backGroundColor),
                      child: Center(
                          child: Text(
                        '${index + 1}',
                        style: TextStyle(fontSize: 18, color: DarkBlue),
                      ))),
                ],
              ),
            );
          }),
    );
  }
}

class SavedStoriesWidget extends StatelessWidget {
  final TabController tabController;
  final List<Story> allStories;

  const SavedStoriesWidget({
    Key? key,
    required this.tabController,
    required this.allStories,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {


    return BlocBuilder<WalletCubit, WalletState>(
      builder: (context, state) {
        return Expanded(
          child: state is GetStoriesLoadingState
              ? const Center(
                  child: Text('loading ..'),
                )
              : GridView.count(
                  physics: const BouncingScrollPhysics(),
                  childAspectRatio: (1 / 1),
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  crossAxisCount: 2,
                  children: List.generate(allStories.length, (index) {
                    print(allStories[index].title);
                    return StoryWidget(
                      image: allStories[index].image,
                      title: allStories[index].title,
                      onTapped: (){
                        MyService myService = MyService();
                        myService.setSelectedStoriesBySubject =StoriesBySubject(stories: allStories, subject: SubjectModel(image: '' ,ar_title: 'المحفظة' , en_title: 'wallet', id: -1 ), countAll: allStories.length);
                        myService.setSelectedStory = allStories[index];
                        tabController.animateTo(10);
                      },
                    );
                  }),
                ),
        );
      },
    );
  }
}
