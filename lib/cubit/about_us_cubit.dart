import 'package:fast/model/about_us.dart';
import 'package:fast/network/remote/dio_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'about_us_state.dart';

class AboutUsCubit extends Cubit<AboutUsState> {

  AboutUsCubit() : super(AboutUsInitial());
  static AboutUsCubit get(context) => BlocProvider.of(context);
  late PackageInfo packageInfo;
  late String appName;
  late String packageName;
  late String version;
  late String buildNumber;
  late AboutUs aboutUs ;


  void info()async{
    try{
      packageInfo = await PackageInfo.fromPlatform();
      appName = packageInfo.appName;
      packageName = packageInfo.packageName;
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
      emit(AboutUsDown());
    }catch(error){
      if (kDebugMode) {
        print(error);
      }
      emit(AboutUsError());
    }
  }

  void getData(){
    emit(AboutUsLoading());

    DioHelper.getData(url: 'about-as', query: {},).then((value) {
      if (kDebugMode) {
        print('data is :${value?.data}');
      }
      if(value?.data is List){
        aboutUs = AboutUs.fromJson(value?.data[0]);
      }else{
        aboutUs = AboutUs.fromJson(value?.data);
      }
      info();
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(AboutUsError());
    });
  }


}
