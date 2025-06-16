import 'package:fast/cubit/user_options_cubit.dart';
import 'package:fast/cubit/user_opotios_states.dart';
import 'package:fast/model/object.dart';
import 'package:fast/utlis/constant.dart';
import 'package:fast/views/user_options/select_word_count_screen.dart';
import 'package:fast/views/widgets/functions.dart';
import 'package:fast/views/widgets/myWidgets.dart';
import 'package:fast/views/widgets/select_subject.dart';
import 'package:fast/views/widgets/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'loading_screen.dart';

class SelectObject extends StatelessWidget {
  final bool? isNotFirstTime;
  const SelectObject({Key? key, this.isNotFirstTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => UserOptionsCubit()..getObjects(),
      child: BlocConsumer<UserOptionsCubit, SelectObjectStates>(
        listener: (context, state) {},
        builder: (context, state) {
          List<SubjectModel>? list =  UserOptionsCubit.get(context).subjectsList;

          return WillPopScope(
            onWillPop: () async {
              showToast(text: 'عذرا يجب عليك إكمال هذه الخطوة قبل الخروج من التطبيق', color: Colors.red);
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.1,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Image.asset(
                              'assets/images/indicator.png',
                              fit: BoxFit.contain,
                              width: MediaQuery.of(context).size.width * 0.72,
                              height: 50,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 35,
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: SvgPicture.asset(
                                  'assets/icons/arrow_back_icon.svg',
                                  fit: BoxFit.contain,
                                  width:
                                      MediaQuery.of(context).size.width * 0.08),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        ' الان هيا نختار أكثر المواضيع التي تهمك',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Grey),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      UserOptionsCubit.get(context).isLoading
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height * 0.63,
                              child: const Center(
                                child: Text('loading ...'),
                              ),
                            )
                          : SizedBox(
                              height: MediaQuery.of(context).size.height * 0.63,
                              child: GridView.count(
                                physics: const BouncingScrollPhysics(),
                                childAspectRatio: (1 / 1),
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 5,
                                crossAxisCount: 3,
                                children: List.generate(list.length, (index) {
                                  return GestureDetector(
                                    onTap: () {
                                      list[index].toggleIsSelected();
                                      UserOptionsCubit.get(context).getSelectedObjectsId(list[index]);
                                    },
                                    child: SelectSubjects(
                                      onSelect: (values) {},
                                      selectedSubjectTextColor: Colors.white,
                                      subjectsFillColor: DarkBlue,
                                      unSelectedsubjectTextColor: Grey,
                                      backgroundColor: Colors.white,
                                      isSlected: list[index].isSelected,
                                      name: list[index].ar_title.toString(),
                                      value: index,
                                      Subjects: list,
                                    ),
                                  );
                                }),
                              ),
                            ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        ' تستطيع إضافة مواضيع أخرى في وقت لاحق',
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Grey),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (UserOptionsCubit.get(context).myService.getSelectedSubjects.isNotEmpty) {
                            if(isNotFirstTime!=null && isNotFirstTime!) {
                              goNext(context, const Loading());
                            }else{
                              goNext(context, const SelectWordCount());
                            }
                          } else {
                          showToast(
                            text: 'يجب اختيار أكثر المواضيع التي تهمك',
                            color: Colors.amber,
                          );
                          }

                        },
                        child: customButton2('استمرار', Orange),
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
