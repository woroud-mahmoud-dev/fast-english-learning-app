import 'package:flutter/material.dart';

import '../../../cubit/training/duplicated_training_cubit.dart';
import '../../../model/word.dart';

class AnswerNewWordBody extends StatelessWidget {
  final Word word;
  final double width;
  final DuplicatedCubit learnNewWordsCubit;
  const AnswerNewWordBody(
      {Key? key,
      required this.word,
      required this.width,
      required this.learnNewWordsCubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.red,
      height: 150,
      width: double.infinity,
      padding: const EdgeInsets.only(top: 32),
      child: Stack(
        children: [
          Positioned(
            right: -10,
            top: -15,
            child: AnimatedOpacity(
              opacity: learnNewWordsCubit.opsBravoImage,
              duration: const Duration(milliseconds: 700),
              curve: Curves.bounceInOut,
              child: Image.asset(
                'assets/images/bravo.png',
                width: 130,
                height: 140,
                fit: BoxFit.fill,
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            left: learnNewWordsCubit.leftOff,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: learnNewWordsCubit.opsLeft,
              child: GestureDetector(
                onTap: () {
                  if (learnNewWordsCubit.opsLeft == 0) {
                    return;
                  } else {
                    learnNewWordsCubit.checkResultChoice(
                        word: word, isRight: false, width: width);
                  }
                },
                child: Container(
                  height: 100,
                  width: (width - 64) / 2,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: learnNewWordsCubit.borderColor),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(1, 4),
                        blurRadius: 2,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      word.word,
                      style: TextStyle(
                        color: learnNewWordsCubit.wordColor,
                        fontSize: 20,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            right: learnNewWordsCubit.rightOff,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: learnNewWordsCubit.opsRight,
              child: GestureDetector(
                onTap: () {
                  if (learnNewWordsCubit.opsRight == 0) {
                    return;
                  } else {
                    learnNewWordsCubit.checkResultChoice(
                        word: word, isRight: true, width: width);
                  }
                },
                child: Container(
                  height: 100,
                  width: (width - 64) / 2,
                  decoration: BoxDecoration(
                    border: Border.all(color: learnNewWordsCubit.borderColor),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(1, 4),
                        blurRadius: 2,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      word.word1,
                      style: TextStyle(
                        color: learnNewWordsCubit.wordColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
