import 'package:fast/local_storage/sql_database.dart';
import 'package:fast/model/object.dart';
import 'package:fast/utlis/constant.dart';
import 'package:fast/views/widgets/show_toast.dart';

class SubjectOperations {

  SqlDb sqlDb = SqlDb();

  insertSubject({
    required int id,
    required String ar_title,
    required String en_title,
    required String image,
  }) async {
    try{
      int response = await sqlDb.insert(SqlDb.objectsTable, {'id': id, 'ar_title': ar_title, 'en_title': en_title, 'image': image});
      print(response);
      return response;
    }catch(e){
      print(e.toString());
      // showToast(text: 'تم الاضافة مسبقاً', color: LightOrange);
    }
  }

    insertSelectedSubject({
    required int id,
    required String ar_title,
    required String en_title,
    required String image,
  }) async {
    try{
      int response = await sqlDb.delete(table:SqlDb.selectedObjectsTable ,myWhere:'id != -1');
      response = await sqlDb.insert(SqlDb.selectedObjectsTable, {'id': id, 'ar_title': ar_title, 'en_title': en_title, 'image': image});
      print(response);
      return response;
    }
    catch(e)
    {
      print(e.toString());
      // showToast(text: 'تم الاضافة مسبقاً', color: LightOrange);
    }

  }


  Future<List<Map>> getSubjects() async {
    List<Map<dynamic, dynamic>> response = await sqlDb.read("objectsTable");
    return response;
  }

  //////////22-1-2023
  // تابع جلب المواضيع المختارة
  Future<List<SubjectModel>> getSelectedSubjects() async
  {
    List<SubjectModel> response = (await sqlDb.read(SqlDb.selectedObjectsTable)).map<SubjectModel>((e) => SubjectModel.fromJson(e)).toList();
    return response;
  }

}
