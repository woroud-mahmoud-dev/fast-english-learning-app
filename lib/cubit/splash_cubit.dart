import 'package:fast/local_storage/word_operation.dart';
import 'package:fast/views/home/home_screen.dart';
import 'package:fast/views/onBoarding/exam.dart';
import 'package:fast/views/onBoarding/splash2.dart';
import 'package:fast/views/user_options/select_object_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import '../network/local/chach_helper.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {

  int  currentImage = 1;
  double visibleText = 0;
  double visibleButton = 0;
  double visibleImage = 0;
  Map<String , int>? homeData ;

  static SplashCubit get(context) => BlocProvider.of(context);


  SplashCubit() : super(SplashInitial());

  void startApp(BuildContext context)async{
    //await CacheHelper.clearData();
  emit(SplashStart());

  Future.delayed(const Duration(seconds: 2)).then((value) async{

    visibleImage = 1;
    emit(SplashImageIsVisible());
    var token =  await CacheHelper.getData(key: 'api_token');

    Future.delayed(const Duration(seconds: 2)).then((value)async {
        visibleText = 1;
        emit(SplashTextIsVisible());

        if(token != null){
          WordOperations operations = WordOperations();

          switch (CacheHelper.getData(key: 'end_point')){
            case 0 :
              Navigator.pushReplacement(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: const Exam(indexSpalsh: 0),
                  duration: const Duration(microseconds: 800),
                ),
              );
              break ;
            case 1:
              Navigator.push(context, PageTransition(type: PageTransitionType.fade, child:  const SelectObject(), duration:const Duration(microseconds: 800)));
              break;
            case 5:
              operations.countCorrectWord().then((value) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Home(homeData: value,)));
              });

              break;
            default:
            CacheHelper.clearData();
            visibleButton = 1;
            emit(SplashIsFirstTime());
          }



        }else{
          visibleButton = 1;
          emit(SplashIsFirstTime());
        }

    });

  });

  visibleText = 0;


  }


  void onPressedStartButton(BuildContext context) {
    emit(SelectLanguageStart());
    //Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: const SelectLanguage() , duration:const Duration(microseconds: 800)));
    Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: const Splash2(indexSplash: 0,), duration:const Duration(microseconds: 800)));

  }




}
