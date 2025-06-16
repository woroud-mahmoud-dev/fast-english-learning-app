
import 'package:fast/model/user.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadinglState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  late final User user;
  LoginSuccessState({required this.user});

}
class LoginNSuccessState extends LoginStates {

}

class LoginErrorState extends LoginStates {
  final String error;

  LoginErrorState({required this.error});
}
//facebook states
class LoginFaceBookSuccessState extends LoginStates {


}class LoginFaceBookErrorState extends LoginStates {

  final String error;

  LoginFaceBookErrorState({required this.error});

}