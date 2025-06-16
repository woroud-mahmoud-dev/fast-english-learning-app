// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:expandable/expandable.dart';
import 'package:fast/model/my_services.dart';
import 'package:fast/model/stories_by_subject.dart';
import 'package:fast/model/story.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'dart:math' as math;

import 'package:fast/utlis/constant.dart';


formItem({
  required IconData icon,
  required bool obscureText,
  required TextEditingController controller,
  required String labelText,
  required TextInputType type,
  required final String? Function(String?)? validate,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Expanded(
          flex: 1,
          child: Icon(
            icon,
            color: BlueGrey,
            size: 30,
          )),
      Expanded(
        flex: 5,
        child: TextFormField(
          style: TextStyle(
            color: BlueGrey,
          ),
          keyboardType: type,
          validator: validate,
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10),
            labelText: labelText,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: BlueGrey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: BlueGrey),
            ),
            labelStyle: TextStyle(
                color: BlueGrey, fontSize: 16, fontWeight: FontWeight.normal),
          ),
          controller: controller,
        ),
      ),
    ],
  );
}

customButton(String text, Color color) {
  return Container(
    decoration:
        BoxDecoration(borderRadius: BorderRadius.circular(12), color: color),
    width: 212,
    height: 54,
    child: Center(
        child: Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
    )),
  );
}

customButton2(String text, Color color) {
  return Container(
    decoration:
        BoxDecoration(borderRadius: BorderRadius.circular(31), color: color),
    width: 326,
    height: 55,
    child: Center(
        child: Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
    )),
  );
}

BottomSheetBotton(
    {required String text,
    required Color bg_color,
    required Color txt_color,
    required void Function() onTap()}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: 138,
      height: 55,
      decoration: BoxDecoration(
        color: bg_color,
        border: Border.all(color: DarkBlue),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              fontSize: 20, color: txt_color, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}

FloatingButton() {
  return SizedBox(
    height: 40,
    width: 40,
    child: FloatingActionButton(
      onPressed: () {},
      backgroundColor: LightOrange,
      splashColor: Colors.black12,
      child: const Icon(Icons.search_rounded),
    ),
  );
}

class Stories extends StatelessWidget {
  final StoriesBySubject stories;

  const Stories({
    Key? key,
    required this.stories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(10),
      height: 100,
      width: width * 0.9,
      decoration: BoxDecoration(
        color: Orange,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
              percent: stories.per/100,
              center: Text(
                '${stories.per.toInt()}%',
                style: TextStyle(
                    color: DarkBlue, fontSize: 14, fontWeight: FontWeight.bold,
                ),
              ),
              progressColor: DarkBlue,
              backgroundColor: Colors.white54,
            ),
          ),
          Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    stories.subject.ar_title,
                    style: TextStyle(
                        fontSize: 14,
                        color: DarkBlue,
                        fontWeight: FontWeight.bold),
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(
                      '${stories.stories.length} قصص ',
                      style: TextStyle(
                          fontSize: 12,
                          color: DarkBlue,
                          fontWeight: FontWeight.w100),
                    ),
                  ),
                ],
              )),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: DarkBlue,
                border: Border.all(color: Grey)),
          )
        ],
      ),
    );
  }
}

Widget noDuplicatedWordsMessage() {
  return Center(
      child: Text(
    'لا توجد كلمات مكررة  لعرضها !',
    style: TextStyle(
      color: Orange,
      fontSize: 18,
    ),
  ));
}

class ShowText extends StatelessWidget {
  final String txet;
  final String titleText;

  ShowText({
    Key? key,
    required this.txet, required this.titleText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: ScrollOnExpand(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: <Widget>[
              ExpandablePanel(
                theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToExpand: false,
                    tapBodyToCollapse: false,
                    alignment: Alignment.center,
                    hasIcon: false,
                    fadeCurve: Curves.bounceInOut),
                header: Row(
                  children: [
                    const Spacer(),
                    ExpandableIcon(
                      theme: const ExpandableThemeData(
                        expandIcon: Icons.arrow_drop_down,
                        collapseIcon: Icons.arrow_drop_up,
                        iconColor: Colors.orangeAccent,
                        iconSize: 28.0,
                        iconRotationAngle: math.pi / 2,
                        iconPadding: EdgeInsets.only(right: 5),
                        hasIcon: false,
                      ),
                    ),
                    Expanded(
                      child: Text(titleText,
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Orange,
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                    ),
                    const Spacer(),
                  ],
                ),
                collapsed: Container(),
                expanded: Text(
                  txet,
                  softWrap: true,
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
