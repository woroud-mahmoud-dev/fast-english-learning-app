import 'package:fast/cubit/user_options_cubit.dart';
import 'package:fast/cubit/user_opotios_states.dart';
import 'package:fast/model/day_in_week.dart';
import 'package:fast/utlis/constant.dart';
import 'package:fast/views/user_options/loading_screen.dart';
import 'package:fast/views/widgets/functions.dart';
import 'package:fast/views/widgets/myWidgets.dart';
import 'package:fast/views/widgets/select_day.dart';
import 'package:fast/views/widgets/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class SelectTime extends StatelessWidget {
  final bool? isNotFirstTime;
  const SelectTime({Key? key, this.isNotFirstTime}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => UserOptionsCubit(),
      child: BlocConsumer<UserOptionsCubit, SelectObjectStates>(
        listener: (context, state) {
          debugPrint(state.toString());
        },
        builder: (context, state) {
          List<DayInWeek> days = [
            DayInWeek(
              "الجمعة",
            ),
            DayInWeek(
              "الخميس",
            ),
            DayInWeek(
              "الأربعاء",
            ),
            DayInWeek(
              "الثلاثاء",
            ),
            DayInWeek(
              "الأثنين",
            ),
            DayInWeek("الأحد"),
            DayInWeek("السبت"),
          ];
          return WillPopScope(
            onWillPop: () async {
              showToast(
                  text: 'عذرا يجب عليك إكمال هذه الخطوة قبل الخروج من التطبيق',
                  color: Colors.red);
              return false;
            },
            child: Scaffold(
              body: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/images/backgroung1.png',
                        ),
                        fit: BoxFit.cover)),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.1,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Image.asset(
                                'assets/images/indicator5.png',
                                fit: BoxFit.contain,
                                //   width: MediaQuery.of(context).size.width * 0.9,
                                height: 50,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 35, left: 10),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: SvgPicture.asset(
                                    'assets/icons/arrow_back_icon.svg',
                                    fit: BoxFit.contain,
                                    width: MediaQuery.of(context).size.width *
                                        0.08),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.02,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          'أخبرنا متى تريد البدء بالتعلم ونحن سوف نرسل \n لك اشعارا لتنبيهك',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Grey),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 20),
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          elevation: 4.0,
                          onPressed: () {
                            picker.DatePicker.showTime12hPicker(context,
                                theme: const picker.DatePickerTheme(
                                  containerHeight: 210.0,
                                ),
                                showTitleActions: true, onChanged: (time) {
                              UserOptionsCubit.get(context).selectTime(time);
                            }, onConfirm: (time) {
                              UserOptionsCubit.get(context).selectTime(time);
                            },
                                currentTime: DateTime.now(),
                                locale: picker.LocaleType.en);
                          },
                          color: Colors.white,
                          child: Container(
                            alignment: Alignment.center,
                            height: 40.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  children: [
                                    Icon(
                                      Icons.arrow_drop_up,
                                      size: 18.0,
                                      color: Grey,
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down,
                                      size: 18.0,
                                      color: Grey,
                                    ),
                                  ],
                                ),
                                Text(
                                  " ${UserOptionsCubit.get(context).dateTime.hour}" +
                                      " : " +
                                      " ${UserOptionsCubit.get(context).dateTime.minute}",
                                  style: TextStyle(
                                      color: Grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SelectWeekDays(
                        fontSize: 10,
                        fontWeight: FontWeight.normal,
                        days: days,
                        border: true,
                        daysBorderColor: Orange,
                        selectedDayTextColor: Colors.white,
                        daysFillColor: DarkBlue,
                        unSelectedDayTextColor: Colors.black,
                        backgroundColor: Colors.white,
                        boxDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        onSelect: (values) {
                          print(values);
                          UserOptionsCubit.get(context).selectDays(values);
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.3,
                      ),
                      Text(
                        'تستطيع التعديل  في وقت لاحق',
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Grey),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.1,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: GestureDetector(
                          onTap: () {
                            if (UserOptionsCubit.get(context)
                                .selectedDaysList
                                .isNotEmpty) {
                              UserOptionsCubit.get(context).saveTime();
                              goNext(context, const Loading());
                            } else {
                              showToast(
                                  text: 'يجب تحديد أيام التعلم',
                                  color: Colors.amber);
                            }
                          },
                          child: customButton2('استمرار', Orange),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
