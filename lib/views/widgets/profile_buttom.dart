
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utlis/constant.dart';


class ProfileButton extends StatefulWidget {
  final String text;
  final String? chooseItem;
  final String? iconPath;
  final double width;
  final Function onTaped;

  const ProfileButton({Key? key, required this.text,  this.chooseItem, this.iconPath, required this.onTaped, required this.width}) : super(key: key);

  @override
  State<ProfileButton> createState() => _ProfileButtonState();
}

class _ProfileButtonState extends State<ProfileButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        widget.onTaped();
      },
      child: Container(
        margin: const EdgeInsets.only(top: 8,bottom: 4),
        padding: const EdgeInsets.all(8) ,
        height: 56,
        width:widget.width,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),

        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  widget.iconPath!=null ? SvgPicture.asset(widget.iconPath!):Container(),
                  (widget.chooseItem != null)?Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:  Text(widget.chooseItem!,style: TextStyle(fontWeight: FontWeight.bold , fontSize: 16 ,color: DarkBlue),),
                  ):Container(),
                ],
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: Text(widget.text),
              ),
            )

          ],
        ),
      ),
    );
  }
}
