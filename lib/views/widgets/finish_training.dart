import 'package:fast/cubit/training/training_cubit.dart';
import 'package:fast/utlis/constant.dart';
import 'package:flutter/material.dart';


class FinishTraining extends StatelessWidget {
  final int ?correct;
  final int ?wrong;
  final TrainingCubit trainingCubit;
  const FinishTraining({Key? key, this.correct, this.wrong, required this.trainingCubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          Image.asset('assets/images/con1.gif',height: 100,),

          Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              'لقد انهيت مهمة اليوم',
              style: TextStyle(
                  color: DarkBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          const Spacer(),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              'عدد الاجابات الصحيحة : $correct',
              style: TextStyle(
                  color: Green,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
              textAlign: TextAlign.start,
            ),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              'عدد الاجابات الخاطئة : $wrong ',
              style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
              textAlign: TextAlign.start,
            ),
          ),
          Image.asset(
            'assets/images/con2.gif',
            height: 400,
          ),
          InkWell(
            onTap: () {
              trainingCubit.update();
              Navigator.of(context).pop();
            },
            child: Text(
              'خروج',
              style: TextStyle(color: DarkBlue, fontSize: 20),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
