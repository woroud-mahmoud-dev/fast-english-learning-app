import 'package:fast/model/object.dart';
import 'package:flutter/material.dart';

class SelectSubjects extends StatefulWidget {
  /// [onSelect] callBack to handle the Selected subjects
  final Function onSelect;
  int value;
  String name;
  bool isSlected;

  /// List of subjects of type `subjectInWeek`
  List<SubjectModel> Subjects;

  /// [backgroundColor] - property to change the color of the container.
  final Color? backgroundColor;

  /// [fontWeight] - property to change the weight of selected text
  final FontWeight? fontWeight;

  /// [fontSize] - property to change the size of selected text
  final double? fontSize;

  /// [subjectsFillColor] -  property to change the button color of subjects when the button is pressed.
  final Color? subjectsFillColor;

  /// [subjectsBorderColor] - property to change the bordercolor of the rounded buttons.
  final Color? subjectsBorderColor;

  /// [selectedSubjectTextColor] - property to change the color of text when the subject is selected.
  final Color? selectedSubjectTextColor;

  /// [unSelectedsubjectTextColor] - property to change the text color when the subject is not selected.
  final Color? unSelectedsubjectTextColor;

  /// [border] Boolean to handle the subject button border by default the border will be true.
  final bool border;

  /// [boxDecoration] to handle the decoration of the container.
  final BoxDecoration? boxDecoration;

  /// [padding] property  to handle the padding between the container and buttons by default it is 8.0
  final double padding;

  /// `SelectWeeksubjects` takes a list of subjects of type `subjectInWeek`.
  /// `onSelect` property will return `list` of subjects that are selected.
  SelectSubjects({
    required this.value,
    required this.name,
    required this.onSelect,
    required this.isSlected,
    this.backgroundColor,
    this.fontWeight,
    this.fontSize,
    this.subjectsFillColor,
    this.subjectsBorderColor,
    this.selectedSubjectTextColor,
    this.unSelectedsubjectTextColor,
    this.border = true,
    this.boxDecoration,
    this.padding = 8.0,
    required this.Subjects,
    Key? key,
  }) : super(key: key);

  @override
  _SelectSubjectsState createState() => _SelectSubjectsState();
}

class _SelectSubjectsState extends State<SelectSubjects> {
  @override
  Color? get _handleBackgroundColor {
    if (widget.backgroundColor == null) {
      return Theme.of(context).dialogBackgroundColor;
      // return Theme.of(context).accentColor;
    } else {
      return widget.backgroundColor;
    }
  }

// getter to handle fill color of buttons.
  Color? get _handlesubjectsFillColor {
    if (widget.subjectsFillColor == null) {
      return Colors.white;
    } else {
      return widget.subjectsFillColor;
    }
  }

//getter to handle border color of subjects[buttons].
  Color? get _handleBorderColorOfsubjects {
    if (widget.subjectsBorderColor == null) {
      return Colors.white;
    } else {
      return widget.subjectsBorderColor;
    }
  }

// Handler to change the text color when the button is pressed and not pressed.
  Color? _handleTextColor(bool onSelect) {
    if (onSelect == true) {
      if (widget.selectedSubjectTextColor == null) {
        return Colors.black;
      } else {
        return widget.selectedSubjectTextColor;
      }
    } else if (onSelect == false) {
      if (widget.unSelectedsubjectTextColor == null) {
        return Colors.white;
      } else {
        return widget.unSelectedsubjectTextColor;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(16),
        ),
        color: widget.isSlected == true ? _handlesubjectsFillColor : null,
        elevation: 2,
        margin: EdgeInsets.all(3.0),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Text(
                  '${widget.name}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: _handleTextColor(widget.isSlected),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
