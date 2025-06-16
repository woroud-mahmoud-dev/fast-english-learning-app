import 'package:fast/local_storage/story_operation.dart';
import 'package:fast/local_storage/subject_operation.dart';
import 'package:fast/model/object.dart';
import 'package:fast/model/stories_by_subject.dart';
import 'package:fast/model/story.dart';
import 'package:fast/network/local/chach_helper.dart';
import 'package:fast/network/remote/dio_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'all_stories_tab_state.dart';


class AllStoriesTabCubit extends Cubit<AllStoriesTabState> {
  AllStoriesTabCubit() : super(AllStoriesTabInitial());
  static AllStoriesTabCubit get(context) => BlocProvider.of(context);

  List<StoriesBySubject> storiesBySubject = [];

  List<SubjectModel> subject =[];

  void selectStorySubject(int index){
    storiesBySubject[index].showStories = !storiesBySubject[index].showStories;
    emit(AllStoriesDown());
  }

  void getAllStories() async{
    storiesBySubject = [];
    emit(AllStoriesLoading());
    SubjectOperations subjectOperations = SubjectOperations();

    subject = await subjectOperations.getSelectedSubjects();

    for(int i =0 ;i < subject.length ; i++ ){
      print(subject[i].id);
     List<Story> stories =  await DioHelper.postData(url: 'story', data: {
        'token': CacheHelper.getData(key: 'api_token'),
        'object_id': subject[i].id,
      }).then((value) {
        if( value!.data is Map<String , dynamic>  && value.data['title'] == 'Not Found'){
          emit(UserNotFound());
        }

        return value.data.map<Story>((item) => Story.fromMap(item)).toList();

      }).catchError((error){
        if (kDebugMode) {
          print(error);
        }

        emit(AllStoriesError());
      });

      StoryOperations storyOperation = StoryOperations();

      int countAllStory = (await storyOperation.getStories()).length;

     storiesBySubject.add(StoriesBySubject(stories: stories, subject: subject[i] , countAll:countAllStory ));
    }

    emit(AllStoriesDown());

  }

}
