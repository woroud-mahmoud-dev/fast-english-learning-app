import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:fast/cubit/training/duplicated_training_cubit.dart';
import 'package:fast/utlis/constant.dart';
import 'package:fast/views/widgets/CustomBottomSheet.dart';
import 'package:fast/views/widgets/training/answer_new_word_body.dart';
import 'package:fast/views/widgets/training/answer_written_training_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../cubit/training/training_cubit.dart';
import '../../local_storage/word_operation.dart';
import '../../model/my_services.dart';
import '../../model/word.dart';
import '../../network/local/chach_helper.dart';
import '../widgets/error_widget.dart';
import '../widgets/finish_training.dart';
import '../widgets/linerIndicator.dart';
import '../widgets/myWidgets.dart';
import '../widgets/training/answer_voice_training_body.dart';
import '../widgets/word_sound.dart';

class DuplicatedTraining extends StatelessWidget {
  final TrainingCubit trainingCubit;
  final List<Word>? newWords;
  final int type;
  const DuplicatedTraining(
      {Key? key,
      required this.trainingCubit,
      this.newWords,
      required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    IndicatorController indicatorController = IndicatorController();
    RecorderController controllerR = RecorderController();

    return WillPopScope(
      onWillPop: () async {
        showOutTrainingDialog(
          onTappedContinue: () {},
          onTappedExit: () {
            trainingCubit.update();
            Navigator.pop(context);
          },
          title: 'هل تريد الخروج حقا ...مازلنا \n في بداية التمرين؟؟',
          context: context,
        );
        return true;
      },
      child: Scaffold(
        body: BlocProvider(
          create: (BuildContext context) =>
              DuplicatedCubit(allWords: newWords, type: type)..init(),
          child: BlocConsumer<DuplicatedCubit, DuplicatedTrainingStates>(
            listener: (context, state) {
              if (state is StartRecordState) {
                controllerR.record();
              }
              if (state is StopRecordState) {
                controllerR.stop();
              }
            },
            builder: (context, state) {
              List<Word> allWords = DuplicatedCubit.get(context).allWords ?? [];
              int wordIndex = DuplicatedCubit.get(context).wordIndex;

              if (state is GetDuplicatedWordsLoadingState) {
                return Center(
                  child: Image.asset('assets/images/loading.gif'),
                );
              }
              if (state is TrainingFinish) {
                return Container(
                  height: height,
                  width: width,
                  color: Colors.white,
                  child: FinishTraining(
                    trainingCubit: trainingCubit,
                    wrong: DuplicatedCubit.get(context).incorrect,
                    correct: DuplicatedCubit.get(context).correct,
                  ),
                );
              }

              if (state is GetDuplicatedWordsErrorState) {
                return SizedBox(
                  height: height,
                  width: width,
                  child: FastErrorWidget(onTapped: () {
                    DuplicatedCubit.get(context).getDuplicatedWords(subId);
                  }),
                );
              }

              if (state is GetDuplicatedWordsEmptyState) {
                return noDuplicatedWordsMessage();
              }

              return SizedBox(
                width: double.infinity,
                child: ListView(
                  padding: const EdgeInsets.only(
                      top: 40, left: 4.0, right: 4.0, bottom: 4),
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: LinerIndicator(
                            controller: indicatorController,
                            width: width - 20,
                            showPer: false,
                            colorBorder: Colors.transparent,
                            backgroundColor: Colors.grey.withOpacity(0.15),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: TextButton(
                            child: Text(
                              'تخطي',
                              style: TextStyle(color: Grey, fontSize: 18),
                            ),
                            onPressed: () {
                              showOutTrainingDialog(
                                onTappedContinue: () {},
                                onTappedExit: () {
                                  WordOperations wordOperations =
                                      WordOperations();
                                  allWords[wordIndex].type =
                                      DuplicatedCubit.get(context).trainingType;
                                  wordOperations.insertToDublicated(
                                      word: allWords[wordIndex]);
                                  DuplicatedCubit.get(context).getTheNext();
                                },
                                yesText: 'نعم',
                                noText: 'رجوع',
                                title:
                                    'هذه الكلمة صعبة؟ \n هل تريد اضافتها إلى المحفظة؟',
                                context: context,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: height * 0.28,
                      width: height * 0.28,
                      padding: const EdgeInsets.all(40),
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/images/${DuplicatedCubit.get(context).bgImage}',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Center(
                        child: Container(
                          height: width * 0.4,
                          width: width * 0.4,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(
                                  imageUrl + allWords[wordIndex].image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (DuplicatedCubit.get(context).trainingType != 3)
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            if (CacheHelper.getData(key: 'lanCode') == 'US-UK')
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  WordSound(
                                    lang: 'UK',
                                    onTaped: () {
                                      DuplicatedCubit.get(context).speckUK(
                                        allWords[wordIndex].correct_word,
                                      );
                                    },
                                  ),
                                  const SizedBox(width: 32),
                                  WordSound(
                                    lang: 'US',
                                    onTaped: () {
                                      DuplicatedCubit.get(context).speckUS(
                                        allWords[wordIndex].correct_word,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            if (CacheHelper.getData(key: 'lanCode') != 'US-UK')
                              WordSound(
                                lang: (CacheHelper.getData(key: 'lanCode') ==
                                        'en-UK')
                                    ? 'UK'
                                    : 'US',
                                onTaped: () {
                                  if (CacheHelper.getData(key: 'lanCode') ==
                                      'en-UK') {
                                    DuplicatedCubit.get(context).speckUK(
                                      allWords[wordIndex].correct_word,
                                    );
                                  } else if (CacheHelper.getData(
                                          key: 'lanCode') ==
                                      'en-US') {
                                    DuplicatedCubit.get(context).speckUS(
                                      allWords[wordIndex].correct_word,
                                    );
                                  }
                                },
                              ),
                            const SizedBox(
                              width: 32,
                            ),
                            InkWell(
                              onTap: () {
                                if (type == 0) {
                                  DuplicatedCubit.get(context)
                                      .removeFromDuplicateWordTable();
                                } else {
                                  DuplicatedCubit.get(context)
                                      .addToDuplicateWordTable();
                                }
                              },
                              child: type == 0
                                  ? Icon(
                                      Icons.delete,
                                      color: Orange,
                                      size: 35,
                                    )
                                  : SvgPicture.asset(
                                      'assets/icons/add_to.svg',
                                      fit: BoxFit.fill,
                                      width: width * 0.09,
                                      height: 30,
                                    ),
                            ),
                          ],
                        ),
                      ),
                    if (DuplicatedCubit.get(context).trainingType == 3)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: InkWell(
                            onTap: () {
                              if (type == 0) {
                                DuplicatedCubit.get(context)
                                    .removeFromDuplicateWordTable();
                              } else {
                                DuplicatedCubit.get(context)
                                    .addToDuplicateWordTable();
                              }
                            },
                            child: type == 0
                                ? Icon(
                                    Icons.delete,
                                    size: 35,
                                    color: Orange,
                                  )
                                : SvgPicture.asset(
                                    'assets/icons/add_to.svg',
                                    fit: BoxFit.fill,
                                    width: width * 0.09,
                                    height: 30,
                                  ),
                          ),
                        ),
                      ),
                    if (DuplicatedCubit.get(context).trainingType == 1)
                      const SizedBox(
                        height: 15,
                      ),
                    if (DuplicatedCubit.get(context).trainingType == 1)
                      AnswerNewWordBody(
                        word: allWords[wordIndex],
                        learnNewWordsCubit: DuplicatedCubit.get(context),
                        width: width,
                      ),
                    const SizedBox(
                      height: 15,
                    ),
                    if (DuplicatedCubit.get(context).trainingType == 2)
                      const SizedBox(
                        height: 15,
                      ),
                    if (DuplicatedCubit.get(context).trainingType == 2)
                      AnswerWrittenTrainingBody(
                        width: width,
                        writtenTrainingCubit: DuplicatedCubit.get(context),
                        word: allWords[wordIndex],
                        answerWord: DuplicatedCubit.get(context).answerWord,
                      ),
                    if (DuplicatedCubit.get(context).trainingType == 3)
                      const SizedBox(
                        height: 15,
                      ),
                    if (DuplicatedCubit.get(context).trainingType == 3)
                      AnswerVoiceTrainingBody(
                        recorderController: controllerR,
                        width: width,
                        voiceTrainingCubit: DuplicatedCubit.get(context),
                      ),
                    if (DuplicatedCubit.get(context).showNextButton)
                      GestureDetector(
                        onTap: () {
                          DuplicatedCubit.get(context).getTheNext();
                        },
                        child: Center(
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: DuplicatedCubit.get(context).bgColor,
                              borderRadius: BorderRadius.circular(28),
                            ),
                            width: width * 0.6,
                            height: 55,
                            child: const Center(
                              child: Text(
                                'التالي',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                          icon: SvgPicture.asset(
                            'assets/icons/out.svg',
                            fit: BoxFit.fill,
                            width: width * 0.08,
                            height: 30,
                          ),
                          onPressed: () {
                            showOutTrainingDialog(
                              onTappedContinue: () {},
                              onTappedExit: () {
                                trainingCubit.update();
                                Navigator.pop(context);
                              },
                              title:
                                  'هل تريد الخروج حقا ...مازلنا \n في بداية التمرين؟؟',
                              context: context,
                            );
                          }),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
