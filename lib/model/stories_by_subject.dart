import 'package:fast/model/object.dart';
import 'package:fast/model/story.dart';

class StoriesBySubject{
  final List<Story> stories;
  final SubjectModel subject;
  final int countAll;
  bool showStories = false;
  double per = 0;

  StoriesBySubject( {required this.stories,required this.subject ,required this.countAll, }){
   if(stories.isEmpty || countAll == 0){
     return ;
   }else{
    per = (stories.length*100/countAll);
   }
  }
}
