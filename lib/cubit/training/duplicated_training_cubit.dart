import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:fast/cubit/training/written_training_cubit.dart';
import 'package:fast/local_storage/word_operation.dart';
import 'package:fast/model/my_services.dart';
import 'package:fast/model/word.dart';
import 'package:fast/utlis/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../../views/widgets/show_toast.dart';
part 'duplicated_training_states.dart';

class DuplicatedCubit extends Cubit<DuplicatedTrainingStates> {
  late List<Word>? allWords;
  final int type;
  DuplicatedCubit({required this.type, this.allWords})
      : super(DuplicatedTrainingState());

  static DuplicatedCubit get(context) => BlocProvider.of(context);

  int trainingType = 0;
  WordOperations wordOperations = WordOperations();
  FlutterTts flutterTts = FlutterTts();
  final assetsAudioPlayer = AssetsAudioPlayer();
  stt.SpeechToText speech = stt.SpeechToText();

  Color? bgColor = Orange;
  Color borderColor = Colors.white;
  Color wordColor = DarkBlue;

  List<Character> randomC = [];
  List<Character> answer = [];
  String answerWord = '';

  String? language;
  String? newVoiceText;
  String textVoice = '';
  String bgImage = 'bgred.png';

  int wordIndex = 0;
  int correct = 0;
  int incorrect = 0;

  double rate = 0.5;
  double volume = 0.5;
  double pitch = 1.0;
  double value = 0;
  double leftOffset = 200;
  double confidence = 1.0;
  double opsBravoImage = 0;
  double opsLeft = 1;
  double opsRight = 1;
  double leftOff = 16;
  double rightOff = 16;
  double centerAnimate = 120.0;

  bool isLoadingSubjectWords = false;
  bool showSkip = false;
  bool isListening = false;
  bool showNextButton = false;
  bool isLoading = true;

  void init() {
    trainingType = type;
    if (type == 0) {
      allWords ??= [];
      getDuplicatedWords(subId);
    } else {
      randomC = [];
      answer = [];
      randomC = Character.addRandomLetters(
          correct: allWords![wordIndex].correct_word);
      answerWord = '';
      emit(GetDuplicatedWordsDownState());
    }
  }

  Future speckUS(String s) async {
    await flutterTts.setLanguage('en-US');
    if (s.isNotEmpty) {
      await flutterTts.speak(s);
    }
  }

  Future speckUK(String s) async {
    await flutterTts.setLanguage('en-GB');
    if (s.isNotEmpty) {
      await flutterTts.speak(s);
    }
  }

  void getDuplicatedWords(int index) async {
    isLoadingSubjectWords = true;
    emit(GetDuplicatedWordsLoadingState());
    List<Map<String, dynamic>> response =
        await wordOperations.getDuplicatedWordsBySubjectId(index);
    //print('type_id: ${response[0]['type_id']}');

    allWords = response.map<Word>((e) => Word.fromMap(e)).toList();
    if (allWords == null || allWords!.isEmpty) {
      emit(GetDuplicatedWordsEmptyState());
      return;
    }
    randomC = [];
    answer = [];
    randomC =
        Character.addRandomLetters(correct: allWords![wordIndex].correct_word);
    answerWord = '';
    trainingType = allWords![0].type!;
    emit(GetDuplicatedWordsDownState());
  }

  void raisedProgress(int length) {
    double step = 1 / length;
    value = value + step;
    emit(TrainingRaisedProgress());
  }

  addToAnswer(Character ch) {
    showNextButton = false;
    ch.isSelected = true;
    int index = randomC.indexOf(ch);
    randomC[index].isSelected = true;
    answer.add(ch);
    answerWord = answerWord + ch.c;
    print(answerWord);
    emit(AddToAnswerState());
  }

  removeFromAnswer(Character ch) {
    showNextButton = false;
    answer.remove(ch);

    int index = randomC.indexOf(ch);
    randomC[index].isSelected = false;

    answerWord = '';

    for (int i = 0; i < answer.length; i++) {
      answerWord = answerWord + answer[i].c;
    }
    emit(RemoveFromAnswerState());
  }

  checkResultChoice(
      {required bool isRight,
      required Word word,
      required double width}) async {
    String result;
    if (isRight) {
      result = word.word1;
    } else {
      result = word.word;
    }

    await flutterTts.speak(result);
    if (result.toUpperCase() == word.correct_word.toUpperCase()) {
      bgColor = Colors.green[300];
      showSkip = true;
      showNextButton = true;
      if (type != 0) {
        word.type = 1;
        wordOperations.insertToCorrect(
          word: word,
        );
      }
      if (isRight) {
        opsLeft = 0;
        opsRight = 1;
        opsBravoImage = 1;
        wordColor = Colors.green;
        bgImage = 'bg_green.png';
        borderColor = Colors.green;
        rightOff = width / 2 - (width - 64) / 4;
        correct++;

        emit(TrainingSelectRightCorrect());
      } else {
        opsLeft = 1;
        opsRight = 0;
        opsBravoImage = 1;
        borderColor = Colors.green;
        wordColor = Colors.green;
        bgImage = 'bg_green.png';
        leftOff = width / 2 - (width - 64) / 4;
        correct++;

        emit(TrainingSelectLeftCorrect());
      }
    } else {
      bgColor = Colors.red[300];
      showNextButton = true;
      showSkip = true;
      if (type != 0) {
        word.type = 1;
        wordOperations.insertToWrong(
          word: word,
        );
      }
      if (isRight) {
        opsLeft = 0;
        opsRight = 1;
        opsBravoImage = 0;
        borderColor = Colors.red;
        wordColor = Colors.red;
        rightOff = width / 2 - (width - 64) / 4;
        incorrect++;
        emit(TrainingSelectRightIncorrect());
      } else {
        opsLeft = 1;
        opsRight = 0;
        opsBravoImage = 0;
        borderColor = Colors.red;
        wordColor = Colors.red;
        leftOff = width / 2 - (width - 64) / 4;
        incorrect++;
        emit(TrainingSelectLeftIncorrect());
      }
    }
  }

  checkResultWritten(Word word) {
    flutterTts.speak(answerWord);

    if (answerWord.compareTo(word.correct_word) == 0) {
      if (type != 0) {
        word.type = 2;
        wordOperations.insertToCorrect(word: word);
      }
      bgColor = Colors.green[300];
      showSkip = true;
      showNextButton = true;
      opsBravoImage = 1;
      borderColor = Colors.green;
      bgImage = 'bg_green.png';
      correct++;

      emit(WriteWordCorrect());
    } else {
      if (type != 0) {
        word.type = 2;
        wordOperations.insertToWrong(word: word);
      }
      bgColor = Colors.red[300];
      showNextButton = true;
      showSkip = true;
      opsBravoImage = 0;
      borderColor = Colors.red;
      incorrect++;

      emit(WriteWordUnCorrect());
    }
  }

  checkResultVoice() {
    if (textVoice.isEmpty) {
      showToast(text: 'الرجاء إعادة المحاولة', color: Colors.red);
      return;
    }
    flutterTts.speak(textVoice);

    showNextButton = true;

    if (textVoice.toUpperCase() ==
        allWords![wordIndex].correct_word.toUpperCase()) {
      if (type != 0) {
        allWords![wordIndex].type = 3;
        wordOperations.insertToCorrect(
          word: allWords![wordIndex],
        );
      }

      bgColor = Colors.green[300];
      opsBravoImage = 1;
      correct++;
      bgImage = 'bg_green.png';
      showNextButton = true;

      emit(VoiceCorrect());
    } else {
      if (type != 0) {
        allWords![wordIndex].type = 3;
        wordOperations.insertToWrong(word: allWords![wordIndex]);
      }

      bgColor = Colors.red[300];
      incorrect++;
      bgImage = 'bg_green.png';
      showNextButton = true;
      emit(VoiceIncorrect());
    }
  }

  addToDuplicateWordTable() {
    if (type == 0) {
      return;
    }
    allWords![wordIndex].type = type;
    var response = wordOperations.insertToDublicated(
      word: allWords![wordIndex],
    );

    if (response == 1) {
      emit(AddToDuplicateWordTableSuccess());
    } else {
      emit(AddToDuplicateWordTableError());
    }
  }

  removeFromDuplicateWordTable() {
    if (type != 0) {
      return;
    }
    var response = wordOperations.deleteFromDuplicated(allWords![wordIndex].id);
    getTheNext();
    if (response == 1) {
      emit(AddToDuplicateWordTableSuccess());
    } else {
      emit(AddToDuplicateWordTableError());
    }
  }

  //Get the Next Word
  getTheNext() {
    int length = allWords!.length;
    if (wordIndex == length - 1) {
      emit(TrainingFinish());

      assetsAudioPlayer.open(
        Audio("assets/cartoon_success_fanfair.mp3"),
      );
    } else {
      bgColor = Orange;
      borderColor = Colors.white;
      wordColor = DarkBlue;
      opsBravoImage = 0;
      opsRight = 1;
      opsLeft = 1;
      leftOff = 16;
      rightOff = 16;
      wordIndex = wordIndex + 1;
      bgImage = 'bgred.png';
      showNextButton = false;

      randomC = [];
      answer = [];
      randomC = Character.addRandomLetters(
          correct: allWords![wordIndex].correct_word);
      answerWord = '';
      trainingType = allWords![wordIndex].type ?? type;
      raisedProgress(length);
      emit(TrainingGetNextWord());
    }
  }

  onRecord(RecorderController controllerR) async {
    if (!isListening) {
      textVoice = '';
      PermissionStatus statusPermissionRecord =
          await Permission.microphone.status;

      bool available = await speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (!statusPermissionRecord.isGranted) {
        return;
      }

      if (available) {
        isListening = true;
        controllerR.record();
        emit(StartRecordState());
        speech.listen(
          localeId: 'en_US',
          pauseFor: const Duration(seconds: 5),
          onResult: (val) {
            textVoice = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {
              confidence = val.confidence;
            }
            emit(ListeningWordsState());
          },
        );
      }
    } else {
      isListening = false;
      speech.stop();
      controllerR.stop();
      checkResultVoice();
      emit(StopRecordState());
    }
  }
}
