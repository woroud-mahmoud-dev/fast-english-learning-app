
part of 'register_cubit.dart';

abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadinglState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  late final User user;
  RegisterSuccessState({required this.user});

}


class RegisterErrorState extends RegisterStates {
  final String error;

  RegisterErrorState({required this.error});
}
//facebook states
class RegisterFaceBookSuccessState extends RegisterStates {


}class RegisterFaceBookErrorState extends RegisterStates {
  final String error;
  RegisterFaceBookErrorState({required this.error});
}