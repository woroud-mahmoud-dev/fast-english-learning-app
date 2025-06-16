import 'package:assets_audio_player/assets_audio_player.dart';

import 'package:fast/cubit/new_word_states.dart';
import 'package:fast/local_storage/word_operation.dart';

import 'package:fast/model/word.dart';

import 'package:fast/utlis/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';

enum TtsState { playing, stopped, paused, continued }

class LearnNewWordsCubit extends Cubit<LearnNewWordsStates> {
  LearnNewWordsCubit() : super(LearnNewWordsInitialState());

  FlutterTts flutterTts = FlutterTts();

  String? language;
  double rate = 0.5;
  double volume = 0.5;
  double pitch = 1.0;
  String? newVoiceText;
  double value = 0;
  int wordIndex = 0;
  bool showNextButtom = false;
  bool ShowSkip = true;
  double leftOffest = 200;
  Color? bgColor = Colors.purple[100];

  double opsLeft = 1;
  double opsRight = 1;
  double leftOff = 16;
  double centerAnimate = 120.0;
  double opsBravooImage = 0;
  double rightOff = 16;
  Color border_color = Colors.white;
  Color word_color = DarkBlue;
  String bgImage = 'bgred.png';
  int correct = 0;
  int wrong = 0;
  WordOperations wordOperations = WordOperations();




  static LearnNewWordsCubit get(context) => BlocProvider.of(context);

  Future speckAmercan(String s) async {
    await flutterTts.setLanguage('en-US');
    if (s.isNotEmpty) {
      await flutterTts.speak(s);
    }
  }

  addToWallet(Word word) {
    word.type = 1;
    operations.insertToDublicated(word: word);

    emit(AddToDuplicateWordTableSucces());
  }

  Future speckBrtain(String s) async {
    await flutterTts.setLanguage('en-GB');
    if (s.isNotEmpty) {
      await flutterTts.speak(s);
    }
  }

  bool isLoading = true;

  void raisedProgress(int lenght) {
    double step = 1 / lenght;
    value = value + step;
    emit(RasiedProgress());
  }

  WordOperations operations = WordOperations();

  checkResult({required bool isRight,required Word word}) async {
    String result;
    if(isRight){
      result = word.word1;
    }else{
      result = word.word;
    }

    await flutterTts.speak(result);

    if (result == word.correct_word) {
      word.type = 1;

      operations.insertToCorrect(word: word);


      bgColor = Colors.green[300];
      ShowSkip = true;
      showNextButtom = true;
      if (!isRight){
        emit(SelectLeftCorrect());
      } else if (isRight) {
        emit(SelectRightCorrect());
      }
    } else {
      word.type = 1;
      operations.insertToWrong(word: word);

      bgColor = Colors.red[300];
      showNextButtom = true;
      ShowSkip = true;

      if (!isRight) {
        emit(SelectLeftIncorrect());
      } else if (isRight) {
        emit(SelectRightIncorrect());
      }
    }
  }

  //Get the Next Word
  getTheNext(int lenght) {
    if (wordIndex == lenght - 1) {
      emit(LearnFinish());

      final assetsAudioPlayer = AssetsAudioPlayer();

      assetsAudioPlayer.open(Audio("assets/cartoon_success_fanfair.mp3"),);
    } else {
      wordIndex = wordIndex + 1;
      raisedProgress(lenght);
      bgColor = Orange;
      emit(GetNextWord());
    }
  }
}
