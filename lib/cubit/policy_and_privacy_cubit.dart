import 'package:fast/model/policy.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../network/local/chach_helper.dart';
import '../network/remote/dio_helper.dart';

part 'policy_and_privacy_state.dart';

class PolicyAndPrivacyCubit extends Cubit<PolicyAndPrivacyState> {
  PolicyAndPrivacyCubit() : super(PolicyAndPrivacyInitial());
  static PolicyAndPrivacyCubit get(context) => BlocProvider.of(context);

  List<Policy> papList= [
    Policy(body: 'body', id: 1, title: 'title'),
  ];
  String pap ="policy and privacy\n this is app policy and privacy";


  void getPolicyAndPrivacy(){

  emit(PolicyAndPrivacyLoading());
  DioHelper.getData(url: 'policy', query: {}).then((value) {
    print(value);
    if(value == null || value.statusCode != 200) {
      emit(PolicyAndPrivacyError());
      return ;
    }
    papList = value.data.map<Policy>((e) => Policy.fromJson(e) ).toList();

    emit(PolicyAndPrivacyDown());
  }).catchError((error){
    print(error.toString());
    emit(PolicyAndPrivacyError());
  });

}





}
