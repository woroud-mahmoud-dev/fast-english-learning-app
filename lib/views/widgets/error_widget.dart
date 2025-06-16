


import 'package:flutter/material.dart';

import '../../utlis/constant.dart';

class FastErrorWidget extends StatelessWidget {
  final Function onTapped;
  const FastErrorWidget({
    Key? key, required this.onTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "حدث خطأ ما الرجاء إعادة المحاولة",
          style: TextStyle(fontSize: 14, color: DarkBlue),
        ),
        IconButton(
          onPressed: ()=>onTapped(),
          icon: Icon(Icons.refresh, size: 40, color: DarkBlue),
        ),
      ],
    );
  }
}