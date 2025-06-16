import 'package:fast/utlis/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';



class CustomRadio3 extends StatefulWidget {
  int value;
  String name;
  var groupValue;

  final void Function(int) onChanged;
  CustomRadio3(
      {Key? key,


        required this.value,
        required this.name,
        required this.groupValue,
        required this.onChanged})
      : super(key: key);

  @override
  _CustomRadio3State createState() => _CustomRadio3State();
}

class _CustomRadio3State extends State<CustomRadio3> {
  @override
  Widget build(BuildContext context) {
    bool selected = (widget.value == widget.groupValue);

    return InkWell(
      onTap: () => widget.onChanged(widget.value),
      child: Card(
          color: selected ? DarkBlue : Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.white70, width: 1),
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 2,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text('${widget.name}',
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: selected ? Colors.white: Grey
                ),
              ),
            ),
          )
      ),
    );
  }

}

class CustomRadio4 extends StatefulWidget {
  int value;
  String name;
  String image;
  var groupValue;

  final void Function(int) onChanged;
  CustomRadio4(
      {Key? key,


        required this.value,
        required this.name,
        required this.image,
        required this.groupValue,
        required this.onChanged})
      : super(key: key);

  @override
  _CustomRadio4State createState() => _CustomRadio4State();
}

class _CustomRadio4State extends State<CustomRadio4> {
  @override
  Widget build(BuildContext context) {
    bool selected = (widget.value == widget.groupValue);

    return InkWell(
      onTap: () => widget.onChanged(widget.value),
      child: Card(
          color: selected ? DarkBlue : Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.white70, width: 1),
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              SvgPicture.asset(widget.image,
                  fit: BoxFit.contain,
                  width: MediaQuery.of(context).size.width * 0.08),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('${widget.name}',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: selected ? Colors.white: Grey
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }

}

class CustomRadio5 extends StatefulWidget {
  int value;
  String name;
  var groupValue;

  final void Function(int) onChanged;
  CustomRadio5(
      {Key? key,


        required this.value,
        required this.name,
        required this.groupValue,
        required this.onChanged})
      : super(key: key);

  @override
  _CustomRadio5State createState() => _CustomRadio5State();
}

class _CustomRadio5State extends State<CustomRadio5> {
  @override
  Widget build(BuildContext context) {
    bool selected = (widget.value == widget.groupValue);

    return InkWell(
      onTap: () => widget.onChanged(widget.value),
      child: Container(
        decoration: BoxDecoration(
          color: selected ? DarkBlue : Colors.white,
shape: BoxShape.circle,
          border: Border.all(
            color: Orange
          ),
        ),

          child: Center(
            child: Text('${widget.name}',
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: selected ? Colors.white: Grey
              ),
            ),
          )
      ),
    );
  }

}