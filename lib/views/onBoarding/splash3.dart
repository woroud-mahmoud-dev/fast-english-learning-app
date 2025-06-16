import 'package:fast/views/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../utlis/constant.dart';
import '../widgets/route_animation.dart';


class Splash3 extends StatefulWidget {
  final int indexSpalsh;


  const Splash3({Key? key, required this.indexSpalsh, }) : super(key: key);

  @override
  State<Splash3> createState() => _Splash3State();
}

class _Splash3State extends State<Splash3> {



  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

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
                  //child: Image.asset("assets/images/$image.png"),
                ),
                Container(
                    height: height/4,
                    margin: const EdgeInsets.only(left: 32 , right: 32),
                    //child: Text( description, style: TextStyle(fontSize:20 ,color: BlueGrey,fontFamily: 'Tajawal', fontWeight: FontWeight.bold ),textAlign: TextAlign.center,)
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
      ),
    );
  }

  void onPressedContinueButton() {


  }

  void onPressedTextButtonCallback() {


  }
}
