import 'package:fast/cubit/auth/reset_password_states.dart';
import 'package:fast/model/user.dart';
import 'package:fast/network/local/chach_helper.dart';
import 'package:fast/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordStates> {
  ResetPasswordCubit() : super(ResetPasswordInitialState());

  static ResetPasswordCubit get(context) => BlocProvider.of(context);
  late User user;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController = TextEditingController();
  var formKey = GlobalKey<FormState>();


  void UserResetPassword({
    required String email,
    required String password,
    required String password_confirmation,
  }) {
    emit(ResetPasswordLoadinglState());
    DioHelper.postData(url: 'reset_password', data: {
      'email': email,
      'password': password,
      'password_confirmation': password_confirmation,
      'token': CacheHelper.getData(key: 'api_token').toString(),
    }).then((value) {
      print(value?.statusCode);

      emit(ResetPasswordSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ResetPasswordErrorState(error: error.toString()));
    });
  }
}
