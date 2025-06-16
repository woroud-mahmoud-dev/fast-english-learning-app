abstract class LearnNewWordsStates {}

class LearnNewWordsInitialState extends LearnNewWordsStates {}

class GetAllWordsLoadingState extends LearnNewWordsStates {}

class GetAllWordsLoadedState extends LearnNewWordsStates {}

class GetAllWordsErrorState extends LearnNewWordsStates {
  final String error;

  GetAllWordsErrorState(this.error);
}


class LearnFinish extends LearnNewWordsStates {}


class AddToWalletSuccess extends LearnNewWordsStates {}

class RasiedProgress extends LearnNewWordsStates {}

class AddToWalletError extends LearnNewWordsStates {}

class SelectLeftCorrect extends LearnNewWordsStates {}

class SelectLeftIncorrect extends LearnNewWordsStates {}

class SelectRightCorrect extends LearnNewWordsStates {}

class SelectRightIncorrect extends LearnNewWordsStates {}

class GetNextWord extends LearnNewWordsStates {}



class AddToDuplicateWordTableSucces extends LearnNewWordsStates {}

class addToDuplicateWordTableError extends LearnNewWordsStates {
  final String error;

  addToDuplicateWordTableError(this.error);
}
