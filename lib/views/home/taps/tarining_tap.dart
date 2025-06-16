import 'package:fast/cubit/wallet_cubit.dart';
import 'package:fast/model/my_services.dart';
import 'package:fast/model/story.dart';
import 'package:fast/model/word.dart';
import 'package:fast/network/local/chach_helper.dart';
import 'package:fast/utlis/constant.dart';
import 'package:fast/views/auth/login_screen.dart';
import 'package:fast/views/learn/duplicated_training.dart';
import 'package:fast/views/widgets/linerIndicator.dart';
import 'package:fast/views/widgets/story_widget.dart';
import 'package:flutter/material.dart';
import 'package:fast/views/widgets/functions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubit/training/training_cubit.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/training_button.dart';

int buildOfTrainingTap = 0;

class TrainingTap extends StatelessWidget {
  final TabController tabController;
  final int? id;
  const TrainingTap({Key? key, required this.tabController, this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    //print('build of TrainingTap ${buildOfTrainingTap++}');

    return BlocConsumer<TrainingCubit, TrainingStates>(
      listener: (context, state) {
        if (state is UserNotFound) {
          CacheHelper.clearData();
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) {
            return const Login();
          }), (route) => false);
        }
      },
      builder: (context, state) {
        return BlocBuilder<TrainingCubit, TrainingStates>(
          builder: (context, state) {
            if (state is TrainingLoading ||
                TrainingCubit.get(context).allWords == null ||
                TrainingCubit.get(context).allStories == null) {
              return Center(child: Image.asset('assets/images/loading.gif'));
            }
            List<Word> allWords = TrainingCubit.get(context).allWords!;
            List<Story> storiesList = TrainingCubit.get(context).allStories!;

            if (TrainingCubit.get(context).isError) {
              return FastErrorWidget(
                onTapped: () => TrainingCubit.get(context).update(),
              );
            }

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.max, //
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        'مهامك لليوم',
                        style: TextStyle(
                          color: DarkBlue,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 260,
                    child: GridView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      addAutomaticKeepAlives: false,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        childAspectRatio: 1.2,
                        crossAxisSpacing: 15,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 0,
                      ),
                      children: [
                        TrainingButton(
                          onTaped: () {
                            if (allWords.isEmpty) {
                            } else {
                              goNext(
                                  context,
                                  DuplicatedTraining(
                                    trainingCubit: TrainingCubit.get(context),
                                    newWords: allWords,
                                    type: 1,
                                  ));
                            }
                          },
                          color: Green,
                          title: 'تعلم كلمات جديدة',
                          allWords: TrainingCubit.get(context).allWords!.length,
                          learnWords: TrainingCubit.get(context)
                              .countOfChoiceTrainingWords,
                        ),
                        TrainingButton(
                          onTaped: () {
                            goNext(
                                context,
                                DuplicatedTraining(
                                  trainingCubit: TrainingCubit.get(context),
                                  type: 0,
                                ));
                          },
                          color: Orange,
                          title: 'تكرار الكلمات',
                          allWords: TrainingCubit.get(context).allWords!.length,
                          duplicatesWords: TrainingCubit.get(context)
                              .countOfDuplicatedTrainingWords,
                        ),
                        TrainingButton(
                          onTaped: () {
                            if (allWords.isEmpty) {
                            } else {
                              goNext(
                                  context,
                                  DuplicatedTraining(
                                    trainingCubit: TrainingCubit.get(context),
                                    newWords: allWords,
                                    type: 2,
                                  ));
                            }
                          },
                          color: LightBlue,
                          title: 'التدريب الكتابي',
                          allWords: TrainingCubit.get(context).allWords!.length,
                          learnWords: TrainingCubit.get(context)
                              .countOfWrittenTrainingWords,
                        ),
                        TrainingButton(
                          onTaped: () {
                            if (allWords.isEmpty) {
                            } else {
                              goNext(
                                  context,
                                  DuplicatedTraining(
                                    trainingCubit: TrainingCubit.get(context),
                                    newWords: allWords,
                                    type: 3,
                                  ));
                            }
                          },
                          color: Blue,
                          title: 'تدريب النطق',
                          allWords: TrainingCubit.get(context).allWords!.length,
                          learnWords: TrainingCubit.get(context)
                              .countOfVoiceTrainingWords,
                        ),
                      ],
                    ),
                  ),
                  //const
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: seeAllSubjects,
                          child: Text(
                            'عرض الكل',
                            style: TextStyle(
                                color: DarkBlue,
                                fontSize: 10,
                                fontWeight: FontWeight.normal),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Text(
                          'احدث الكلمات التي تعلمتها',
                          style: TextStyle(
                              color: DarkBlue,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                        itemCount: TrainingCubit.get(context)
                            .subjectsAndWordCount
                            .length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 20),
                        itemBuilder: (context, int i) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Text(
                                        '${TrainingCubit.get(context).subjectsAndWordCount[i]['numberOfWords']}/${TrainingCubit.get(context).subjectsAndWordCount[i]['countCorrect']}',
                                        style: TextStyle(
                                          color: DarkBlue,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                    LinerIndicator(
                                      color: DarkBlue,
                                      showPer: false,
                                      value: (TrainingCubit.get(context)
                                                          .subjectsAndWordCount[
                                                      i]['countCorrect'] *
                                                  100 /
                                                  TrainingCubit.get(context)
                                                          .subjectsAndWordCount[
                                                      i]['numberOfWords'])
                                              .isNaN
                                          ? 0.0
                                          : TrainingCubit.get(context)
                                                      .subjectsAndWordCount[i]
                                                  ['countCorrect'] *
                                              100 /
                                              TrainingCubit.get(context)
                                                      .subjectsAndWordCount[i]
                                                  ['numberOfWords'],
                                      width: width - 130,
                                      colorBorder: DarkBlue,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 35,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: DarkBlue,
                                    ),
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                  child: Center(
                                    child: Text(
                                      TrainingCubit.get(context)
                                          .subjectsAndWordCount[i]['subject']
                                          .ar_title,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: DarkBlue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: seeAllStories,
                          child: Text(
                            'عرض حسب الفئة',
                            style: TextStyle(
                                color: DarkBlue,
                                fontSize: 10,
                                fontWeight: FontWeight.normal),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Text(
                          'تعلم عبر القصص',
                          style: TextStyle(
                              color: DarkBlue,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: height * 0.20,
                    child: ListView.builder(
                      itemCount: storiesList.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: ((context, index) {
                        return StoryWidget(
                          onTapped: () {
                            MyService myService = MyService();
                            myService.setStoriesList = storiesList;
                            myService.setSelectedStory = storiesList[index];
                            tabController.animateTo(10);
                          },
                          image: storiesList[index].image,
                          title: storiesList[index].title,
                        );
                      }),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void onPressedButtonFAST() {}

  void seeAllSubjects() {
    tabController.animateTo(5);
  }

  void seeAllStories() {
    tabController.animateTo(9);
  }
}
