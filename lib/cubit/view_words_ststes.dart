abstract class ViewWordsStates {}

class ViewWordInitialState extends ViewWordsStates {}

class GetAllLearnedWordsState extends ViewWordsStates {}

class LearnedWordsLoadingState extends ViewWordsStates {}

class LearnedWordsLoadedSuccessState extends ViewWordsStates {}

/////////////////////////////////////////////////////////////



///////////////////////////////////////////////////////////////
class LearnedWordsErrorState extends ViewWordsStates {
  final String error;

  LearnedWordsErrorState({required this.error});
}


class addToDuplicateWordTableSucces extends ViewWordsStates {


}
class addToDuplicateWordTableError extends ViewWordsStates {


}