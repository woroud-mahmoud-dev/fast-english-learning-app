import 'package:fast/views/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../utlis/constant.dart';


class Splash2 extends StatefulWidget {
  final int indexSplash;


  const Splash2({Key? key, required this.indexSplash, }) : super(key: key);

  @override
  State<Splash2> createState() => _Splash2State();
}

class _Splash2State extends State<Splash2> {
  List descriptions=[
    "بتقنية التكرار المتباعد والتعلم بلا مجهود",
    "عبر العديد من الوسائل السماعية والتكرار والكتابة",
    "ميزة الربط مع ترجمة جوجل السريعة والدقيقة",
    "خطتنا تعتمد على تقسيم مراحل التعلم إلى عدة خطوات لتبسيط وتثبيت الجمل والكلمات",
    "إمكانية التسويق للتطبيق بالعمولة",
  ];

  List images = [
    "4",
    "5",
    "6",
    "7",
    "8",
  ];


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    String description = descriptions[widget.indexSplash];
    String image =images[widget.indexSplash];

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Container(
          color: Colors.white,
          height: height,
          width: width,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[
                const SizedBox(height: 30,),
                Container(
                  height: 56,
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: onPressedTextButtonCallback,
                    child:const  Text("تخطي", style: TextStyle(fontSize:18 ,color: Colors.grey,fontFamily: 'Tajawal')),
                  ),
                ),
                Container(
                    width: height/3,
                    height: height/3,
                    margin: const EdgeInsets.all(16),
                    alignment: Alignment.center,
                    child: Image.asset("assets/images/$image.png"),
                ),
                Container(
                    height: height/4,
                    margin: const EdgeInsets.only(left: 32 , right: 32),
                    child: Text( description, style: TextStyle(fontSize:20 ,color: BlueGrey,fontFamily: 'Tajawal', fontWeight: FontWeight.bold ),textAlign: TextAlign.center,)),

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
      ),
    );
  }

  void onPressedContinueButton() {
    if(widget.indexSplash <4 ){
      Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: Splash2(indexSplash: (widget.indexSplash)+1,), duration:const Duration(microseconds: 800)));
    }else{
      Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: const Login(), duration:const Duration(microseconds: 800)));}
  }

  void onPressedTextButtonCallback() {
    Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: const Login(), duration:const Duration(microseconds: 800)));
  }

}
