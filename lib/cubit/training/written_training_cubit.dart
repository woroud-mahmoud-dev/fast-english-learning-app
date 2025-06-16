
import 'dart:math';

enum TtsState { playing, stopped, paused, continued }

class Character{
  final String c ;
  final int id;
  static String allC ='ABCDEFJHIGKLMNOPKRSTUVWXYZ';
  static String allS ='abcdefjhigklmnopkrstuvwxyz';
  static String all ='abcdefjhigklmnopkrstuvwxyzABCDEFJHIGKLMNOPKRSTUVWXYZ';

  bool isSelected = false;

  static List<Character> randomSort(List<Character> list){
    list = (list..shuffle());
    /*for(int i =0 ;i<list.length ; i++){
      print(list[i].toJson());
    }*/
    return list;
  }

  static List<Character> addRandomLetters({int number = 4 , required String correct }){
    List<Character> res =[];
    for(int i =0 ;i< correct.length + number ; i++){
    final random = Random();
      var element = all[random.nextInt(all.length)];
      if(i<correct.length){
        res.add(Character(c: correct[i], id: i));
      }else{
        res.add(Character(c: element, id: i));
      }
    }
    return randomSort(res);
  }
  Map<String ,dynamic> toJson(){
    return{
      'char': c,
      'id': id,
      'isSelected' : isSelected,
    };
  }


  Character({required this.c,required this.id});
}
