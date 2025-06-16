import 'package:bloc/bloc.dart';
import 'package:fast/local_storage/subject_operation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../local_storage/word_operation.dart';
import '../model/object.dart';

part 'home_tap_state.dart';

class HomeTapCubit extends Cubit<HomeTapState> {
  HomeTapCubit() : super(HomeTapInitial());
  static HomeTapCubit get(context) => BlocProvider.of(context);

  Map<String , int>? homeData ;

  SubjectOperations operations = SubjectOperations();
  WordOperations operationsW = WordOperations();
  bool isLoading = false;
  List<SubjectModel> subjectsList = [];

  Future<List<SubjectModel>> getSelectedSubjects() async {
    emit(GetSubjectsLoadingState());


    //to do error change getSelectedSubjects =>getSubjects
    List<SubjectModel> response = await operations.getSelectedSubjects();
    subjectsList = [];
    subjectsList.addAll(response);

    if (response.isNotEmpty ) {
      await operationsW.countCorrectWord().then((value){
        homeData = value;
        emit(GetSubjectsSuccessState());
      });

    } else {
      emit(GetSubjectsEmptyState());
    }

    return response;
  }
}
