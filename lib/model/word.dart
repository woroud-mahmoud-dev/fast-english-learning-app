import 'dart:convert';

class Word {
  Word(
      {required this.type,
      required this.id,
      required this.word,
      required this.word1,
      required this.image,
      required this.correct_word,
      required this.object_id,
      required this.level_id,
      this.date});
  int? type;
  final int id;
  final String word;
  final String word1;
  final String image;
  final String correct_word;
  final int object_id;
  final int level_id;
  DateTime? date;

  factory Word.fromJson(String str) => Word.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Word.fromMap(Map<String, dynamic> json) => Word(
      id: json["id"],
      word: json["word"],
      word1: json["word1"],
      image: json["image"],
      correct_word: json["correct_word"],
      object_id: int.parse(json["object_id"].toString()),
      level_id: int.parse((json["level_id"] ?? '1').toString()),
      type: json["type_id"],
      date: DateTime.parse(json['date'] ?? DateTime.now().toString()));

  Map<String, dynamic> toMap1() => {
        "id": id,
        "word": word,
        "word1": word1,
        "image": image,
        "correct_word": correct_word,
        "object_id": object_id,
        "level_id": level_id,
        "type_id": type
      };

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "id": id,
      "word": word,
      "word1": word1,
      "image": image,
      "correct_word": correct_word,
      "object_id": object_id,
      "level_id": level_id,
      "type_id": type
    };
    return map;
  }
}
