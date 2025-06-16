import 'package:fast/cubit/exam_cubit.dart';
import 'package:fast/model/question.dart';
import 'package:fast/network/local/chach_helper.dart';
import 'package:fast/views/user_options/select_object_screen.dart';
import 'package:fast/views/widgets/finish_training.dart';
import 'package:fast/views/widgets/on_boarding/exam_option.dart';
import 'package:fast/views/widgets/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import '../../utlis/constant.dart';
import '../widgets/linerIndicator.dart';

class Exam extends StatelessWidget {
  final int indexSpalsh;
  final bool? isNotFirstTime;
  const Exam({Key? key, required this.indexSpalsh, this.isNotFirstTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body:BlocProvider(
          create: (context) {
            ExamCubit examCubit = ExamCubit();
            return examCubit;
          },
          child: BlocConsumer<ExamCubit, ExamState>(
            listener: (context, state) {
              if(state is  ExamEmpty){
                  showToast(text: 'لا يوجد اسئلة حاليا لهذا المستوى', color: Colors.green);
              }
              if(state is SendResultError){
                  showToast(text: 'عذرا حدث خطأ ما الرجاء المحاولة لاحقاً', color: Colors.green);
              }

              if(state is SendResultDown){
                if(isNotFirstTime!=null && isNotFirstTime!) {
                  Navigator.of(context).pop();
                }else{
                  CacheHelper.saveData(key: 'end_point', value: 1);
                  Navigator.push(context, PageTransition(type: PageTransitionType.fade, child:  const SelectObject(), duration:const Duration(microseconds: 800)));
                }
              }

            },
            builder: (context, state) {

              if(state is ExamFinish || state is SendResultLoading){

                return Container(
                  color: Colors.white,
                  height: height,
                  width: width,

                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Spacer(),
                        Image.asset('assets/images/con1.gif',height: 100,),

                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Text(
                            'لقد انهيت إختبار تحديد المستوى',
                            style: TextStyle(
                                color: DarkBlue,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Text(
                            'عدد الاجابات الصحيحة : ${ExamCubit.get(context).correct}',
                            style: TextStyle(
                                color: Green,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Text(
                            'عدد الاجابات الخاطئة : ${ExamCubit.get(context).allQuestion.length - ExamCubit.get(context).correct} ',
                            style: const TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        const SizedBox(height: 32,),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Text(
                            'تهانينا تم قبولك في المستوى ${ExamCubit.get(context).level}',
                            style: TextStyle(
                              color: Orange,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Image.asset(
                          'assets/images/con2.gif',
                          height: 400,
                        ),
                        GestureDetector(
                          onTap: () {
                            ExamCubit.get(context).sendResult();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16 , right: 16 ),
                            child: Container(
                              height: 56,
                              width: width,
                              decoration: BoxDecoration(
                                  color:(state is! SendResultLoading)? LightOrange: Colors.grey.withOpacity(.5),
                                  borderRadius: BorderRadius.circular(32)
                              ),
                              child: Center(
                                child: Text(
                                  ExamCubit.get(context).nextButtonTitle,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontFamily: 'Tajawal',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        const Spacer(),
                      ],
                    ),
                  ),

                );
              }

              Question current =  ExamCubit.get(context).currentQ;

              return Container(
                color: Colors.white,
                height: height,
                width: width,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:[
                      const SizedBox(height: 40,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 56,
                            width: width-50,
                            alignment: Alignment.topRight,
                            child: LinerIndicator(
                              width: width - 90,
                              controller: ExamCubit.get(context).indicatorController!,
                              showPer: false,
                              icon: SizedBox(
                                  height: 25,
                                  child: Image.asset(
                                    "assets/icons/indicatorExamIcon.png",
                                  ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              if(isNotFirstTime != null && isNotFirstTime!){
                                Navigator.of(context).pop();
                              }
                            },
                            child: Container(
                              width: 50,
                              height:56 ,
                              alignment: Alignment.topCenter,
                              child:SvgPicture.asset("assets/icons/back.svg"),
                            ),
                          ),
                        ],
                      ),
                      Container(
                          height: 75,
                          margin: const EdgeInsets.only(left: 32 , right: 32),
                          child: Text(
                            ExamCubit.get(context).questionText,
                            style: TextStyle(
                                fontSize: 18,
                                color: BlueGrey,
                                fontFamily: 'Tajawal',
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          )),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.all(16),
                          alignment: Alignment.center,
                          child: (ExamCubit.get(context).isStarted==true && ExamCubit.get(context).isReady == false)?SizedBox(height: 300, child: Image.asset("assets/images/exam.png")):
                          Column(
                            children: [

                              ExamOption(
                                title: current.answers[0],
                                width: width,
                                height: 56,
                                onTapped: (){
                                  ExamCubit.get(context).onPressedToggleButton(0);
                                },
                                isSelected:ExamCubit.get(context).toggleButtons[0] ,
                              ),
                              ExamOption(
                                title: current.answers[1],
                                width: width,
                                height: 56,
                                onTapped: (){
                                  ExamCubit.get(context).onPressedToggleButton(1);
                                },
                                isSelected:ExamCubit.get(context).toggleButtons[1] ,
                              ),
                              ExamOption(
                                title: current.answers[2],
                                width: width,
                                height: 56,
                                onTapped: (){
                                  ExamCubit.get(context).onPressedToggleButton(2);
                                },
                                isSelected:ExamCubit.get(context).toggleButtons[2] ,
                              ),
                            ],

                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          if(state is! QuestionsLoading){
                            ExamCubit.get(context).onPressedContinueButton();
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16 , right: 16 ),
                          child: Container(
                            height: 56,
                            width: width,
                            decoration: BoxDecoration(
                                color:(state is! QuestionsLoading)? LightOrange: Colors.grey.withOpacity(.5),
                                borderRadius: BorderRadius.circular(32)
                            ),
                            child: Center(
                                child: Text(
                                ExamCubit.get(context).nextButtonTitle,
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontFamily: 'Tajawal',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 56,
                        child: Visibility(
                          visible: ExamCubit.get(context).isStarted,
                          child: TextButton(onPressed:(){ExamCubit.get(context).onPressedTextButtonCallback(context,isNotFirstTime);},
                            child: Text("تخطي", style: TextStyle(fontSize:18 ,color:BlueGrey,fontFamily: 'Tajawal'),),
                          ),
                        ),
                      )
                    ]
                ),

              );
            },
          ),
        ),
      ),
    );
  }
}

