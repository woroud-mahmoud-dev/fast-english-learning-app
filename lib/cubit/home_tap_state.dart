part of 'home_tap_cubit.dart';

@immutable
abstract class HomeTapState {}

class HomeTapInitial extends HomeTapState {}
class GetSubjectsLoadingState extends HomeTapState{}
class GetSubjectsSuccessState extends HomeTapState{}
class GetSubjectsErrorState extends HomeTapState{}
class GetSubjectsEmptyState extends HomeTapState{}
class UserNotFound extends HomeTapState{}