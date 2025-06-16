import 'package:fast/cubit/auth/reset_password_cubite.dart';
import 'package:fast/cubit/auth/reset_password_states.dart';
import 'package:fast/utlis/constant.dart';

import 'package:fast/views/widgets/myWidgets.dart';
import 'package:fast/views/widgets/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;


    return BlocProvider(
      create: (BuildContext context) => ResetPasswordCubit(),
      child: BlocConsumer<ResetPasswordCubit, ResetPasswordStates>(
        listener: (context, state) {

          if (state is ResetPasswordSuccessState) {
            showToast(text: ' تم تغيير كلمة المرور بنجاح', color: Colors.green);
          }
          if (state is ResetPasswordErrorState) {
            showToast(text: ' حدث خطأ أثناء تغيير كلمة المرور \n حاول لاحقاً', color: Colors.red);
          }

        },
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                toolbarHeight: 1,
                centerTitle: true,
                backgroundColor:  Orange,
                shadowColor: Colors.transparent,
                leading:Container() ,
              ),
              body: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
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
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Padding(
                                padding: const EdgeInsets.all(25.0),
                                child: Form(
                                  key: ResetPasswordCubit.get(context).formKey,
                                  child: state is! ResetPasswordLoadinglState
                                      ? Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
//SizedBox(
//  height: 10,
//),
                                      Text(
                                        'تغيير كلمة المرور ',
                                        style: TextStyle(
                                            color: DarkBlue,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),

                                      const SizedBox(
                                        height: 10,
                                      ),

                                      const SizedBox(
                                        height: 4,
                                      ),
                                      formItem(
                                          icon: Icons.email_outlined,
                                          obscureText: false,
                                          controller: ResetPasswordCubit.get(context).emailController,
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
                                          controller: ResetPasswordCubit.get(context).passwordController,
                                          labelText: "كلمة المرور الجديدة",
                                          type: TextInputType.text,
                                          validate: (value) {
                                            if (value!.isEmpty) {
                                              return 'password is Required ';
                                            }
                                            return null;
                                          }),
                                      formItem(
                                          obscureText: true,
                                          icon: Icons.password_outlined,
                                          controller: ResetPasswordCubit.get(context).passwordConfirmationController,
                                          labelText: " تأكيد كلمة المرور ",
                                          type: TextInputType.text,
                                          validate: (value) {
                                            if (value!.isEmpty) {
                                              return 'confirm password is Required ';
                                            }
                                            if (ResetPasswordCubit.get(context).passwordController.text != ResetPasswordCubit.get(context).passwordConfirmationController.text) {
                                              return 'password and confirm password do not match ';
                                            }
                                            return null;

                                          }),
                                      const Spacer(),

                                      InkWell(
                                        onTap: () {
                                          if (ResetPasswordCubit.get(context).formKey.currentState!.validate() && state is! ResetPasswordLoadinglState) {
                                            ResetPasswordCubit.get(context)
                                                .UserResetPassword(
                                                email: ResetPasswordCubit.get(context).emailController
                                                    .text
                                                    .trim(),
                                                password:
                                                ResetPasswordCubit.get(context).passwordController
                                                    .text
                                                    .trim(),
                                                password_confirmation:
                                                ResetPasswordCubit.get(context).passwordConfirmationController
                                                    .text
                                                    .trim());
                                          }
                                        },
                                        child: customButton(
                                            "تغيير", (state is! ResetPasswordLoadinglState)? DarkBlue : Colors.grey.withOpacity(.5)),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  )
                                      : Center(
                                      child: Column(
                                        children: [
                                          const Text(' ... Loading'),
                                          CircularProgressIndicator(
                                            color: Orange,
                                            strokeWidth: 1,
                                          )
                                        ],
                                      )),
                                ),
                              ),
                            )),
                      )
                    ],
                  ),
                ),
            ),
          );
        },
      ),
    );
  }
}
