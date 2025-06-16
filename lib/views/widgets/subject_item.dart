import 'package:fast/utlis/constant.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:percent_indicator/circular_percent_indicator.dart';

Widget subjectWidget(
  BuildContext context, {
  required subjectName,
}) {
  return Material(
    child: Container(
        margin: const EdgeInsets.only(bottom: 25, left: 15, right: 15),
        width: 300,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
              .withOpacity(0.5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              '25%',
              style: TextStyle(
                  fontSize: 12, color: DarkBlue, fontWeight: FontWeight.w100),
            ),
            const SizedBox(
              width: 5,
            ),
            Container(
              height: 45,
              width: 45,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: CircularPercentIndicator(
                radius: 22.1,
                lineWidth: 1.2,
                percent: 0.25,
                center: Text(
                  "استئناف",
                  style: TextStyle(fontSize: 11, color: DarkBlue),
                ),
                progressColor: DarkBlue,
                backgroundColor: Colors.white54,
              ),
            ),
            const Spacer(),
            Column(
              children: [
                Text(
                  subjectName,
                  style: TextStyle(
                      fontSize: 14,
                      color: DarkBlue,
                      fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Text(
                  ' كلمة 3/9 ',
                  style: TextStyle(
                      fontSize: 12,
                      color: DarkBlue,
                      fontWeight: FontWeight.w100),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: DarkBlue,
                  border: Border.all(color: Grey)),
            ),
          ],
        )),
  );
}
