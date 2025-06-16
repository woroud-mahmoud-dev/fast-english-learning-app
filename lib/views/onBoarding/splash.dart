import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/splash_cubit.dart';
import '../../utlis/constant.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

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
          child: BlocProvider(
            create: (context) {
              SplashCubit cubit =  SplashCubit();
              cubit.startApp(context);
              return cubit;
            },
            child: BlocConsumer<SplashCubit, SplashState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:[
                      const SizedBox(height: 30,),
                      SizedBox(
                        height: 100,
                        width: width,
                        child: AnimatedOpacity(
                          duration:const Duration(seconds: 1),
                          opacity: SplashCubit.get(context).visibleText,
                          child: Column(
                            children: [
                              Text("اهلا بك في تطبيق" , style: TextStyle(fontSize:20 ,color: DarkBlue,fontFamily: 'Tajawal',fontWeight: FontWeight.w600),),
                              Text("FAST" , style: TextStyle(fontSize:36 ,color: DarkBlue,fontFamily: 'Tajawal',fontWeight: FontWeight.bold),),
                              Text("بوابتك لتعلم اللغة الانجليزية" , style: TextStyle(fontSize:20 ,color: DarkBlue,fontFamily: 'Tajawal',fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                      ),
                      Stack(
                        children: [
                          AnimatedOpacity(
                            duration:const Duration(milliseconds: 500),
                            opacity: SplashCubit.get(context).visibleImage,
                            child: Center(
                              child: Container(
                                width: width,
                                height: width,
                                alignment: Alignment.center,
                                child: Image.asset("assets/images/1.png"),
                              ),
                            ),
                          ),
                          AnimatedOpacity(
                            opacity: SplashCubit.get(context).visibleImage,
                            duration:const Duration(milliseconds: 1500),
                            child: Center(
                              child: Container(
                                width: width,
                                height: width,
                                alignment: Alignment.center,
                                child: Image.asset("assets/images/hello.png"),
                              ),
                            ),
                          ),

                        ],
                      ),
                      SizedBox(
                        height: 120,
                        child: AnimatedOpacity(
                            duration:const Duration(seconds: 1),
                            opacity: SplashCubit.get(context).visibleButton,
                            child: GestureDetector(
                              onTap: (){
                                SplashCubit.get(context).onPressedStartButton(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16 , right: 16 , bottom: 64),
                                child: Container(
                                  height: 56,
                                  width: width,
                                  decoration: BoxDecoration(
                                      color: LightOrange,
                                      borderRadius: BorderRadius.circular(32)
                                  ),

                                  child:const Center(child: Text('ابدأ', style: TextStyle(fontSize:18 ,color: Colors.white,fontFamily: 'Tajawal'),)),
                                ),
                              ),
                            )
                        ),
                      )
                    ]
                );
              },
            ),
          ),

        ),
      ),
    );
  }

}



