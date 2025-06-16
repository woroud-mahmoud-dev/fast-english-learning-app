import 'package:fast/model/day_in_week.dart';
import 'package:flutter/material.dart';

class SelectWeekDays extends StatefulWidget {
  /// [onSelect] callBack to handle the Selected days
  final Function onSelect;

  final  List<DayInWeek> days;

  /// [backgroundColor] - property to change the color of the container.
  final Color? backgroundColor;

  /// [fontWeight] - property to change the weight of selected text
  final FontWeight? fontWeight;

  /// [fontSize] - property to change the size of selected text
  final  double? fontSize;

  /// [daysFillColor] -  property to change the button color of days when the button is pressed.
  final Color? daysFillColor;

  /// [daysBorderColor] - property to change the bordercolor of the rounded buttons.
  final Color? daysBorderColor;

  /// [selectedDayTextColor] - property to change the color of text when the day is selected.
  final Color? selectedDayTextColor;

  /// [unSelectedDayTextColor] - property to change the text color when the day is not selected.
  final Color? unSelectedDayTextColor;

  /// [border] Boolean to handle the day button border by default the border will be true.
  final bool border;

  /// [boxDecoration] to handle the decoration of the container.
  final BoxDecoration? boxDecoration;

  /// [padding] property  to handle the padding between the container and buttons by default it is 8.0
  final double padding;

  /// `SelectWeekDays` takes a list of days of type `DayInWeek`.
  /// `onSelect` property will return `list` of days that are selected.
const  SelectWeekDays({
    required this.onSelect,
    this.backgroundColor,
    this.fontWeight,
    this.fontSize,
    this.daysFillColor,
    this.daysBorderColor,
    this.selectedDayTextColor,
    this.unSelectedDayTextColor,
    this.border = true,
    this.boxDecoration,
    this.padding = 8.0,
    required this.days,
    Key? key,
  }) : super(key: key);

  @override
  _SelectWeekDaysState createState() => _SelectWeekDaysState(days);
}

class _SelectWeekDaysState extends State<SelectWeekDays> {
  _SelectWeekDaysState(List<DayInWeek> days) : _daysInWeek = days;

  // list to insert the selected days.
  List<String> selectedDays = [];

  // list of days in a week.
  List<DayInWeek> _daysInWeek = [];

  @override
  void initState() {
    for (var element in _daysInWeek) {
      if (element.isSelected) {
        selectedDays.add(element.dayName);
      }
    }
    super.initState();
  }

  void _getSelectedWeekDays(bool isSelected, String day) {
    if (isSelected == true) {
      if (!selectedDays.contains(day)) {
        selectedDays.add(day);
      }
    } else if (isSelected == false) {
      if (selectedDays.contains(day)) {
        selectedDays.remove(day);
      }
    }
    // [onSelect] is the callback which passes the Selected days as list.
    widget.onSelect(selectedDays.toList());
  }

// getter to handle background color of container.
  Color? get _handleBackgroundColor {
    if (widget.backgroundColor == null) {
      return Theme.of(context).dialogBackgroundColor;
      // return Theme.of(context).accentColor;
    } else {
      return widget.backgroundColor;
    }
  }

// getter to handle fill color of buttons.
  Color? get _handleDaysFillColor {
    if (widget.daysFillColor == null) {
      return Colors.white;
    } else {
      return widget.daysFillColor;
    }
  }

//getter to handle border color of days[buttons].
  Color? get _handleBorderColorOfDays {
    if (widget.daysBorderColor == null) {
      return Colors.white;
    } else {
      return widget.daysBorderColor;
    }
  }

// Handler to change the text color when the button is pressed and not pressed.
  Color? _handleTextColor(bool onSelect) {
    if (onSelect == true) {
      if (widget.selectedDayTextColor == null) {
        return Colors.black;
      } else {
        return widget.selectedDayTextColor;
      }
    } else if (onSelect == false) {
      if (widget.unSelectedDayTextColor == null) {
        return Colors.white;
      } else {
        return widget.unSelectedDayTextColor;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: widget.boxDecoration ?? BoxDecoration(
        color: _handleBackgroundColor,
        borderRadius: BorderRadius.circular(0),
      ),
      child: Padding(
        padding: EdgeInsets.all(widget.padding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _daysInWeek.map(
                (day) {
              return Expanded(
                child: RawMaterialButton(
                    fillColor:
                    day.isSelected == true ? _handleDaysFillColor : null,
                    shape: CircleBorder(
                      side: widget.border
                          ? BorderSide(
                        color: _handleBorderColorOfDays!,
                        width: 1.0,
                      )
                          : BorderSide.none,
                    ),
                    onPressed: () {
                      setState(() {
                        day.toggleIsSelected();
                      });
                      _getSelectedWeekDays(day.isSelected, day.dayName);
                    },
                    child:Container(
                      width: 50,
                      height: 50,
                      margin:  const EdgeInsets.all(3.0),
                      child:  Center(
                        child: Text(
                          day.dayName,
                          style: TextStyle(
                            fontSize: widget.fontSize,
                            fontWeight: widget.fontWeight,
                            color: _handleTextColor(day.isSelected),
                          ),
                        ),
                      ),
                    )
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
