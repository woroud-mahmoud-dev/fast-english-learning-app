
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class TrainingButton extends StatelessWidget {
  final Function onTaped;
  final String title;
  final int allWords;
  final int? learnWords;
  final int? duplicatesWords;
  final bool? isDuplicates;
  final Color color;

  const TrainingButton({Key? key, required this.onTaped, required this.title, required this.allWords, this.learnWords, this.isDuplicates, required this.color, this.duplicatesWords}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String per ='';
    if(duplicatesWords==null){
      if(allWords != 0){
        List <String> sp = ((learnWords!*100)/allWords).toStringAsFixed(5).split('.');
        per = '${sp[0]}.${sp[1].toString().substring(0,1)}';
      }
    }
    return GestureDetector(
      onTap: (){onTaped();},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: color,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5.0,
              // has the effect of softening the shadow
              spreadRadius: 2,
              // has the effect of extending the shadow
              offset: Offset(
                2.0, // horizontal, move right 10
                4.0, // vertical, move down 10
              ),
            )
          ],
        ),
        //   height:120,
        child: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Text(
                (duplicatesWords!=null)?duplicatesWords!.toString():"${learnWords!}/$allWords",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: SizedBox(
                  height: 60,
                  width: 60,
                  child: CircularPercentIndicator(
                    radius: 28.0,
                    lineWidth: 3.0,
                    percent: (duplicatesWords!=null || allWords == 0)?1.0 : learnWords!/allWords,
                    center: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        (duplicatesWords!=null)? duplicatesWords!.toString(): "$per%",

                        textAlign: TextAlign.center,
                        style:
                        TextStyle(color: Colors.white , fontSize: (learnWords != null)?null : 16),
                      ),
                    ),
                    progressColor: Colors.white,
                    backgroundColor: Colors.white54,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
