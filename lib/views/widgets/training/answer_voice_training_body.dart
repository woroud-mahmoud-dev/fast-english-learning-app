
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../cubit/training/duplicated_training_cubit.dart';

class AnswerVoiceTrainingBody extends StatelessWidget {
  final DuplicatedCubit voiceTrainingCubit;
  final double width;
  final RecorderController recorderController;
  const AnswerVoiceTrainingBody({Key? key, required this.voiceTrainingCubit, required this.width, required this.recorderController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          voiceTrainingCubit.textVoice,
          style:const TextStyle(
            color: Colors.orange,
            fontSize: 28,
            fontWeight:
            FontWeight.bold,
          ),
        ),
        SizedBox(
          width: width,
          height: 150,
          child: Stack(
            children: [
              Positioned(
                right: -60,
                top: -20,
                child: AnimatedOpacity(
                  opacity: voiceTrainingCubit.opsBravoImage,
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.bounceInOut,
                  child: Image.asset(
                    'assets/images/bravo.png',
                    width: 150,
                    height: 160,
                  ),
                ),
              ),
              if(!voiceTrainingCubit.showNextButton)
                SizedBox(
                  height: 120,
                  width: width,
                  child: Column(
                    children: [
                      AudioWaveforms(
                        size:const Size(150, 20.0),
                        recorderController: recorderController,
                        enableGesture: false,
                        waveStyle: const WaveStyle(
                          waveColor: Colors.red,
                          showTop: true,
                          showHourInDuration: true,
                          showDurationLabel: false,
                          spacing: 8.0,
                          showBottom: true,
                          extendWaveform: true,
                          showMiddleLine: false,
                        ),
                      ),
                      AvatarGlow(
                        animate: voiceTrainingCubit.isListening,
                        glowColor: Theme.of(context).primaryColor,
                        endRadius: 30.0,
                        duration: const Duration(milliseconds: 2000),
                        repeatPauseDuration: const Duration(milliseconds: 100),
                        repeat: true,
                        child: GestureDetector(
                          onPanStart: (val){
                            //voiceTrainingCubit.textVoice = '';
                            voiceTrainingCubit.onRecord(recorderController);
                            if (kDebugMode) {
                              print('start recording!');
                            }
                          },
                          onPanEnd: (val){
                            voiceTrainingCubit.onRecord(recorderController);
                            if (kDebugMode) {
                              print('end recording!');
                            }
                          },
                          child: const Icon(

                            Icons.keyboard_voice,

                            size: 50 ,
                            //size: 75,
                          ),
                        ),

                      ),
                      const Text("جرب تكرار الكلمة",style: TextStyle(fontSize: 18),),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
