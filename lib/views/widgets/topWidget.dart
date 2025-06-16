import 'package:fast/utlis/constant.dart';
import 'package:fast/views/widgets/linerIndicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class SelectLanWidget extends StatefulWidget {
  const SelectLanWidget({Key? key}) : super(key: key);

  @override
  State<SelectLanWidget> createState() => _SelectLanWidgetState();
}

class _SelectLanWidgetState extends State<SelectLanWidget> {
  String _dropDownLanguageValue = "US";

  @override
  void initState() {
    super.initState();

  }
  IndicatorController indicatorController = IndicatorController();
  String accent = "بريطاني";
  String language = "عربي";
  String level = "متوسط";
  int countWords = 0;

  String userName = "علي";

  double sliderValue = 25.0;
  bool  showWords = false;
  int wordsCount = 35;
  @override
  Widget build(BuildContext context) {

    double height = MediaQuery
        .of(context)
        .size
        .height;
    double width = MediaQuery
        .of(context)
        .size
        .width;
    return  Container(
      height: 120,
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: DarkBlue,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              height: 100,
              child: DropdownButton(
                items: [
                  DropdownMenuItem(value: "UK",
                    child: SvgPicture.asset("assets/icons/UK.svg"),),
                  DropdownMenuItem(value: "US",
                    child: SvgPicture.asset("assets/icons/US.svg"),),
                  DropdownMenuItem(value: "US-UK",
                    child: SvgPicture.asset("assets/icons/US-UK.svg"),),
                ],
                value: _dropDownLanguageValue,
                onChanged: dropDownLanguageCallBack,

              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //icon button back
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: GestureDetector(
                            onTap: _starIconButtonCallback,
                            child: SvgPicture.asset(
                                "assets/icons/star.svg")
                        ),
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(
                          '$wordsCount كلمة',
                          style: TextStyle(
                              color: Orange, fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              LinerIndicator(
                showPer: true,

                width: width - 100,
                controller: indicatorController,

                colorBorder: Colors.transparent,
              ),

            ],
          ),
        ],
      ),


    );
  }
  void dropDownLanguageCallBack(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _dropDownLanguageValue = selectedValue;
      });
    }
  }

  void onPressedButtonFAST() {
    setState(() {});
  }
  //
  // void onTapedBottomsNavigationBarItem(int value) {
  //
  //     // _currentIndexBottomNavigationBarItem = value;
  //     indicatorController.animatedTo(value * 20.0);
  //
  // }

  void _starIconButtonCallback() {

  }
}
