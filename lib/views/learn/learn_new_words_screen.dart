/*
import 'package:fast/cubit/new_word_cubit.dart';
import 'package:fast/cubit/new_word_states.dart';
import 'package:fast/model/word.dart';
import 'package:fast/network/local/chach_helper.dart';
import 'package:fast/utlis/constant.dart';
import 'package:fast/views/widgets/CustomBottomSheet.dart';
import 'package:fast/views/widgets/training/answer_new_word_body.dart';
import 'package:fast/views/widgets/finish_training.dart';
import 'package:fast/views/widgets/word_sound.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../cubit/training/duplicated_training_cubit.dart';
import '../../cubit/training/training_cubit.dart';

class LearnScreen extends StatefulWidget {
  final List<Word> allWords;
  final TrainingCubit trainingCubit;

  const LearnScreen({Key? key, required this.allWords, required this.trainingCubit}) : super(key: key);

  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: WillPopScope(
        onWillPop: () async {
          widget.trainingCubit.update();
          return true;
        },
        child: BlocProvider(
          create: (BuildContext context) => LearnNewWordsCubit(),
          child: BlocConsumer<LearnNewWordsCubit, LearnNewWordsStates>(
            listener: (context, state) {
              if (state is SelectLeftCorrect) {
                LearnNewWordsCubit.get(context).opsLeft = 1;
                LearnNewWordsCubit.get(context).opsRight = 0;
                LearnNewWordsCubit.get(context).opsBravooImage = 1;
                LearnNewWordsCubit.get(context).border_color = Colors.green;
                LearnNewWordsCubit.get(context).word_color = Colors.green;
                LearnNewWordsCubit.get(context).bgImage = 'bg_green.png';
                LearnNewWordsCubit.get(context).correct = LearnNewWordsCubit.get(context).correct + 1;
                LearnNewWordsCubit.get(context).leftOff = width/2- (width-64)/4;
              }
              if (state is SelectLeftIncorrect) {
                LearnNewWordsCubit.get(context).opsLeft = 1;
                LearnNewWordsCubit.get(context).opsRight = 0;
                LearnNewWordsCubit.get(context).opsBravooImage = 0;
                LearnNewWordsCubit.get(context).border_color = Colors.red;
                LearnNewWordsCubit.get(context).word_color = Colors.red;
                LearnNewWordsCubit.get(context).wrong = LearnNewWordsCubit.get(context).wrong + 1;
                LearnNewWordsCubit.get(context).leftOff = width/2- (width-64)/4;
              }
              if (state is SelectRightCorrect) {
                LearnNewWordsCubit.get(context).opsLeft = 0;
                LearnNewWordsCubit.get(context).opsRight = 1;
                LearnNewWordsCubit.get(context).opsBravooImage = 1;
                LearnNewWordsCubit.get(context).word_color = Colors.green;
                LearnNewWordsCubit.get(context).correct = LearnNewWordsCubit.get(context).correct + 1;

                LearnNewWordsCubit.get(context).bgImage = 'bg_green.png';
                LearnNewWordsCubit.get(context).border_color = Colors.green;
                LearnNewWordsCubit.get(context).rightOff = width/2- (width-64)/4;
              }
              if (state is SelectRightIncorrect) {
                LearnNewWordsCubit.get(context).opsLeft = 0;
                LearnNewWordsCubit.get(context).opsRight = 1;
                LearnNewWordsCubit.get(context).opsBravooImage = 0;
                LearnNewWordsCubit.get(context).border_color = Colors.red;
                LearnNewWordsCubit.get(context).word_color = Colors.red;
                LearnNewWordsCubit.get(context).rightOff = width/2 - (width-64)/4;
                LearnNewWordsCubit.get(context).wrong = LearnNewWordsCubit.get(context).wrong + 1;
              }
              if (state is GetNextWord) {
                LearnNewWordsCubit.get(context).opsLeft = 1;
                LearnNewWordsCubit.get(context).opsRight = 1;
                LearnNewWordsCubit.get(context).opsBravooImage = 0;
                LearnNewWordsCubit.get(context).border_color = Colors.white;
                LearnNewWordsCubit.get(context).word_color = DarkBlue;
                LearnNewWordsCubit.get(context).bgImage = 'bgred.png';
                LearnNewWordsCubit.get(context).leftOff = 16;
                LearnNewWordsCubit.get(context).rightOff = 16;
              }
            },
            builder: (context, state) {
              List<Word> allWords = widget.allWords;
              int wordIndex = LearnNewWordsCubit.get(context).wordIndex;

              if(state is LearnFinish) {
                return  FinishTraining(
                  trainingCubit:widget.trainingCubit,
                  wrong: LearnNewWordsCubit.get(context).wrong,
                  correct: LearnNewWordsCubit.get(context).correct,
                );
              }
              if(allWords.isEmpty){
                return Center(
                  child: Image.asset('assets/images/loading.gif'),
                );
              }

              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),

                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Container(
                          // margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.white12)),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            child: LinearProgressIndicator(
                              backgroundColor: Colors.grey[200],
                              color: Orange,
                              minHeight: 12,
                              value: LearnNewWordsCubit.get(context).value,
                            ),
                          ),
                        ),
                      ),
                    ),

                    if (LearnNewWordsCubit.get(context).ShowSkip)
                      Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                            child: Text(
                              'تخطي',
                              style: TextStyle(color: Grey, fontSize: 18),
                            ),
                            onPressed: () {
                              OutBottomSheet2(
                                onTapped: (){
                                  LearnNewWordsCubit.get(context).wordOperations.insertToDublicated(
                                    id: allWords[wordIndex].id,
                                    word: allWords[wordIndex].word,
                                    word1: allWords[wordIndex].word1,
                                    image: allWords[wordIndex].image,
                                    correct_word: allWords[wordIndex].correct_word,
                                    level_id: int.parse(allWords[wordIndex].level_id,),
                                    object_id: int.parse(allWords[wordIndex].object_id,),
                                    type_id: 1,
                                  );
                                  LearnNewWordsCubit.get(context).getTheNext(allWords.length);
                                  Navigator.pop(context);
                                },
                                word: allWords[wordIndex],
                                title: 'هل هذه الكلمة صعبة؟ \n هل تريد اضافتها الى المحفظة؟',
                                context: context,
                                ButtonNameOne: 'الغاء',
                                ButtonNameTow: 'نعم',
                              );
                            }),
                      ),

                    Container(
                      height: height * 0.28,
                      width: height * 0.28,
                      padding: const EdgeInsets.all(40),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage('assets/images/${LearnNewWordsCubit.get(context).bgImage}',), fit: BoxFit.cover),
                      ),
                      child: Center(
                        child: Container(
                          height: width * 0.4,
                          width: width * 0.4, decoration: BoxDecoration(shape: BoxShape.circle,
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
                                    LearnNewWordsCubit.get(context).speckBrtain('${allWords[wordIndex].word}\n${allWords[wordIndex].word1}');
                                  },
                                ),
                                const SizedBox(width: 32),
                                WordSound(
                                  lang: 'US',
                                  onTaped: () {
                                    LearnNewWordsCubit.get(context).speckAmercan('${allWords[wordIndex].word}\n${allWords[wordIndex].word1}',);
                                  },
                                ),
                              ],
                            ),

                          if(CacheHelper.getData(key: 'lanCode') != 'US-UK')
                            WordSound(
                              lang: 'US',
                              onTaped: () {
                                if (CacheHelper.getData(key: 'lanCode') == 'en-UK') {
                                  LearnNewWordsCubit.get(
                                      context).speckBrtain('${allWords[wordIndex].word}\n${allWords[wordIndex].word1}',);
                                } else if (CacheHelper.getData(key: 'lanCode') == 'en-US') {
                                  LearnNewWordsCubit.get(context).speckAmercan('${allWords[wordIndex].word}\n${allWords[wordIndex].word1}',);
                                }
                                },
                            ),
                          const SizedBox(width: 32,),

                          InkWell(
                            onTap: () {
                              LearnNewWordsCubit.get(context).wordOperations.insertToDublicated(
                                id: allWords[wordIndex].id,
                                word: allWords[wordIndex].word,
                                word1: allWords[wordIndex].word1,
                                image: allWords[wordIndex].image,
                                correct_word: allWords[wordIndex].correct_word,
                                level_id: int.parse(allWords[wordIndex].level_id,),
                                object_id: int.parse(allWords[wordIndex].object_id,),
                                type_id: 1,
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
                    AnswerNewWordBody(
                      word: allWords[wordIndex],
                      learnNewWordsCubit: DuplicatedCubit.get(context),
                      width: width,
                    ),
                    const Spacer(),

                    if(LearnNewWordsCubit.get(context).showNextButtom)
                      GestureDetector(
                        onTap: () {
                          if (state is SelectRightCorrect || state is SelectRightIncorrect || state is SelectLeftIncorrect || state is SelectLeftCorrect) {
                            LearnNewWordsCubit.get(context).getTheNext(allWords.length);
                          } else {
                            print('no word select');
                          }
                        },
                        child: Container(
                        decoration: BoxDecoration(
                          color: LearnNewWordsCubit.get(
                              context)
                              .bgColor,
                          borderRadius:
                          BorderRadius.circular(28),
                        ),
                        //       width: width * 0.5,
                        width: 190,
                        height: 55,
                        child: const Center(
                          child: Text(
                            'التالي',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const Spacer(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                          child: SvgPicture.asset(
                            'assets/icons/out.svg',
                            fit: BoxFit.fill,
                            width: width * 0.08,
                            height: 30,
                          ),
                          onPressed: () {
                            showOutTrainingDialog(
                              onTappedContinue: (){},
                              onTappedExit: (){
                                widget.trainingCubit.update();
                                Navigator.pop(context);
                              },
                              title: 'هل تريد الخروج حقا ...مازلنا \n في بداية التمرين؟؟',
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
*/
