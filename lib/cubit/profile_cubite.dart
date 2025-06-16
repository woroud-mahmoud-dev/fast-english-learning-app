import 'package:fast/cubit/profile_states.dart';
import 'package:fast/model/profile.dart';
import 'package:fast/network/local/chach_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fast/network/remote/dio_helper.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInitialState());

  static ProfileCubit get(context) => BlocProvider.of(context);
  late Profile profile ;

  void profileShow(){
    emit(ProfileLoadingState());
    DioHelper.postData(url: 'profile?token=${CacheHelper.getData(key: 'api_token')}', data: {}).then((value){
      if(value == null){
        emit(ProfileErrorState(error: 'profile return null!!!!!!'));
        return ;
      }

      if(value.data['title'] == 'Not Found' ){
        emit(UserNotFound());
        return;
      }

      //print(value.data);
      profile = Profile.fromJson(value.data);

      emit(ProfileSuccessState(profile: profile));
    }).catchError((error){
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ProfileErrorState(error: error.toString()));
    });
  }

}
