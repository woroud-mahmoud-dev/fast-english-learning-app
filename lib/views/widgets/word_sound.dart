

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WordSound extends StatelessWidget {
  final Function? onTaped;
  final String? lang;
  const WordSound({Key? key, this.onTaped, this.lang}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if(onTaped != null){
          onTaped!();
        }

      },
      child: Column(
        children: [
          if(lang != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: SvgPicture.asset(
              "assets/icons/$lang.svg",
              width: 25,
              height: 15,
              fit: BoxFit.cover,
            ),
          ),

          SvgPicture.asset(
            'assets/icons/person_icon.svg',
            fit: BoxFit.fill,
            width: MediaQuery.of(context).size.width * 0.08,
            height: 25,
          ),
        ],
      ),
    );
  }
}
