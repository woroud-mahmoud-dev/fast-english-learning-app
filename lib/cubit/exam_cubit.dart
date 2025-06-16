import 'package:fast/model/question.dart';
import 'package:fast/network/remote/dio_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../model/question.dart';
import '../network/local/chach_helper.dart';
import '../views/user_options/select_object_screen.dart';
import '../views/widgets/linerIndicator.dart';
import '../views/widgets/show_toast.dart';

part 'exam_state.dart';

class ExamCubit extends Cubit<ExamState> {
  ExamCubit() : super(ExamInitial());
  static ExamCubit get(context) => BlocProvider.of(context);

  List<Question> allQuestion = <Question>[];
  IndicatorController? indicatorController = IndicatorController();
  List toggleButtons = List.generate(3, (index) => false);

  String answer = '';
  String level ='سهل';
  String nextButtonTitle ='ابدأ';
  bool isStarted = false;
  bool isReady = false;
  int indexQ = 0;
  int correct = 0;

  Question currentQ =  Question(
      word3: "صعب",
      word2: "متوسط",
      updatedAt: '',
      correctWord: '',
      createdAt: '',
      level: "مبتدئ",
      text: 'ماهو مستواك في اللغة الانجليزية؟',
      id: 1,
      word1: "مبتدئ");

  String questionText = 'ماهو مستواك في اللغة الانجليزية؟';


  getQuestions(){
    nextButtonTitle = 'انتظر لحظة';
    emit(QuestionsLoading());

    DioHelper.postData(url: 'level_selection', data: {
      'token': CacheHelper.getData(key: 'api_token'),
      'level':level,
    }).then((value) {
      if (kDebugMode) {
        print('data is :${value?.data}');
      }
       allQuestion = value!.data.map<Question>((item) => Question.fromJson(item),).toList();
       if(allQuestion.isEmpty){
         emit(ExamEmpty());
         return;
       }
      nextButtonTitle = 'استمرار';

      indexQ = 0;
        currentQ = allQuestion[indexQ];
      emit(QuestionsDown());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(QuestionsError());
    });
  }
  sendResult(){
    emit(SendResultLoading());

    DioHelper.postData(url: 'level-save', data: {
      'token': CacheHelper.getData(key: 'api_token'),
      'level':level,
    }).then((value) {
      if (kDebugMode) {
        print('data is :${value!.data}');
      }
      if(value!.data['title'] == 'success'){
        emit(SendResultDown());
      }else{
        emit(SendResultError());
      }

    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(SendResultError());
    });
  }


  void onPressedContinueButton() {
    bool isSelected = false;

    for (int i = 0; i < 3; i ++) {
      if ( toggleButtons[i]) {
        isSelected = true;
      }
    }

    if (!isSelected) {
      showToast(text: ' الرجاء اختيار إجابة اولا', color: Colors.green);
      return;
    }

    /// if user is started exam

    //if exam is not started
    if ( isStarted == false) {
      nextButtonTitle = 'استمرار';
      questionText = "هيا نقوم بإختبار سريع مكون من 10 أسئلة لنتأكد من المستوى";
      indicatorController!.animatedTo(20.0);
      isStarted = true;
      getQuestions();
      return;
    }
    nextButtonTitle = "التالي";
    questionText = currentQ.text;

    // if user is not ready
    if ( isReady == false) {
         isReady = true;
         toggleButtons = List.generate(3, (index) => false);
         emit(ExamUpdate());
      return;
    }


    if(answer == currentQ.correctWord){
      correct++;
    }

    indexQ++;
    toggleButtons = List.generate(3, (index) => false);


    if ( indexQ == allQuestion.length) {
      if(correct / allQuestion.length < 7/10){
        level = 'سهل';
      }
      emit(ExamFinish());
      return;
    }

    currentQ = allQuestion[indexQ];
    questionText = currentQ.text;
    emit(ExamUpdate());

  }


  void onPressedTextButtonCallback(BuildContext context, bool? isNotFirstTime) {
    if(isNotFirstTime!=null && isNotFirstTime) {
      Navigator.of(context).pop();
    }else{
      Navigator.push(context, PageTransition(type: PageTransitionType.fade, child:  const SelectObject(), duration:const Duration(microseconds: 800)));
    }
  }

  void onPressedToggleButton(int index) {
    if(isStarted){
      answer =  currentQ.answers[index];
    }else{
      level = currentQ.answers[index];
    }
      for (int i = 0; i < 3; i++) {
        if (i == index) {
          toggleButtons[i] = true;
        } else {
          toggleButtons[i] = false;
        }
      }
      emit(ExamUpdate());
  }


}
  

