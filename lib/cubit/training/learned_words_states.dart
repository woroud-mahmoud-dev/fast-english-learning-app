abstract class LearnedWordsStates {}

class LearnedWordsInitialState extends LearnedWordsStates {}

class GetAllLearnedWordsState extends LearnedWordsStates {}

class LearnedWordsLoadingState extends LearnedWordsStates {}

class LearnedWordsLoadedSuccessState extends LearnedWordsStates {}

/////////////////////////////////////////////////////////////
class GetSubjectWordsState extends LearnedWordsStates {}

class LoadingWordsState extends LearnedWordsStates {}

class LoadedWordsState extends LearnedWordsStates {}
class SendObjectNameState extends LearnedWordsStates {
  final String ObjectName;
  SendObjectNameState({required this.ObjectName});

}
class GoViewScreenState extends LearnedWordsStates{
  final int id;

  GoViewScreenState(this.id);
}

///////////////////////////////////////////////////////////////
class LearnedWordsErrorState extends LearnedWordsStates {
  final String error;

  LearnedWordsErrorState({required this.error});
}

//spaeck states
class SpeackState extends LearnedWordsStates {}

class StopSpaeckState extends LearnedWordsStates {}

class StopState extends LearnedWordsStates {}

class Pause extends LearnedWordsStates {}
class addToDuplicateWordTableSucces extends LearnedWordsStates {


}
class AddToDuplicateWordTableError extends LearnedWordsStates {


}