// ignore_for_file: unnecessary_this

class DayInWeek {
  String dayName;
  bool isSelected = false;

  DayInWeek(this.dayName, {this.isSelected = false});

  void toggleIsSelected() {
    this.isSelected = !this.isSelected;
  }
}
