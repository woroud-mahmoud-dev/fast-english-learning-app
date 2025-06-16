import 'package:fast/views/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:page_transition/page_transition.dart';

class CircleWidget extends StatefulWidget {
  const CircleWidget({Key? key}) : super(key: key);

  @override
  // ignore: override_on_non_overriding_member
  State<CircleWidget> createState() => _CircleWidgetState();
}

class _CircleWidgetState extends State<CircleWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> rotateAnimation;
  static const Color progressColor = Color(0xffFEB100);

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    rotateAnimation =
        Tween<double>(begin: 0.0, end: 2 * pi).animate(_controller);
    _controller.repeat(period: const Duration(seconds: 4));



    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget? child) => Transform.rotate(
          angle: rotateAnimation.value,
          child: child,
        ),
        child: Image.asset(
          'assets/images/qq.png',
          color: progressColor,
          scale: 4,
        ),
      );
}
