

import 'package:fast/utlis/constant.dart';
import 'package:flutter/material.dart';

class ExamOption extends StatelessWidget {
  final double width ;
  final double height;
  final bool isSelected;
  final Function onTapped;
  final String title;
  const ExamOption({Key? key, required this.width, required this.height, required this.isSelected, required this.onTapped, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onTapped();
        },
      child: Container(
        margin: const EdgeInsets.all(16),
        height: height,
        width: width,
        decoration: BoxDecoration(
            color:isSelected?DarkBlue :Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 3,
                offset:const Offset(0, 3), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(16)
        ),
        child: Center(
            child: Text(
           title,
          style: TextStyle(
              fontSize: 18,
              color: isSelected
                  ? Colors.white
                  : BlueGrey,
              fontFamily: 'Tajawal'),
        )),
      ),
    );
  }
}
