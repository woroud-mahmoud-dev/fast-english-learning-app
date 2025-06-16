
part of 'duplicated_training_cubit.dart';

abstract class DuplicatedTrainingStates {}

class DuplicatedTrainingState extends DuplicatedTrainingStates {}
class GetDuplicatedWordsLoadingState extends DuplicatedTrainingStates{}
class GetDuplicatedWordsDownState extends DuplicatedTrainingStates{}
class GetDuplicatedWordsEmptyState extends DuplicatedTrainingStates{}
class GetDuplicatedWordsErrorState extends DuplicatedTrainingStates{
  final String error;
  GetDuplicatedWordsErrorState(this.error);
}

class TrainingRaisedProgress extends DuplicatedTrainingStates {}
class TrainingSelectLeftCorrect extends DuplicatedTrainingStates {}
class TrainingSelectLeftIncorrect extends DuplicatedTrainingStates {}
class TrainingSelectRightCorrect extends DuplicatedTrainingStates {}
class TrainingSelectRightIncorrect extends DuplicatedTrainingStates {}
class TrainingGetNextWord extends DuplicatedTrainingStates {}
class TrainingFinish extends DuplicatedTrainingStates {}
class ChangAnswerColorAndPosition extends DuplicatedTrainingStates {}

class AddToDuplicateWordTableSuccess extends DuplicatedTrainingStates {}
class AddToDuplicateWordTableError extends DuplicatedTrainingStates {}



class AddToAnswerState extends DuplicatedTrainingStates{}
class RemoveFromAnswerState extends DuplicatedTrainingStates{}
class WriteWordCorrect extends DuplicatedTrainingStates{}
class WriteWordUnCorrect extends DuplicatedTrainingStates{}

class VoiceIncorrect extends DuplicatedTrainingStates {}
class VoiceCorrect extends DuplicatedTrainingStates {}

class SpeackState extends DuplicatedTrainingStates {}
class StopSpaeckState extends DuplicatedTrainingStates {}

class StartRecordState extends DuplicatedTrainingStates {}
class StopRecordState extends DuplicatedTrainingStates {}
class ListeningWordsState extends DuplicatedTrainingStates {}
