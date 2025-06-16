import 'package:fast/cubit/user_options_cubit.dart';
import 'package:fast/cubit/user_opotios_states.dart';
import 'package:fast/local_storage/word_operation.dart';
import 'package:fast/model/my_services.dart';
import 'package:fast/network/local/chach_helper.dart';
import 'package:fast/utlis/constant.dart';
import 'package:fast/views/home/home_screen.dart';
import 'package:fast/views/widgets/circle_widget.dart';
import 'package:fast/views/widgets/show_toast.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showToast(text: 'عذرا لا يمكنك الخروج الآن', color: Colors.red);
        return false;
      },
      child: Scaffold(
        body: BlocProvider(
          create: (BuildContext context) => UserOptionsCubit()..insertSelectedSubjects(),

          child: BlocConsumer<UserOptionsCubit, SelectObjectStates>(
            listener: (context, state) {
              debugPrint(state.toString());

              if(state is SaveSelectedObjectsSuccess){
                WordOperations operations = WordOperations();
                operations.countCorrectWord().then((value) {
                  CacheHelper.saveData(key: 'end_point', value: 5 );
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Home(homeData: value,)));
                });
              }
            },
            builder: (context, state) {


              return Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/images/background2.png',
                        ),
                        fit: BoxFit.cover)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.06,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 40,),
                                child: Image.asset(
                                  'assets/images/indicator6.png',
                                  fit: BoxFit.contain,
                                  //   width: MediaQuery.of(context).size.width * 0.9,
                                  height: 60,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.only(bottom: 40, left: 10),
                              child: InkWell(
                                onTap: (){
                                  Navigator.of(context).pop();
                                },
                                child: SvgPicture.asset(
                                    'assets/icons/arrow_back_icon.svg',
                                    fit: BoxFit.contain,
                                    width:
                                    MediaQuery.of(context).size.width * 0.08),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.05,
                        ),
                        Text(
                          'يتم الان تحضير خطة تعلمك \n يرجى الانتظار',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              height: 2,

                              color: Orange),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.1,
                        ),   const Center(
                          child: CircleWidget(),
                        ),


                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
