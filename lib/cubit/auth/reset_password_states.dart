

abstract class ResetPasswordStates {}

class ResetPasswordInitialState extends ResetPasswordStates {}

class ResetPasswordLoadinglState extends ResetPasswordStates {}

class ResetPasswordSuccessState extends ResetPasswordStates {


}


class ResetPasswordErrorState extends ResetPasswordStates {
  final String error;

  ResetPasswordErrorState({required this.error});
}
