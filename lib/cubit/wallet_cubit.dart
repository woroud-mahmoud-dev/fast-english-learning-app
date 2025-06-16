import 'package:bloc/bloc.dart';
import 'package:fast/local_storage/story_operation.dart';
import 'package:fast/local_storage/word_operation.dart';
import 'package:fast/model/story.dart';
import 'package:fast/model/word.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:meta/meta.dart';

part 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  WalletCubit() : super(WalletInitial());
  static WalletCubit get(context) => BlocProvider.of(context);
  bool showStories = false;
  bool showWords = true;
  bool showHardWords = true;
  bool showPerfectWords = false;
  bool showPreviousMistakes = false;
  double rate = 0.5;
  double volume = 0.5;
  double pitch = 1.0;

  FlutterTts flutterTts = FlutterTts();
  // 0=>showHardWords
  //1=>showPerfectWords
  //2=>showPreviousMistakes
  onPress(int index) {
    // print(index);
    // getHardWords();
    if (index == 0) {
      getStories();
      showStories = true;
      showWords = false;
      emit(ChangeScreenState());
    } else if (index == 1) {
      showStories = false;
      showWords = true;
      emit(ChangeScreenState());
    }
  }

  onPressWordsType(int index) {
    debugPrint(index.toString());
    if (index == 0) {
      showWords = true;

      showHardWords = true;
      showPerfectWords = false;
      showPreviousMistakes = false;
      emit(ChangeTypeWordsState());
    } else if (index == 1) {
      showWords = true;

      showHardWords = false;
      showPerfectWords = true;
      showPreviousMistakes = false;
      emit(ChangeTypeWordsState());
    } else if (index == 2) {
      showWords = true;

      showHardWords = false;
      showPerfectWords = false;
      showPreviousMistakes = true;
      emit(ChangeTypeWordsState());
    }
  }

  // Get words from local DB
  WordOperations operations = WordOperations();
  StoryOperations storyOperations=StoryOperations();
  List<Map<String ,dynamic>> hardWordsList = [];
  List<Map<String ,dynamic>> perfectWordsList = [];
  List<Map<String ,dynamic>> mistakesWordsList = [];
  List<Story> storiesList = [];
  void getAllWords() {}
  Future<List<Map>> getHardWords() async {
    print('in getHardWords ');
    emit(GetHardWordsLoadingState());
    //to do error change getSelectedSubjects =>getSubjects
    List<Map<String,dynamic>> response = await operations.getDuplicatedWords();
    print(response);
    hardWordsList.addAll(response);
    if (response.isNotEmpty) {
      emit(GetHardWordsSuccessState());
    } else {
      emit(GetHardWordsErrorState());
    }

    return response;
  }

  getPerfectWords() async {
    emit(GetPerfectWordsLoadingState());

    await operations.getCorrectWords().then((value) {
      perfectWordsList.addAll(value);
      print( 'perfectWordsList: $perfectWordsList');
      emit(GetPerfectWordsSuccessState());
    }).onError((error, stackTrace) {
      emit(GetPerfectWordsErrorState());
    });
  }

  getMistakeWords() async {
    emit(GetMistakeWordsLoadingState());

    await operations.getWrongWords().then((value) {
      mistakesWordsList.addAll(value);
      print('mistakesWordsList');
      print(mistakesWordsList);
      emit(GetMistakeWordsSuccessState());
    }).onError((error, stackTrace) {
      print ('error in wrong word');
      emit(GetMistakeWordsErrorState());

    });
  }
// Get stories
  getStories() async {
    emit(GetStoriesLoadingState());
    await storyOperations.getStories().then((value) {
      storiesList = value;
      print('hi');
      emit(GetStoriesSuccessState());
    }).onError((error, stackTrace) {
      emit(GetStoriesErrorState());
    });
  }
  ////speak
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

  Future speakAmercan(String s) async {
    await flutterTts.setLanguage('en-US');
    if (s.isNotEmpty) {
      await flutterTts.speak(s);
      //emit(SpeackState());
    }
  }

  Future speckBrtain(String s) async {
    await flutterTts.setLanguage('en-GB');
    if (s.isNotEmpty) {
      await flutterTts.speak(s);
    }
  }

  /////
  addToWallet() {
    emit(AddToDuplicateWordTableSucces());
    hardWordsList = [];
    perfectWordsList = [];
    mistakesWordsList = [];
    getMistakeWords();
    getPerfectWords();
    getHardWords();
  }

  deleteFromHard() {
    emit(DeleteSuccess());
    hardWordsList = [];
    perfectWordsList = [];
    mistakesWordsList = [];
    getMistakeWords();
    getPerfectWords();
    getHardWords();
  }
}
