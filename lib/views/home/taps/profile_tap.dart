import 'package:fast/cubit/app_bar_cubit.dart';
import 'package:fast/cubit/profile_cubite.dart';
import 'package:fast/utlis/constant.dart';
import 'package:fast/views/app_info/app_info.dart';
import 'package:fast/views/app_info/policy_and_privacy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import '../../../cubit/profile_states.dart';
import '../../../network/local/chach_helper.dart';
import '../../auth/login_screen.dart';
import '../../onBoarding/exam.dart';
import '../../user_options/select_object_screen.dart';
import '../../user_options/select_time_screen.dart';
import '../../user_options/select_word_count_screen.dart';
import '../../widgets/profile_buttom.dart';
import '../../widgets/show_toast.dart';

class ProfileTap extends StatefulWidget {
  final AppBarCubit appBarCubit;
  const ProfileTap({Key? key, required this.appBarCubit}) : super(key: key);

  @override
  State<ProfileTap> createState() => _ProfileTapState();
}

class _ProfileTapState extends State<ProfileTap> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (BuildContext context) => ProfileCubit()..profileShow(),
      child: BlocConsumer<ProfileCubit, ProfileStates>(
        listener: (context, state) {
          if (state is ProfileErrorState) {
            showToast(
                text: 'اسم المستخدم او كلمة المرور خطأ', color: Colors.red);
          }
          if (state is UserNotFound) {
            CacheHelper.clearData();
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (_) {
              return const Login();
            }), (route) => false);
          }
        },
        builder: (context, state) {
          if (state is ProfileLoadingState) {
            return Center(
              child: CircularProgressIndicator(
                color: Orange,
              ),
            );
          }

          String accent = "بريطاني";
          String language = "عربي";
          String level = ProfileCubit.get(context).profile.level.toString();

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 56,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "حسابي",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: DarkBlue),
                        ),
                      ),
                      //icon button back
                      /*GestureDetector(
                          onTap: _backIconButtonCallback,
                          child: SvgPicture.asset("assets/icons/back.svg")
                      ),*/
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      children: [
                        ProfileButton(
                            width: width,
                            text: "المستوى",
                            chooseItem: level,
                            onTaped: () {},
                            iconPath: "assets/icons/tree.svg"),
                        //ProfileButton(width: width,text: "تغيير اللغة" ,chooseItem: language , onTaped: (){}),
                        //ProfileButton(width: width,text: "اللكنة" ,chooseItem: accent , onTaped: (){} , iconPath: "assets/icons/UK.svg"),
                        ProfileButton(
                            width: width,
                            text: "تعديل الاهتمامات",
                            onTaped: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: const SelectObject(
                                        isNotFirstTime: true,
                                      ),
                                      duration:
                                          const Duration(microseconds: 800)));
                            }),
                        ProfileButton(
                            width: width,
                            text: "تعديل أوقات التعلم",
                            onTaped: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: const SelectTime(
                                        isNotFirstTime: true,
                                      ),
                                      duration:
                                          const Duration(microseconds: 800)));
                            }),
                        ProfileButton(
                            width: width,
                            text: "تعديل الهدف اليومي",
                            onTaped: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: const SelectWordCount(
                                        isNotFirstTime: true,
                                      ),
                                      duration:
                                          const Duration(microseconds: 800)));
                            }),
                        ProfileButton(
                            width: width,
                            text: "اجراء إختبار تحديد المستوى",
                            onTaped: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: const Exam(
                                        indexSpalsh: 0,
                                        isNotFirstTime: true,
                                      ),
                                      duration:
                                          const Duration(microseconds: 800)));
                            }),
                        ProfileButton(
                            width: width,
                            text: "الشروط والاحكام",
                            onTaped: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: const PolicyAndPrivacy(),
                                      duration:
                                          const Duration(microseconds: 800)));
                            }),
                        ProfileButton(
                            width: width,
                            text: "تواصل معنا",
                            onTaped: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: const AppInfo(),
                                      duration:
                                          const Duration(microseconds: 800)));
                            }),
                        ProfileButton(
                            width: width,
                            text: "تسجل الخروج",
                            onTaped: () {
                              CacheHelper.clearData().then((value) {
                                Navigator.pushAndRemoveUntil(context,
                                    MaterialPageRoute(builder: (_) {
                                  return const Login();
                                }), (route) => false);
                              });
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
