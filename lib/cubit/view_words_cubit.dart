import 'package:fast/cubit/training/learned_words_states.dart';
import 'package:fast/local_storage/word_operation.dart';
import 'package:fast/model/my_services.dart';
import 'package:fast/model/word.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ViewWordsCubit extends Cubit<LearnedWordsStates> {
  ViewWordsCubit() : super(LearnedWordsInitialState());

  static ViewWordsCubit get(context) => BlocProvider.of(context);
  int color = 5;
  String? language;
  double rate = 0.5;
  double volume = 0.5;
  double pitch = 1.0;


  FlutterTts flutterTts = FlutterTts();
  String objectNam='';

  var pagecontroller = PageController();
  bool isLoadingSubjectWords = false;
  bool isLoading = false;

  WordOperations wordOperations =WordOperations();
  List<Map> subjcts = [];


  List<Word> subjectWords = [];
  Future<List<Word>> getSubjectWords() async {
    isLoadingSubjectWords = !isLoadingSubjectWords;
    // wordOperations.getCorrectWords();
    List<Word> response = await wordOperations.getCorrectWordsBySubjectId(index);
    subjectWords.addAll(response);

    return response;
  }

//speak
  Future speakOne(String s) async {
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);
    if (s.isNotEmpty) {
      await flutterTts.speak(s);
      emit(SpeackState());
    }
    emit(StopSpaeckState());
  }

  Future speakAmercan(String s)async{
    await flutterTts.setLanguage('en-US');
    if (s.isNotEmpty) {
      await flutterTts.speak(s);
      //emit(SpeackState());
    }
  }
  Future speckBrtain(String s)async{
    await flutterTts.setLanguage('en-GB');
    if (s.isNotEmpty) {
      await flutterTts.speak(s);
    }
  }
}
