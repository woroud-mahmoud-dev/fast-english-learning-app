part of 'training_cubit.dart';

abstract class TrainingStates {}

class TrainInitialState extends TrainingStates {}
class TrainingLoading extends TrainingStates {}
class TrainingDown extends TrainingStates {}
class TrainingError extends TrainingStates {}
class GetAllWordsBySubjectLoadingState extends TrainingStates{}
class GetAllWordsBySubjectDownState extends TrainingStates{}
class GetAllSubjectsDownState extends TrainingStates{}
class GetAllSubjectsLoadingState extends TrainingStates{}
class GetAllCountingLoadingState extends TrainingStates{}
class GetSubjectsErrorState extends TrainingStates{}
class UserNotFound extends TrainingStates{}

class GetAllWordsBySubjectErrorState extends TrainingStates{
  final String error;
  GetAllWordsBySubjectErrorState(this.error);
}
class GetAlStoriesLoadingState extends TrainingStates{}
class GetAlStoriesLoadedState extends TrainingStates{}

class GetAlStoriesErrorState extends TrainingStates{
  final String error;
  GetAlStoriesErrorState(this.error);
}