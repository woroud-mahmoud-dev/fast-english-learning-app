
import 'package:fast/model/profile.dart';
import 'package:fast/model/user.dart';

abstract class ProfileStates {}

class ProfileInitialState extends ProfileStates {}

class ProfileLoadingState extends ProfileStates {}
class UserNotFound extends ProfileStates {}

class ProfileSuccessState extends ProfileStates {
  late final Profile profile;
  ProfileSuccessState({required this.profile});

}
class ProfileNSuccessState extends ProfileStates {

}

class ProfileErrorState extends ProfileStates {
  final String error;

  ProfileErrorState({required this.error});
}
