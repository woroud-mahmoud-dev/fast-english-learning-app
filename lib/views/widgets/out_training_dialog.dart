

import 'package:flutter/material.dart';

import '../../utlis/constant.dart';

class OutTrainingDialog extends StatelessWidget {
  final String title ;
  final Function onTappedContinue;
  final Function onTappedExit;
  final String? yesText;
  final String? noText;
  const OutTrainingDialog({Key? key, required this.title, required this.onTappedContinue, required this.onTappedExit, this.yesText, this.noText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                        fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          onTappedExit();
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
                              yesText??'خروج',
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
                          Navigator.pop(context);
                          onTappedContinue();
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
                              noText??'استمرار',
                              style:const TextStyle(
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
  }
}
