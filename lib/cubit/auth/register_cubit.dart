
import 'package:fast/model/user.dart';
import 'package:fast/network/local/chach_helper.dart';
import 'package:fast/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

part 'register_states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);
late User user;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  void UserRegister({
    required String firstName,
    required String email,
    required String password,
  }){
    emit(RegisterLoadinglState());
    DioHelper.postData(url: 'register', data: {
      'email':email,
      'password':password,
      'firstName':firstName,
    }).then((value)     {

      if(value == null){
        emit(RegisterErrorState(error: 'return null from register!!!'));
        return;
      }

      user =User.fromJson(value.data) ;
      CacheHelper.saveData(key: 'name', value: user.firstName);
      CacheHelper.saveData(key: 'email', value: user.email);
      CacheHelper.saveData(key: 'api_token', value: user.apiToken);
      CacheHelper.saveData(key: 'end_point', value: 0);

      emit(RegisterSuccessState(user: user));
    }).catchError((error){
      print(error.toString());
      emit(RegisterErrorState(error: error.toString()));
    });
  }


  Future signInFB() async {
    Map<String, dynamic>? _userData;
    final LoginResult result = await FacebookAuth.instance
        .login(); // by default we request the email and the public profile
    emit(RegisterLoadinglState());

    if (result.status == LoginStatus.success) {
      // you are logged
      final AccessToken accessToken = result.accessToken!;
      CacheHelper.saveData(key: 'fb-token', value: accessToken.token.toString());

      final userData = await FacebookAuth.instance.getUserData();
      _userData = userData;
      _userData.forEach((key, value) {
        CacheHelper.saveData(key: key, value: value);
        CacheHelper.saveData(key: 'end_point', value: 0);
        print('name is ${userData['name']}');
      }

      );
      emit(RegisterFaceBookSuccessState());

    } else {
      RegisterFaceBookErrorState(error: result.message.toString());
      print(result.status);
      print(result.message);
      print(result.accessToken);
    }
  }
}
