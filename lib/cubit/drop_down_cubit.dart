
import 'package:fast/cubit/drop_down_states.dart';
import 'package:fast/network/local/chach_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DropDownCubit extends Cubit<DropDownStates>{
  DropDownCubit() : super(InitialState());

  static DropDownCubit get(context) => BlocProvider.of(context);
  String dropDownLanguageValue = CacheHelper.getData(key: 'lanCode');
  void dropDownLanguageCallBack(String? selectedValue) {
    if (selectedValue is String) {
      dropDownLanguageValue = selectedValue;
      CacheHelper.replaceData(key: 'lanCode', value:dropDownLanguageValue );
      emit(ChangState());
    }
  }

}