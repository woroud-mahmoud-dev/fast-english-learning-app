

import 'package:flutter/material.dart';

import '../../../cubit/training/duplicated_training_cubit.dart';
import '../../../cubit/training/written_training_cubit.dart';
import '../../../model/word.dart';
import '../../../utlis/constant.dart';


class AnswerWrittenTrainingBody extends StatelessWidget {
  final DuplicatedCubit writtenTrainingCubit;
  final double width;
  final String answerWord;
  final Word word;
  
  const AnswerWrittenTrainingBody({Key? key, required this.writtenTrainingCubit, required this.width, required this.answerWord,required this.word}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Column(
      
      children: [
        if(writtenTrainingCubit.showNextButton)
          Container(
            padding: const EdgeInsets.only(top: 32),
            height: 160,
            width: width,
            child: Stack(
              children: [
                Positioned(
                  right: -60,
                  top: -20,
                  child: AnimatedOpacity(
                    opacity: writtenTrainingCubit.opsBravoImage,
                    duration: const Duration(milliseconds: 700),
                    curve: Curves.bounceInOut,
                    child: Image.asset(
                      'assets/images/bravo.png',
                      width: 150,
                      height: 160,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
          ),

        Align(
          alignment: Alignment.center,
          child: Text(
            answerWord,
            style: TextStyle(
              color: DarkBlue,
              fontSize: 40,
            ),
          ),
        ),
        Divider(
          color: Grey,
          endIndent: 50,
          indent: 50,
          thickness: 2,
        ),

        if(!writtenTrainingCubit.showNextButton)
          Wrap(
            spacing: 5,
            alignment: WrapAlignment.center,
            children: writtenTrainingCubit.randomC.map<Widget>((e) => GestureDetector(
              
              onTap: () {
                if(!e.isSelected ) {
                  writtenTrainingCubit.addToAnswer(e);
                }else{
                  writtenTrainingCubit.removeFromAnswer(e);
                }
              },
              child: Container(
                height: 50,
                width: 55,
                margin: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: e.isSelected ? writtenTrainingCubit.bgColor : Colors.white,
                  borderRadius:
                  BorderRadius.circular(5),
                  border: Border.all(
                    color: e.isSelected? writtenTrainingCubit.borderColor: DarkBlue,
                  ),
                ),
                child: Center(
                  child: Text(e.c,
                    style: TextStyle(
                      color: DarkBlue,
                      fontSize: 20,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            ).toList(),
          ),
        const SizedBox(
          height: 10,
        ),
        if(!writtenTrainingCubit.showNextButton)
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
                onTap: () {
                  if (answerWord.isEmpty) {
                    print('no letter select');
                  } else {
                    writtenTrainingCubit.checkResultWritten(word);
                  }
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                    color: writtenTrainingCubit.bgColor,
                    borderRadius:
                    BorderRadius.circular(28),
                  ),
                  //       width: MediaQuery.of(context).size.width * 0.5,
                  width: 150,
                  height: 45,
                  child: const Center(
                    child: Text(
                      'تحقق',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                )),
          ),
      ],
    );
  }
}
