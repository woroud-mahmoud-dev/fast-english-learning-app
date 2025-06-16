part of 'wallet_cubit.dart';

@immutable
abstract class WalletState {}

class WalletInitial extends WalletState {}
class ChangeScreenState extends WalletState {}
class ChangeTypeWordsState extends WalletState {}
class GetHardWordsLoadingState extends WalletState {}
class GetHardWordsSuccessState extends WalletState {}
class GetHardWordsErrorState extends WalletState {}
class GetPerfectWordsLoadingState extends WalletState {}
class GetPerfectWordsSuccessState extends WalletState {}
class GetPerfectWordsErrorState extends WalletState {}
class GetMistakeWordsLoadingState extends WalletState {}
class GetMistakeWordsSuccessState extends WalletState {}
class GetMistakeWordsErrorState extends WalletState {}
class GetStoriesLoadingState extends WalletState {}

class GetStoriesSuccessState extends WalletState {}

class GetStoriesErrorState extends WalletState {}
class DeleteSuccess extends WalletState{}

//spaeck states
class SpeackState extends WalletState {}

class StopSpaeckState extends WalletState {}

class StopState extends WalletState {}

class Pause extends WalletState {}
class AddToDuplicateWordTableSucces extends WalletState {


}
class AddToDuplicateWordTableError extends WalletState {


}