
import 'package:fast/cubit/auth/login_states.dart';
import 'package:fast/model/user.dart';
import 'package:fast/network/local/chach_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fast/network/remote/dio_helper.dart';


class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);
  late User user ;
  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void UserLogin({
    required String email,
    required String password,
  }){
    emit(LoginLoadinglState());
    DioHelper.postData(url: 'login', data: {
      'email':email,
      'password':password,
    }).then((value)     {

      print(value!.data);

      user =User.fromJson(value.data) ;

      CacheHelper.saveData(key: 'name', value: user.firstName);
      CacheHelper.saveData(key: 'email', value: user.email);
      CacheHelper.saveData(key: 'api_token', value: user.apiToken);
      CacheHelper.saveData(key: 'end_point', value: 0);

      print(value.statusCode);

      emit(LoginSuccessState(user: user));
    }).catchError((error){
      print(error.toString());
      emit(LoginErrorState(error: ''));
    });
  }
  Future signInFB() async {
    Map<String, dynamic>? _userData;
    final LoginResult result = await FacebookAuth.instance
        .login(); // by default we request the email and the public profile
    emit(LoginLoadinglState());

    if (result.status == LoginStatus.success) {
      // you are logged
      final AccessToken accessToken = result.accessToken!;
      print(accessToken.token);
      print(']]]]]]]]]]]]]]]]]]]]]]]');
      CacheHelper.saveData(key: 'fb-token', value: accessToken.token.toString());

      final userData = await FacebookAuth.instance.getUserData();
      _userData = userData;
      _userData.forEach((key, value) {
        print(value);
        CacheHelper.saveData(key: key, value: value);

        emit(LoginFaceBookSuccessState());

        print('name is ${userData['name']}');
      }

      );
      // showToast(
      //     text:'تم تسجيل الدخول '+ CacheHelper.getData(key: 'name') +
      //         CacheHelper.getData(key: 'email'),
      //     color: Colors.green);
    } else {
      LoginFaceBookErrorState(error: result.message.toString());
      print(result.status);
      print(result.message);
      print(result.accessToken);
    }
  }
  // twitter
  //import 'package:twitter_login/twitter_login.dart';
  //
  // Future<UserCredential> signInWithTwitter() async {
  //   // Create a TwitterLogin instance
  //   final twitterLogin = new TwitterLogin(
  //       apiKey: '<your consumer key>',
  //       apiSecretKey:' <your consumer secret>',
  //       redirectURI: '<your_scheme>://'
  //   );
  //
  //   // Trigger the sign-in flow
  //   final authResult = await twitterLogin.login();
  //
  //   // Create a credential from the access token
  //   final twitterAuthCredential = TwitterAuthProvider.credential(
  //     accessToken: authResult.authToken!,
  //     secret: authResult.authTokenSecret!,
  //   );
  //
  //   // Once signed in, return the UserCredential
  //   return await FirebaseAuth.instance.signInWithCredential(twitterAuthCredential);
  // }
}
