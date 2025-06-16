

abstract class SelectObjectStates {}

class SelectObjectInitialState extends SelectObjectStates {}

class SelectObjectLoadinglState extends SelectObjectStates {}

class SelectObjectLoadedState extends SelectObjectStates {



}
class LearnNewWordsInitialState extends SelectObjectStates {}
class GetAllWordsLoadingState extends SelectObjectStates{}
class GetAllWordsLoadedState extends SelectObjectStates{}
class GetAllWordsErrorState extends SelectObjectStates{
  final String error;

  GetAllWordsErrorState(this.error);
}
class SelectObjectSuccessState extends SelectObjectStates {


}
class SelectWordNumberSuccessState extends SelectObjectStates {


}
class SelectTonSuccessState extends SelectObjectStates {


}
class SelectDateSuccessState extends SelectObjectStates{}
class SelectTimeSuccessState extends SelectDateSuccessState {


}
class SelecDaySuccessState extends SelectDateSuccessState {


}
class SelectObjectErrorState extends SelectObjectStates {
  final String error;

  SelectObjectErrorState({required this.error});
}
class SaveSelectedObjectsLoadingState extends SelectObjectStates{}
class SaveSelectedObjectsSuccess extends SelectObjectStates{}
class SaveSelectedObjectsError extends SelectObjectStates{
  final String error;

  SaveSelectedObjectsError({required this.error});
}