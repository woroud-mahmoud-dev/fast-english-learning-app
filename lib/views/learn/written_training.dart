/*
import 'package:fast/cubit/training/duplicated_training_cubit.dart';
import 'package:fast/cubit/training/written_training_cubit.dart';
import 'package:fast/cubit/training/written_training_states.dart';
import 'package:fast/local_storage/word_operation.dart';

import 'package:fast/model/word.dart';
import 'package:fast/network/local/chach_helper.dart';
import 'package:fast/utlis/constant.dart';
import 'package:fast/views/widgets/CustomBottomSheet.dart';
import 'package:fast/views/widgets/finish_training.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../cubit/training/training_cubit.dart';
import '../widgets/linerIndicator.dart';
import '../widgets/training/answer_written_training_body.dart';
import '../widgets/word_sound.dart';



class WrittenTraining extends StatelessWidget {
  final List<Word> allWords;
  final TrainingCubit trainingCubit;
  const WrittenTraining({Key? key, required this.allWords, required this.trainingCubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IndicatorController  indicatorController = IndicatorController();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        trainingCubit.update();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocProvider(
          create: (BuildContext context) => WrittenTrainingCubit()..init(allWords),
          child: BlocConsumer<WrittenTrainingCubit, WrittenTrainingStates>(
            listener: (context, state) {
              */
/*print(state);
              if (state is GetNextWordTraining) {
                WrittenTrainingCubit.get(context).init(allWords);
                WrittenTrainingCubit.get(context).showNextButton = false;
              }
              if (state is WriteWordCorrect) {
                WrittenTrainingCubit.get(context).opsBravooImage = 1;
                WrittenTrainingCubit.get(context).bgWordColor = Colors.green;
                WrittenTrainingCubit.get(context).borderColor = Colors.green;
                WrittenTrainingCubit.get(context).bgImage = 'bg_green.png';
                WrittenTrainingCubit.get(context).correct_ = WrittenTrainingCubit.get(context).correct_ + 1;
              }
              if (state is WriteWordUnCorrect) {
                WrittenTrainingCubit.get(context).opsBravooImage = 0;
                WrittenTrainingCubit.get(context).borderColor = Colors.red;
                WrittenTrainingCubit.get(context).bgWordColor = Colors.red;
                WrittenTrainingCubit.get(context).wrong = WrittenTrainingCubit.get(context).wrong + 1;
              }
              if (state is GetNextWordTraining ||
                  state is KeepChecking ||
                  state is ResetAnswer) {
                WrittenTrainingCubit.get(context).opsBravooImage = 0;
                WrittenTrainingCubit.get(context).borderColor = DarkBlue;
                WrittenTrainingCubit.get(context).bgWordColor = LightOrange;
                WrittenTrainingCubit.get(context).bgImage = 'bgred.png';
              }
              if (state is GetNextWordTraining) {
                WrittenTrainingCubit.get(context).answerWord = '';
              }*/
/*

            },


            builder: (context, state) {
              int wordIndex = WrittenTrainingCubit.get(context).wordIndex;
              String answerWord = WrittenTrainingCubit.get(context).answerWord;


              if(state is LearnWriteFinish ){
                return  FinishTraining(
                  trainingCubit: trainingCubit,
                  wrong: WrittenTrainingCubit.get(context).wrong,
                  correct: WrittenTrainingCubit.get(context).correct_,
                );
              }

              return SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(top: 40.0 , left: 4 , right: 4),
                  child: ListView(

                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric( horizontal: 10.0),
                        child: LinerIndicator(controller:indicatorController , width: width-20, showPer: false,colorBorder: Colors.transparent , backgroundColor: Colors.grey.withOpacity(0.15),),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                            child: Text(
                              'تخطي',
                              style: TextStyle(
                                  color: Grey, fontSize: 18),
                            ),
                            onPressed: () {
                              OutBottomSheet2(
                                onTapped: (){
                                  WordOperations wordOperations = WordOperations();
                                  wordOperations.insertToDublicated(
                                    id: allWords[wordIndex].id,
                                    word: allWords[wordIndex].word,
                                    word1: allWords[wordIndex].word1,
                                    image: allWords[wordIndex].image,
                                    correct_word: allWords[wordIndex].correct_word,
                                    level_id: int.parse(allWords[wordIndex].level_id,),
                                    object_id: int.parse(allWords[wordIndex].object_id,),
                                    type_id: 2,
                                  );
                                  WrittenTrainingCubit.get(context).getTheNext(allWords.length,allWords);
                                  Navigator.pop(context);
                                },
                                title: 'هل هذه الكلمة صعبة؟ \n هل تريد اضافتها الى المحفظة؟',
                                context: context,
                                ButtonNameOne: 'الغاء',
                                word: allWords[wordIndex],
                                ButtonNameTow: 'نعم',
                              );
                            }),
                      ),

                      Container(
                        height: height * 0.28,
                        width: height * 0.28,
                        padding: const EdgeInsets.all(40),
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/${WrittenTrainingCubit.get(context).bgImage}',
                                ),
                                fit: BoxFit.cover)),
                        child: Center(
                          child: Container(
                            height: width * 0.4,
                            width: width * 0.4,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(imageUrl + allWords[wordIndex].image),
                                    fit: BoxFit.cover,
                                ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            if(CacheHelper.getData(key: 'lanCode') == 'US-UK')
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  WordSound(
                                    lang: 'UK',
                                    onTaped: () {
                                      WrittenTrainingCubit.get(context).speckBrtain(allWords[wordIndex].correct_word,);
                                    },
                                  ),
                                  const SizedBox(width: 32),
                                  WordSound(
                                    lang: 'US',
                                    onTaped: () {
                                      WrittenTrainingCubit.get(context).speakAmercan(allWords[wordIndex].correct_word,);
                                    },
                                  ),
                                ],
                              ),

                            if(CacheHelper.getData(key: 'lanCode') != 'US-UK')
                              WordSound(
                                lang: 'US',
                                onTaped: () {
                                  if (CacheHelper.getData(key: 'lanCode') == 'en-UK') {
                                    WrittenTrainingCubit.get(context).speckBrtain(allWords[wordIndex].correct_word,);
                                  } else if (CacheHelper.getData(key: 'lanCode') == 'en-US') {
                                    WrittenTrainingCubit.get(context).speakAmercan(allWords[wordIndex].correct_word,);
                                  }
                                },
                              ),
                            const SizedBox(width: 32,),

                            InkWell(
                              onTap: () {
                                WordOperations wordOperations = WordOperations();
                                wordOperations.insertToDublicated(
                                  id: allWords[wordIndex].id,
                                  word: allWords[wordIndex].word,
                                  word1: allWords[wordIndex].word1,
                                  image: allWords[wordIndex].image,
                                  correct_word: allWords[wordIndex].correct_word,
                                  level_id: int.parse(allWords[wordIndex].level_id,),
                                  object_id: int.parse(allWords[wordIndex].object_id,),
                                  type_id: 2,
                                );
                              },
                              child: SvgPicture.asset(
                                'assets/icons/add_to.svg',
                                fit: BoxFit.fill,
                                width: width * 0.09,
                                height: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                      AnswerWrittenTrainingBody(
                        writtenTrainingCubit: DuplicatedCubit.get(context),
                        width:width ,
                        answerWord: answerWord,
                        word: allWords[wordIndex],
                      ),

                      if(WrittenTrainingCubit.get(context).showNextButton)
                        Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () {
                              */
/*if (state is WriteWordCorrect ||
                                  state is WriteWordUnCorrect) {
                                WrittenTrainingCubit.get(context)
                                    .getTheNext(
                                    allWords.length, allWords);
                              } else {
                                print('no word select');
                              }*/
/*

                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color:
                                WrittenTrainingCubit.get(context)
                                    .bgColor,
                                borderRadius:
                                BorderRadius.circular(28),
                              ),
                              //       width: MediaQuery.of(context).size.width * 0.5,
                              width: 190,
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
                        child: TextButton(
                            child: SvgPicture.asset(
                              'assets/icons/out.svg',
                              fit: BoxFit.fill,
                              width: MediaQuery.of(context).size.width *
                                  0.08,
                              height: 30,
                            ),
                            onPressed: () {
                              showOutTrainingDialog(
                                onTappedContinue: (){},
                                onTappedExit: (){
                                  trainingCubit.update();
                                  Navigator.pop(context);
                                },
                                title: 'هل تريد الخروج حقا ...مازلنا \n في بداية التمرين؟؟',
                                context: context,
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

*/
