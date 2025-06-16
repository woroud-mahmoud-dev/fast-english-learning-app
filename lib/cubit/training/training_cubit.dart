import 'package:fast/local_storage/word_operation.dart';
import 'package:fast/model/story.dart';
import 'package:fast/network/local/chach_helper.dart';
import 'package:fast/network/remote/dio_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../local_storage/sql_database.dart';
import '../../local_storage/subject_operation.dart';
import '../../model/my_services.dart';
import '../../model/word.dart';
import '../../views/widgets/linerIndicator.dart';

part 'training_states.dart';

class TrainingCubit extends Cubit<TrainingStates> {
  final Function updateBar;
  TrainingCubit({required this.updateBar}) : super(TrainInitialState());
  static TrainingCubit get(context) => BlocProvider.of(context);

  SqlDb sqlDb = SqlDb();
  WordOperations wordOperations = WordOperations();
  SubjectOperations operations = SubjectOperations();
  IndicatorController indicatorController = IndicatorController();

  List<Word>? allWords;
  List<Story>? allStories;
  List<Map<String, dynamic>> subjectsAndWordCount = [];
  Map<String, dynamic> trainingData = {};

  int countOfChoiceTrainingWords = 0;
  int countOfWrittenTrainingWords = 0;
  int countOfVoiceTrainingWords = 0;
  int countOfDuplicatedTrainingWords = 0;

  bool isLoading = true;
  bool isError = false;

  Future<void> update() async {
    isError = false;
    updateBar();
    emit(TrainingLoading());

    trainingData = {
      'allWords': await getAllWords(),
      'countOfChoiceTrainingWords': await wordOperations
          .countCorrectWordOfObjects(objectId: subId, typeTraining: 1),
      'countOfWrittenTrainingWords': await wordOperations
          .countCorrectWordOfObjects(objectId: subId, typeTraining: 2),
      'countOfVoiceTrainingWords': await wordOperations
          .countCorrectWordOfObjects(objectId: subId, typeTraining: 3),
      'countOfDuplicatedTrainingWords':
          await wordOperations.countDuplicatedWordOfObjects(objectId: subId),
      'subjectsAndWordCount': await getSubjectsAndCountOfWords(),
      'allStories': await getAllStories(),
    };

    allWords = trainingData['allWords'];
    countOfChoiceTrainingWords = trainingData['countOfChoiceTrainingWords'];
    countOfWrittenTrainingWords = trainingData['countOfWrittenTrainingWords'];
    countOfVoiceTrainingWords = trainingData['countOfVoiceTrainingWords'];
    countOfDuplicatedTrainingWords =
        trainingData['countOfDuplicatedTrainingWords'];
    subjectsAndWordCount = trainingData['subjectsAndWordCount'];

    MyService myService = MyService();

    myService.setSubjectsAndCountWords = subjectsAndWordCount;
    allStories = trainingData['allStories'];

    emit(TrainingDown());
  }

  Future<List<Map<String, dynamic>>> getSubjectsAndCountOfWords() async {
    return await wordOperations.getLatestWords().then((value) async {
      for (int i = 0; i < value.length; i++) {
        value[i]['numberOfWords'] =
            await getCountOfWords(value[i]['subject'].id);
      }
      return value;
    }).catchError((error) {
      if (kDebugMode) {
        print(error);
      }
      isError = true;
      emit(GetSubjectsErrorState());
    });
  }

  Future<List<Word>> getAllWords() async {
    return await DioHelper.postData(url: 'word-object', data: {
      'token': CacheHelper.getData(key: 'api_token'),
      'id[]': subId,
    }).then((value) {
      if (value!.data is! List && value.data['title'] == 'Not Found') {
        emit(UserNotFound());
        return;
      }
      return value.data
          .map<Word>(
            (item) => Word.fromMap(item),
          )
          .toList();
    }).catchError((error) {
      if (kDebugMode) {
        print('error in GetAllWordsBySubjectLoading $error');
      }

      isError = true;
      emit(GetAllWordsBySubjectErrorState(error.toString()));
    });
  }

  Future<int> getCountOfWords(int subjectId) async {
    return await DioHelper.postData(url: 'word-object', data: {
      'token': CacheHelper.getData(key: 'api_token'),
      'id[]': subjectId,
    }).then((value) {
      return value?.data.length;
    }).catchError((error) {
      if (kDebugMode) {
        print('error in GetAllWordsBySubjectLoading $error');
      }
      isError = true;
      return 0;
    }) as int;
  }

  //// Get STORIES FUNCTION
  Future<List<Story>> getAllStories() async {
    return await DioHelper.postData(url: 'story', data: {
      'token': CacheHelper.getData(key: 'api_token'),
      // 'object_id': CacheHelper.getData(key: 'storyId'),
    }).then((value) {
      return value?.data.map<Story>((item) => Story.fromMap(item)).toList();
    }).catchError((error) {
      if (kDebugMode) {
        print(error);
      }
      isError = true;
      emit(GetAlStoriesErrorState(error.toString()));
    }) as List<Story>;
  }
}
