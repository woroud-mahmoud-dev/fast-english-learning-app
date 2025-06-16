import 'package:fast/cubit/new_word_cubit.dart';
import 'package:fast/cubit/new_word_states.dart';
import 'package:fast/model/word.dart';
import 'package:fast/utlis/constant.dart';
import 'package:fast/views/widgets/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'out_training_dialog.dart';

Future<dynamic> showOutTrainingDialog(
    {
      required BuildContext context,
      required String title,
      required Function onTappedExit,
      required Function onTappedContinue,
      String? yesText,
      String? noText,
    }) {
  return showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: const Color(0xff41BEF8).withAlpha(50),
    context: context,
    builder: (builder) {
      return OutTrainingDialog(title: title, onTappedExit: onTappedExit, onTappedContinue:onTappedContinue,yesText: yesText, noText: noText,);
    },
  );
}


OutBottomSheet3(
  BuildContext context, {
  required String title,
  required String ButtonNameOne,
  required String ButtonNameTow,
  required Function onTapped,
    }) {
  return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Color(0xff41BEF8).withAlpha(50),
      context: context,
      builder: (builder) {
        return BlocProvider(
          create: (BuildContext context) => LearnNewWordsCubit(),
          child: BlocConsumer<LearnNewWordsCubit, LearnNewWordsStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                decoration: const BoxDecoration(color: Colors.transparent),
                child: Column(
                  children: [
                    const Spacer(),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: double.infinity,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                  fontSize: 23,
                                  color: DarkBlue,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    onTapped();
                                  },
                                  child: Container(
                                    width: 138,
                                    height: 55,
                                    decoration: BoxDecoration(
                                      //    color: bg_color,
                                      border: Border.all(color: DarkBlue),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Center(
                                      child: Text(
                                        ButtonNameOne,
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: DarkBlue,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    width: 138,
                                    height: 55,
                                    decoration: BoxDecoration(
                                      color: DarkBlue,
                                      border: Border.all(color: DarkBlue),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Center(
                                      child: Text(
                                        ButtonNameTow,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        );
      });
}

Future <dynamic> OutBottomSheet2(
    {
      required BuildContext context,
      required String title,
      required String ButtonNameOne,
      required String ButtonNameTow,
      required Function onTapped,
      required Word word,
    }) {
  return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: const Color(0xff41BEF8).withAlpha(50),
      context: context,
      builder: (builder) {
        return BlocProvider(
          create: (BuildContext context) => LearnNewWordsCubit(),
          child: BlocConsumer<LearnNewWordsCubit, LearnNewWordsStates>(
              listener: (context, state) {
            if (state is AddToDuplicateWordTableSucces) {
              OutBottomSheet3(
                  title: 'تمت الاضافة بنجاح ',
                  context,
                  ButtonNameOne: 'خروج',
                  ButtonNameTow: 'استمرار', onTapped: (){
                onTapped();
                  });
            } else if (state is AddToWalletError) {
              showToast(text: 'حدث خطأ \n حاول مرة أخرى ', color: Colors.red);
            }
          }, builder: (context, state) {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              decoration: const BoxDecoration(color: Colors.transparent),
              child: Column(
                children: [
                  const Spacer(),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: double.infinity,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                                fontSize: 23,
                                color: DarkBlue,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  onTapped();
                                },
                                child: Container(
                                  width: 138,
                                  height: 55,
                                  decoration: BoxDecoration(
                                    //    color: bg_color,
                                    border: Border.all(color: DarkBlue),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Center(
                                    child: Text(
                                      ButtonNameOne,
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: DarkBlue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();

                                  LearnNewWordsCubit.get(context)
                                      .addToWallet(word);
                                },
                                child: Container(
                                  width: 138,
                                  height: 55,
                                  decoration: BoxDecoration(
                                    color: DarkBlue,
                                    border: Border.all(color: DarkBlue),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Center(
                                    child: Text(
                                      ButtonNameTow,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
        );
      });
}
