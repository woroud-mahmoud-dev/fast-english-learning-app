import 'package:fast/cubit/training/learned_words_states.dart';

import 'package:fast/local_storage/subject_operation.dart';
import 'package:fast/local_storage/word_operation.dart';

import 'package:flutter/material.dart';



import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../model/object.dart';
import '../../model/word.dart';

class LearnedWordsCubit extends Cubit<LearnedWordsStates> {
  LearnedWordsCubit() : super(LearnedWordsInitialState());

  static LearnedWordsCubit get(context) => BlocProvider.of(context);
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

  SubjectOperations operations=SubjectOperations();
  WordOperations wordOperations =WordOperations();
  List<SubjectModel> subjcts = [];

  Future<List<SubjectModel>> getSubjects() async {
    isLoading = !isLoading;
    List<SubjectModel> response = await operations.getSelectedSubjects();
    subjcts.addAll(response);

    emit(LoadedWordsState());
    return response;
  }
  List<Word> subjectWords = [];
  Future<List<Word>> getSubjectWords(int index) async {
    
    isLoadingSubjectWords = !isLoadingSubjectWords;
    // wordOperations.getCorrectWords();
    List<Word> response = await wordOperations.getCorrectWordsBySubjectId(index);
    subjectWords.addAll(response);
    emit(LearnedWordsLoadedSuccessState());
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
 
  Future speakUS(String s)async{
    await flutterTts.setLanguage('en-US');
    if (s.isNotEmpty) {
      await flutterTts.speak(s);
      //emit(SpeackState());
    }
  }
  Future speckUK(String s)async{
    await flutterTts.setLanguage('en-GB');
    if (s.isNotEmpty) {
      await flutterTts.speak(s);
    }
  }
}
