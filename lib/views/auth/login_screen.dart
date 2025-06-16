import 'package:fast/cubit/auth/login_cubite.dart';
import 'package:fast/cubit/auth/login_states.dart';
import 'package:fast/utlis/constant.dart';
import 'package:fast/views/auth/register_screen.dart';
import 'package:fast/views/widgets/functions.dart';
import 'package:fast/views/widgets/myWidgets.dart';
import 'package:fast/views/widgets/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';

import '../onBoarding/exam.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;


    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 1,
        centerTitle: true,
        backgroundColor:  Orange,
        shadowColor: Colors.transparent,
        leading:Container() ,
      ),
      body: BlocProvider(
        create: (BuildContext context) => LoginCubit(),
        child: BlocConsumer<LoginCubit, LoginStates>(
          listener: (context, state) {
            print(state);
            if (state is LoginFaceBookSuccessState ||
                state is LoginSuccessState) {
              showToast(text: ' تم تسجيل الدخول بنجاح', color: Colors.green);

              Navigator.pushReplacement(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade,
                      child: const Exam(indexSpalsh: 0),
                      duration: const Duration(microseconds: 800),
                  ),
              );
            }

            if (state is LoginErrorState) {
              showToast(text: 'اسم المستخدم او كلمة المرور خطأ', color: Colors.red);
            }
            if (state is LoginFaceBookErrorState) {
              showToast(text: ' حدث خطأ أثناء تسجيل الدخول', color: Colors.red);
            }
          },
          builder: (context, state) {
            return Container(
              width: width,
              height: height,
              color: Orange,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding:const EdgeInsets.symmetric(horizontal: 32.0),
                      width: width,
                      constraints:const BoxConstraints(
                        maxHeight: 200,
                        minHeight: 200,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              'FAST',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 61,
                                fontFamily: 'NunitoBold',
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            SizedBox(height: 64,),
                            Text(
                              'تطبيق فاست بوابتك لتعلم اللغة الإنجليزية ',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white, fontSize: 24, height: 0.9),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.elliptical(50, 20),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32.0),
                            child: Form(
                              key: LoginCubit.get(context).formKey,
                              child:Column(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  const SizedBox(height:32 ,),
                                  Text(
                                    'تسجيل دخول',
                                    style: TextStyle(
                                        color: DarkBlue,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  formItem(
                                    icon: Icons.email_outlined,
                                    obscureText: false,
                                    controller:LoginCubit.get(context).emailController,
                                    labelText: "البريد الإلكتروني ",
                                    type: TextInputType.emailAddress,
                                    validate: (value) {
                                      if (value!.isEmpty) {
                                        return 'Email is Required ';
                                      }
                                      if (!RegExp(
                                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                          .hasMatch(value)) {
                                        return 'Please enter a valid Email';
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  formItem(
                                    obscureText: true,
                                    icon: Icons.lock_outline_rounded,
                                    controller: LoginCubit.get(context).passwordController,
                                    labelText: "كلمة المرور ",
                                    type: TextInputType.text,
                                    validate: (value) {
                                      if (value!.isEmpty) {
                                        return 'Password is Required ';
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  InkWell(
                                    child: customButton("تسجيل", (state is! LoginLoadinglState)? DarkBlue : Colors.grey.withOpacity(.5)),
                                    onTap: () {
                                      if (LoginCubit.get(context).formKey.currentState!.validate() && state is! LoginLoadinglState) {
                                        LoginCubit.get(context).UserLogin(
                                            email: LoginCubit.get(context).emailController.text.trim(),
                                            password: LoginCubit.get(context).passwordController.text.trim());
                                      }
                                    },
                                  ),

                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Spacer(),
                                      Text(
                                        'أو سجل دخول عبر',
                                        style: TextStyle(
                                            color: LightOrange,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          LoginCubit.get(context)
                                              .signInFB();
                                        },
                                        child: SvgPicture.asset(
                                            'assets/icons/facebook_icon.svg'),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      SvgPicture.asset(
                                          'assets/icons/twiter_icon.svg'),
                                      const Spacer(),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'ليس لديك حساب؟ ',
                                        style: TextStyle(
                                            color: DarkBlue,
                                            fontSize: 14,
                                            fontWeight:
                                            FontWeight.normal),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          goNext(context, const Register());
                                        },
                                        child: Text(
                                          'أنشئ حساب الآن',
                                          style: TextStyle(
                                              color: DarkBlue,
                                              fontSize: 14,
                                              fontWeight:
                                              FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height:16 ,),

                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
