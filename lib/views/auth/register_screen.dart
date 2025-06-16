import 'package:fast/cubit/auth/register_cubit.dart';
import 'package:fast/utlis/constant.dart';
import 'package:fast/views/user_options/select_object_screen.dart';
import 'package:fast/views/widgets/myWidgets.dart';
import 'package:fast/views/widgets/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 1,
        centerTitle: true,
        backgroundColor:Orange,
        shadowColor: Colors.transparent,
        leading:Container() ,
      ),
      body: BlocProvider(
        create: (BuildContext context) => RegisterCubit(),
        child: BlocConsumer<RegisterCubit, RegisterStates>(
          listener: (context, state) {
            if (state is RegisterSuccessState) {
              showToast(text: 'تم انشاء الحساب بنجاح', color: Colors.green);
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (_) {return const SelectObject();}), (route) => false);
            }

            if(state is RegisterFaceBookSuccessState) {
              showToast(text: ' تم تسجيل الدخول عبر فيسبوك بنجاح', color: Colors.green);
            }

            if (state is RegisterErrorState || state is RegisterFaceBookErrorState) {
              showToast(text: ' حدث خطأ أثناء إنشاء الحساب', color: Colors.red);
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
                                key: RegisterCubit.get(context).formKey,
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 16,),
                                    Text(
                                      'إنشاء حساب جديد',
                                      style: TextStyle(
                                          color: DarkBlue,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    formItem(
                                      icon: Icons.person,
                                      controller: RegisterCubit.get(context).nameController,
                                      labelText: "الاسم ",
                                      type: TextInputType.name,
                                      obscureText: false,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return 'Name is Required ';
                                        }else{
                                          return null;
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    formItem(
                                        icon: Icons.email_outlined,
                                        obscureText: false,
                                        controller: RegisterCubit.get(context).emailController,
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
                                          return null;
                                        }),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    formItem(
                                        obscureText: true,
                                        icon: Icons.lock_outline_rounded,
                                        controller: RegisterCubit.get(context).passwordController,
                                        labelText: "كلمة المرور ",
                                        type: TextInputType.text,
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return 'Password is Required ';
                                          }
                                          return null;
                                        }),
                                    const SizedBox(height: 32,),
                                    InkWell(
                                      onTap: () {
                                        if (RegisterCubit.get(context).formKey.currentState!.validate() && state is! RegisterLoadinglState) {
                                          RegisterCubit.get(context).UserRegister(
                                            firstName: RegisterCubit.get(context).nameController.text.trim(),
                                            email: RegisterCubit.get(context).emailController.text.trim(),
                                            password: RegisterCubit.get(context).passwordController.text.trim(),
                                          );
                                        }
                                      },
                                      child: customButton("أنشئ حساب جديد",(state is! RegisterLoadinglState)? DarkBlue : Colors.grey.withOpacity(.5)),
                                    ),
                                    const   SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'أو أنشئ حساب عبر',
                                          style: TextStyle(
                                              color: LightOrange,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const   SizedBox(
                                          width: 10,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            RegisterCubit.get(context).signInFB();
                                          },
                                          child: SvgPicture.asset(
                                              'assets/icons/facebook_icon.svg'),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            RegisterCubit.get(context)
                                                .signInFB();
                                          },
                                          child: SvgPicture.asset(
                                              'assets/icons/twiter_icon.svg'),
                                        ),

                                      ],
                                    ),
                                    const    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'لديك حساب مسبقا؟ ',
                                          style: TextStyle(
                                              color: DarkBlue,
                                              fontSize: 14,
                                              fontWeight:
                                              FontWeight.normal),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            'سجل دخول الآن',
                                            style: TextStyle(
                                                color: DarkBlue,
                                                fontSize: 14,
                                                fontWeight:
                                                FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
