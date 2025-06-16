import 'package:fast/views/onBoarding/splash2.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../utlis/constant.dart';
import '../widgets/route_animation.dart';


class SelectLanguage extends StatefulWidget {
  const SelectLanguage({Key? key}) : super(key: key);

  @override
  State<SelectLanguage> createState() => _SelectLanguageState();
}

class _SelectLanguageState extends State<SelectLanguage> {
  List toggleButtons = List.generate(2, (index) => false);


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        color: Colors.white,
        height: height,
        width: width,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[

              SizedBox(height: height/52,),

              Text("اختر لغتك المفضلة" , style: TextStyle(fontSize:20 ,color: BlueGrey,fontFamily: 'Tajawal', fontWeight: FontWeight.bold),),
              GestureDetector(
                onTap: (){onPressedToggleButton(0);},
                child: Container(
                  margin: const EdgeInsets.all(16),
                  height: 56,
                  width: width,
                  decoration: BoxDecoration(
                      color:(toggleButtons[0])?DarkBlue :Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset:const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(16)
                  ),

                  child: Center(child: Text('عربي', style: TextStyle(fontSize:18 ,color:(toggleButtons[0])?Colors.white:BlueGrey,fontFamily: 'Tajawal'),)),
                ),
              ),
              GestureDetector(
                onTap: (){onPressedToggleButton(1);},
                child: Container(
                  margin: const EdgeInsets.all(16),
                  height: 56,
                  width: width,
                  decoration: BoxDecoration(
                      color:(toggleButtons[1])?DarkBlue :Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset:const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(16)
                  ),

                  child: Center(child: Text('English', style: TextStyle(fontSize:18 ,color:(toggleButtons[1])?Colors.white:BlueGrey ,fontFamily: 'Tajawal'),)),
                ),
              ),
              Container(
                width: width,
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                      height: width/1.5,
                      width:width/1.5,
                      child: Image.asset("assets/images/3.png")
                  )
              ),
              GestureDetector(
                onTap: onPressedContinueButton,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16 , right: 16 , bottom: 64),
                  child: Container(
                    height: 56,
                    width: width,
                    decoration: BoxDecoration(
                        color: LightOrange,
                        borderRadius: BorderRadius.circular(32)
                    ),

                    child:const Center(child: Text('استمرار', style: TextStyle(fontSize:18 ,color: Colors.white,fontFamily: 'Tajawal'),)),
                  ),
                ),
              )
            ]
        ),

      ),
    );
  }

  void onPressedToggleButton(int index) {
    setState((){
      if(index == 1){
        toggleButtons[1] = true;
        toggleButtons[0] = false;
      }else{
        toggleButtons[0] = true;
        toggleButtons[1] = false;
      }
    });


  }

  void onPressedContinueButton() {
    Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: const Splash2(indexSplash: 0,), duration:const Duration(microseconds: 800)));
  }
}
