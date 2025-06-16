import 'dart:ffi';

import 'package:flutter/material.dart';

import '../../utlis/constant.dart';

class IndicatorController {
  late VoidCallback voidCallback;
  late Function animatedTo;

  void dispose() {}
}

class LinerIndicator extends StatefulWidget {
  final double? height;
  final double width;
  final Color? colorBorder;
  final Color? color;
  final double? value;
  final Color? backgroundColor;
  final Widget? icon;
  final IndicatorController? controller;
  final bool showPer;
  const LinerIndicator({
    Key? key,
    this.icon,
    this.height,
    required this.width,
    this.colorBorder,
    this.color,
    this.controller,
    required this.showPer,
    this.backgroundColor,
    this.value,
  }) : super(key: key);

  @override
  State<LinerIndicator> createState() => _LinerIndicatorState();
}

class _LinerIndicatorState extends State<LinerIndicator>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;
  late double endT;
  late double startT;
  late Color color;
  late Color backgroundColor;
  late Color colorBorder;
  late bool showPer;
  late IndicatorController controller;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? IndicatorController();
    controller.animatedTo = animatedTo;
    showPer = widget.showPer;

    backgroundColor = widget.backgroundColor ?? Colors.transparent;

    color = widget.color ?? LightOrange;
    colorBorder = widget.colorBorder ?? LightOrange;

    startT = 0;
    endT = widget.value ?? 0;
    animationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation =
        Tween<double>(begin: startT, end: endT).animate(animationController)
          ..addListener(() {
            if (mounted) {
              setState(() {});
            }
          });
    if (widget.value != null) {
      animationController.forward().then((value) {
        startT = animation.value;
        endT = widget.value!;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }

  void animatedTo(double end) {
    animationController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    animation =
        Tween<double>(begin: startT, end: end).animate(animationController)
          ..addListener(() {
            if (mounted) {
              setState(() {});
            }
          });
    animationController.forward().then((value) {
      startT = animation.value;
      endT = end;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = widget.height ?? 12;
    double width = widget.width;

    return SizedBox(
      height: 50,
      child: Stack(
        children: [
          Container(
            height: height,
            width: width,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: colorBorder)),
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                Container(
                  width: width * animation.value / 100,
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: height + 4,
            right: width * animation.value / 100 + 5,
            child: Visibility(
              visible: widget.icon != null,
              child: widget.icon == null ? Container() : widget.icon!,
            ),
          ),
          Visibility(
            visible: showPer,
            child: Positioned(
              top: height + 6,
              right: 10,
              child: Text('${animation.value.toInt()}%',
                  style: TextStyle(
                    color: Orange,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
