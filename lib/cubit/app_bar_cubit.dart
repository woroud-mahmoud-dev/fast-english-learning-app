import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fast/cubit/app_bar_state.dart';
import '../local_storage/word_operation.dart';


class AppBarCubit extends Cubit<AppBarState> {
  AppBarCubit() : super(AppBarInitial());
  static AppBarCubit get (context) => BlocProvider.of(context);
  Map<String , int>? homeData ;


  void update(){
    WordOperations operations = WordOperations();

    operations.countCorrectWord().then((value) {
      homeData = value;
      emit(AppBarUpdate());
    });
  }


}
