import 'package:fast/local_storage/sql_database.dart';
import 'package:fast/model/story.dart';

import 'package:fast/utlis/constant.dart';
import 'package:fast/views/widgets/show_toast.dart';
import 'package:flutter/foundation.dart';

class StoryOperations {
  SqlDb sqlDb = SqlDb();

  insertStory({
    required int id,
    required String arText,
    required String enText,
    required String title,
    required String image,
    required String object_id,
  }) async {
    try {
      int response = await sqlDb.insert(SqlDb.storiesTable, {
        'id': id,
        'ar_text': arText,
        'en_text': enText,
        'title': title,
        'image': image,
        'object_id': object_id,
      });
      if (kDebugMode) {
        print(' insert story down! $response');
      }
      showToast(text: 'تم الإضافة بنجاح', color: LightOrange);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      showToast(text: 'لقد قمت بإضافة هذه القصة مسبقاً', color: LightOrange);
    }
  }

  Future<List<Story>> getStories() async {
    List<Map<String ,dynamic>> response = await sqlDb.read(SqlDb.storiesTable);
    List<Story> res = response.map<Story>((e){
      return Story.fromMap(e);
    }).toList();
    return res;
  }
}
