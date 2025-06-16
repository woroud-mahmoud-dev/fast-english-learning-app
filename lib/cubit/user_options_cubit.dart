import 'package:fast/api/notification_api_plus.dart';
import 'package:fast/cubit/user_opotios_states.dart';
import 'package:fast/local_storage/subject_operation.dart';
import 'package:fast/model/my_services.dart';
import 'package:fast/model/object.dart';
import 'package:fast/network/local/chach_helper.dart';
import 'package:fast/network/remote/dio_helper.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class UserOptionsCubit extends Cubit<SelectObjectStates> {
  UserOptionsCubit() : super(SelectObjectInitialState());

  static UserOptionsCubit get(context) => BlocProvider.of(context);
  int? groupvalue;
  int? word_groupvalue;
  int? ton_groupvalue;
  List<String> selectedDaysList = [];
  DateTime dateTime = DateTime.now();

  bool isLoading = true;
  List<SubjectModel> subjectsList = [];
  MyService myService = MyService();

  SubjectOperations operations = SubjectOperations();

  insertSelectedSubjects() {
    emit(SaveSelectedObjectsLoadingState());

    for (int i = 0; i < myService.getSelectedSubjects.length; i++) {
      print(myService.getSelectedSubjects[i].ar_title);
      operations.insertSelectedSubject(
        id: myService.getSelectedSubjects[i].id,
        en_title: myService.getSelectedSubjects[i].en_title,
        ar_title: myService.getSelectedSubjects[i].ar_title,
        image: myService.getSelectedSubjects[i].image.toString(),
      );
    }
    //////////22-1-2023
    //الوقت المستغرق لعملية الحفظ اقل من ثانية لهيك حطيت تاخير زمني ليظهر عندي اللودينغ مدة 3 ثواني

    Future.delayed(const Duration(seconds: 3)).then((value) {
      emit(SaveSelectedObjectsSuccess());
    });
  }

  insertAll() {
    for (int i = 0; i < subjectsList.length; i++) {
      operations.insertSubject(
        id: subjectsList[i].id,
        en_title: subjectsList[i].en_title,
        ar_title: subjectsList[i].ar_title,
        image: subjectsList[i].image.toString(),
      );
    }
  }

  void getSelectedObjectsId(SubjectModel subject) {
    emit(SelectObjectLoadedState());
    if (subject.isSelected == true) {
      myService.getSelectedSubjects.add(subject);
    } else{
      myService.removeSubject(subject);
      if (myService.getSelectedSubjects.isNotEmpty) {
        emit(SelectObjectSuccessState());
      }
    }
  }

  void getObjects() {
    myService.removeAllSubject();
    emit(SelectObjectLoadinglState());
    DioHelper.postData(url: 'object', data: {
      'token': CacheHelper.getData(key: 'api_token'),
    }).then((value) {
      subjectsList = value!.data.map<SubjectModel>((item) => SubjectModel.fromJson(item),).toList();

      isLoading = false;
      emit(SelectObjectLoadedState());
    }).catchError((error) {
      if (kDebugMode) {
        print('has error SelectObjectErrorState $error');
      }
      emit(SelectObjectErrorState(error: error.toString()));
    });
  }

  bool isSelect = false;

  void selectWordNumber(int index) {
    word_groupvalue = index;
    CacheHelper.saveData(key: 'wordNumber',  value: index);

    emit(SelectWordNumberSuccessState());
  }

  void saveAcentINSherd(int id) {
    if (id == 2) {
      ttsLan = 'en-UK';

      CacheHelper.saveData(key: 'lanCode', value: ttsLan);
    } else if (id == 3) {
      ttsLan = 'en-US';
      CacheHelper.saveData(key: 'lanCode', value: ttsLan);
    } else {
      CacheHelper.saveData(key: 'lanCode', value: 'US-UK');
    }
  }

  void selectTon(int index) {
    ton_groupvalue = index;

    emit(SelectTonSuccessState());
  }

  void selectDays(List<String> selectedDays) {
    selectedDaysList = selectedDays;
    emit(SelecDaySuccessState());
  }
  void saveTime() {
    CacheHelper.saveData(key: 'daysOfNotification', value: selectedDaysList);
    CacheHelper.saveData(key: 'timeOfNotification', value: dateTime.toIso8601String());
    scheduleDailyTenAMNotification();
  }

  selectTime(DateTime time) {
    dateTime = time;
    emit(SelectTimeSuccessState());

  }
}
