/*
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:fast/cubit/training/duplicated_training_cubit.dart';
import 'package:fast/cubit/training/voice_training_states.dart';
import 'package:fast/utlis/constant.dart';
import 'package:fast/views/widgets/CustomBottomSheet.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../cubit/training/training_cubit.dart';
import '../../cubit/training/voice_training_cubit.dart';
import '../../local_storage/word_operation.dart';
import '../../model/word.dart';
import '../widgets/finish_training.dart';
import '../widgets/linerIndicator.dart';
import '../widgets/training/answer_voice_training_body.dart';

class VoiceTraining extends StatelessWidget {
  final List<Word> allWords;
  final TrainingCubit trainingCubit;

  const VoiceTraining({Key? key, required this.allWords, required this.trainingCubit}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    IndicatorController  indicatorController = IndicatorController();
    RecorderController controllerR = RecorderController();


    return WillPopScope(
      onWillPop: () async {
        trainingCubit.update();
        return true;
      },
      child: Scaffold(
        body: BlocProvider(
          create: (BuildContext context) => VoiceTrainingCubit(),
          child: BlocConsumer<VoiceTrainingCubit, VoiceTrainingStates>(
            listener: (context, state) {
              */
/*if(state is VoiceCorrect){
                VoiceTrainingCubit.get(context).opsBravoImage = 1;
                VoiceTrainingCubit.get(context).correct++;
                VoiceTrainingCubit.get(context).bgImage = 'bg_green.png';
                VoiceTrainingCubit.get(context).showNextButton = true;
              }

              if(state is VoiceIncorrect){
                VoiceTrainingCubit.get(context).incorrect++;
                VoiceTrainingCubit.get(context).bgImage = 'bg_green.png';
                VoiceTrainingCubit.get(context).showNextButton = true;
              }

              if (state is GetNextWord) {
                VoiceTrainingCubit.get(context).opsBravoImage = 0;
                VoiceTrainingCubit.get(context).bgImage = 'bgred.png';
              }

              if(state is StartRecordState){
                controllerR.record();
              }

              if(state is StopRecordState){
                controllerR.stop();
                VoiceTrainingCubit.get(context).checkResult();
              }*/
/*


            },
            builder: (context, state) {
              VoiceTrainingCubit.get(context).wordsList = allWords;
              List<Word> myWords = allWords;
              int wordIndex = VoiceTrainingCubit.get(context).wordIndex;
              String correct = myWords[wordIndex].correct_word;
              if (kDebugMode) {
                print ('you say ${VoiceTrainingCubit.get(context).textVoice} and correct word is $correct');
              }


              if(state is VoiceTrainingFinish) {
                return  FinishTraining(
                  trainingCubit:trainingCubit,
                  wrong: VoiceTrainingCubit.get(context).incorrect,
                  correct: VoiceTrainingCubit.get(context).correct,
                );
              }
              if(allWords.isEmpty){
                return Center(
                  child: Image.asset('assets/images/loading.gif'),
                );
              }



              return SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(top: 40 ,left: 4.0 , right: 4.0 ,bottom: 4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
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
                                  style: TextStyle(color: Grey, fontSize: 18),
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
                                          type_id: 3,
                                        );
                                        VoiceTrainingCubit.get(context).getTheNext(allWords.length);
                                        Navigator.pop(context);
                                      },
                                      title: 'هل هذه الكلمة صعبة؟ \n هل تريد اضافتها الى المحفظة؟',
                                      context: context,
                                      ButtonNameOne: 'الغاء',
                                      word: allWords[wordIndex],
                                      ButtonNameTow: 'نعم');
                                },
                            ),
                          ),
                        ],
                      ),

                      Container(
                        height: height * 0.28,
                        width: height * 0.28,
                        padding: const EdgeInsets.all(40),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/${VoiceTrainingCubit.get(context).bgImage}',
                                ),
                                fit: BoxFit.cover,
                            ),
                        ),
                        child: Center(
                          child: Container(
                            height: width * 0.4,
                            width: width * 0.4,
                            decoration: BoxDecoration(shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(imageUrl + allWords[wordIndex].image),
                              fit: BoxFit.cover,
                            ),
                          ),
                          ),
                        ),
                      ),

                      Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 20),
                        child: InkWell(
                          onTap: () {
                            VoiceTrainingCubit.get(context).addToDuplicateWordTable();
                          },
                          child: SvgPicture.asset(
                            'assets/icons/add_to.svg',
                            fit: BoxFit.fill,
                            width: width * 0.08,
                            height: 30,
                          ),
                        ),
                      ),
                      AnswerVoiceTrainingBody(
                        recorderController: controllerR,
                        width:width ,
                        voiceTrainingCubit: DuplicatedCubit.get(context),
                      ),

                      if(VoiceTrainingCubit.get(context).showNextButton)
                        GestureDetector(
                          onTap: () {

                            VoiceTrainingCubit.get(context).getTheNext(allWords.length);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: VoiceTrainingCubit.get(context).bgColor,
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
                                    fontSize: 20),
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
