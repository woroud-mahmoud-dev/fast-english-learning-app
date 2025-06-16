import 'package:fast/local_storage/sql_database.dart';
import 'package:fast/local_storage/subject_operation.dart';
import 'package:fast/model/object.dart';
import 'package:fast/utlis/constant.dart';
import 'package:fast/views/widgets/show_toast.dart';
import 'package:flutter/foundation.dart';

import '../model/word.dart';

class WordOperations {
  late WordOperations subjectOperations;

  SqlDb sqlDb = SqlDb();

  insertToALLWords({
    required Word word,
  }) async {
    int response = await sqlDb.insert('AllWords', {
      'id': word.id,
      'word': word.word,
      'word1': word.word1,
      'image': word.image,
      'correct_word': word.correct_word,
      'object_id': word.object_id,
      'level_id': word.level_id
    });
    print(response);
    return response;
  }

  Future<int> insertToCorrect({
    required Word word,
    int? date,
  }) async {
    int response;
    try {
      response = await sqlDb.insert('CorrectTable', {
        'word_id': word.id,
        'word': word.word,
        'word1': word.word1,
        'image': word.image,
        'correct_word': word.correct_word,
        'object_id': word.object_id,
        'level_id': word.level_id,
        'type_id': word.type,
        'date': date ?? DateTime.now().toString()
      });
    } catch (e) {
      response = -1;
    }
    return response;
  }

// يعيد الكلمات مع عدد مرات التكرار
  Future<Map<String, int>> countCorrectWord({int? objectId}) async {
    var response = await sqlDb.count(
      '''
    SELECT word,word_id , date ,COUNT(*) as count
    FROM CorrectTable
    ${objectId != null ? 'WHERE  object_id == $objectId' : ''}
    GROUP BY word_id
    ORDER BY type_id
   ''',
    );
    int countCorrectWord = 0, dalyCorrectWords = 0;
    for (int i = 0; i < response.length; i++) {
      if (response[i]["count"] == 3) {
        countCorrectWord++;
      }
      if (DateTime.now().day == DateTime.parse(response[i]["date"]).day &&
          response[i]["count"] == 3) {
        dalyCorrectWords++;
      }
    }

    return {
      "countCorrectWord": countCorrectWord,
      "dalyCorrectWords": dalyCorrectWords
    };
  }

  Future<int> countCorrectWordOfObjects({
    required int objectId,
    int? typeTraining,
  }) async {
    var response;

    if (typeTraining == null) {
      response = await sqlDb.count('''
    SELECT correct_word ,  object_id ,COUNT(*) as count
    FROM ${SqlDb.correctTable}
    WHERE  object_id == $objectId
    GROUP BY correct_word
   ''');
      print('word: $response');
    } else {
      response = await sqlDb.count(
        '''
    SELECT word, date ,type_id ,COUNT(*) as count
    FROM ${SqlDb.correctTable}
    WHERE  type_id == $typeTraining AND object_id == $objectId
    ORDER BY correct_word
   ''',
      );
    }

    print("countCorrectWordOfObjects");
    print(response);

    if (response.isEmpty) {
      return -1;
    }

    return response[0]["count"];
  }

  Future<int> countDuplicatedWordOfObjects({required int objectId}) async {
    var response = await sqlDb.count(
      '''
    SELECT word ,type_id ,object_id,COUNT(*) as count
    FROM ${SqlDb.duplicatedTable}
    WHERE  object_id == $objectId
    ORDER BY word_id
   ''',
    );

    return response[0]["count"];
  }

  insertToDublicated({
    required Word word,
    DateTime? date,
  }) async {
    try {
      int response = await sqlDb.insert('DuplicatedTable', {
        'word_id': word.id,
        'word': word.word,
        'word1': word.word1,
        'image': word.image,
        'correct_word': word.correct_word,
        'object_id': word.object_id,
        'level_id': word.level_id,
        'type_id': word.type,
        'date': date ?? DateTime.now().toString()
      });
      showToast(text: 'تم الإضافة بنجاح', color: LightOrange);
      return response;
    } catch (e) {
      showToast(text: 'لقد قمت بإضافة هذه الكلمة مسبقاً', color: LightOrange);
      print(e.toString());
    }
  }

  insertToWrong({
    required Word word,
    DateTime? date,
  }) async {
    try {
      int response = await sqlDb.insert('WrongTable', {
        'word_id': word.id,
        'word': word.word,
        'word1': word.word1,
        'image': word.image,
        'correct_word': word.correct_word,
        'object_id': word.object_id,
        'level_id': word.level_id,
        'type_id': word.type,
        'date': date ?? DateTime.now().toString()
      });
      return response;
    } catch (e) {
      print(e.toString());
    }
  }

  //////////////////read
  Future<List<Map<String, dynamic>>> getAllWords() async {
    List<Map<String, dynamic>> response = await sqlDb.read("AllWords");
    return response;
  }

  Future<List<Map<String, dynamic>>> getCorrectWords() async {
    List<Map<String, dynamic>> response = await sqlDb.count(
      '''
    SELECT *
    FROM ${SqlDb.correctTable}
    GROUP BY word_id
    ORDER BY type_id
   ''',
    );

    if (kDebugMode) {
      print(response);
    }

    return response;
  }

  Future<List<Map<String, dynamic>>> getDuplicatedWords() async {
    List<Map<String, dynamic>> response = await sqlDb.count(
      '''
    SELECT *
    FROM ${SqlDb.duplicatedTable}
    GROUP BY word
    ORDER BY type_id
   ''',
    );

    if (kDebugMode) {
      print(response);
    }

    return response;
  }

  Future<List<Map<String, dynamic>>> getWrongWords() async {
    List<Map<String, dynamic>> response = await sqlDb.count(
      '''
    SELECT *
    FROM ${SqlDb.wrongTable}
    GROUP BY word
    ORDER BY type_id
   ''',
    );

    if (kDebugMode) {
      print('this is wrong words: $response');
    }

    return response;
  }

  Future<List<Word>> getCorrectWordsBySubjectId(int subId) async {
    List<Word> response = (await sqlDb.readData(
            'SELECT * FROM ${SqlDb.correctTable} WHERE ${SqlDb.correctTable}.object_id =$subId'))
        .map<Word>((e) => Word.fromMap(e))
        .toList();

    return response;
  }

  Future<List<Map<String, dynamic>>> getDuplicatedWordsBySubjectId(
      int subId) async {
    List<Map<String, dynamic>> response = await sqlDb.readData(
        ' SELECT * FROM ${SqlDb.duplicatedTable} WHERE ${SqlDb.duplicatedTable}.object_id =$subId');
    return response;
  }

  void printMap(List<Map<String, dynamic>> v) {
    for (int i = 0; i < v.length; i++) {
      print(
          'index : $i ,Subject ${v[i]['subject'].ar_title} ,count word : ${v[i]['countCorrect']} ');
      for (int j = 0; j < v[i]['words'].length; j++) {
        print(
            'index : $j ,word ${v[i]['words'][j].correct_word}, date :${v[i]['words'][j].date}  ');
      }
    }
  }

  Future<List<Map<String, dynamic>>> getLatestWords() async {
    SubjectOperations subjectOperations = SubjectOperations();
    List<SubjectModel> subject = await subjectOperations.getSelectedSubjects();
    List<Map<String, dynamic>> response = [];
    for (int i = 0; i < subject.length; i++) {
      response.add({
        'subject': subject[i],
        'words': await getCorrectWordsBySubjectId(subject[i].id)
      });
      response.last['words']
          .sort((e1, e2) => ((e1.date!.isAfter(e2.date!)) ? 0 : 1));

      response.sort((e1, e2) {
        if (e1['words'] == null || e1['words'].isEmpty) {
          return 1;
        }

        if (e2['words'].isEmpty) {
          return 0;
        }

        return ((e1['words'].first.date!.isAfter(e2['words'].first.date!))
            ? 0
            : 1);
      });
    }
    for (int i = 0; i < subject.length; i++) {
      response[i]['countCorrect'] = (await countCorrectWord(
        objectId: response[i]['subject'].id,
      ))['countCorrectWord'];
      response[i]['numberOfWords'] = (await countCorrectWord(
        objectId: response[i]['subject'].id,
      ))['countCorrectWord'];
    }

    // printMap(response);
    return response;
  }

  deleteFromDuplicated(int id) async {
    print(id);

    try {
      int response = await sqlDb.deleteData(
          'DELETE FROM ${SqlDb.duplicatedTable} WHERE ${SqlDb.duplicatedTable}.id =$id');

      showToast(text: 'تم الحذف بنجاح', color: LightOrange);
      return response;
    } catch (e) {
      showToast(text: 'حدث خطأ أثناء الحذف', color: LightOrange);
    }
  }
}
