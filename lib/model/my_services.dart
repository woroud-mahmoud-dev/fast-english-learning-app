import 'dart:math';

import 'package:fast/model/object.dart';
import 'package:fast/model/stories_by_subject.dart';
import 'package:fast/model/story.dart';
import 'package:fast/model/word.dart';
import 'package:flutter_tts/flutter_tts.dart';

late String enWord;
late String arWord;
late String subName;
late int index;
late int subjectId;
//late List<dynamic> myList;
// for subjects
// late List<SubjectModel> SubjectsList = [];//تم الحذف مع استخداماتها ب home tap
late int subId;
late String ttsLan;

class MyService {
  static Word? selectedWord;
  static String? subName;
  static String? correctWord;
  static List<Map<String , dynamic>> subjectsAndCountWords = [];
  static List<SubjectModel> selectedSubjects =[];
  static late Map<String , dynamic> selectedSubjectAndCountOfWords ;
  static List<Story> storiesList =[];
  static late Story selectedStory;
  static late StoriesBySubject selectedStoriesBySubject;


  Story get getSelectedStory {
    return selectedStory;
  }
  set setSelectedStory(Story value) {
    selectedStory = value;
  }


  StoriesBySubject get getSelectedStoriesBySubject {
    return selectedStoriesBySubject;
  }
  set setSelectedStoriesBySubject(StoriesBySubject value) {
    selectedStoriesBySubject = value;
  }

  List<Story> get getStoriesList {
    return storiesList;
  }
  set setStoriesList(List<Story> value) {
    storiesList = value;
  }

  String? get getCorrectWord {
    return correctWord;
  }
  set setCorrectWord(String name) {
    correctWord = name;
  }


  Word? get getSelectedWord {
    return selectedWord;
  }
  set setSelectedWord(Word word) {
    selectedWord = word;
  }


  set setSelectedSubject(Map<String , dynamic> value) {
    selectedSubjectAndCountOfWords = value;
  }
  Map<String , dynamic> get getSelectedSubject {
    return selectedSubjectAndCountOfWords;
  }


  set setSubjectsAndCountWords(List<Map<String , dynamic>> value){
    subjectsAndCountWords = value;
  }
  List<Map<String , dynamic>> get getSubjectsAndCountWords{
    return subjectsAndCountWords;
  }


  set setSelectedSubjects(List<SubjectModel> list) {
    selectedSubjects = list;
  }
  List<SubjectModel> get getSelectedSubjects {
    return selectedSubjects;
  }

  void removeSubject(SubjectModel subject){
    selectedSubjects.remove(subject);
  }
  void removeAllSubject(){
    selectedSubjects = [];
  }


}
