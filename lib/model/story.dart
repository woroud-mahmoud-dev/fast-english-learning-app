import 'package:meta/meta.dart';
import 'dart:convert';

class Story {
  Story({
    required this.id,
    required this.arText,
    required this.enText,
    required this.title,
    required this.image,
    this.object_id,
  });

  final int id;
  final String arText;
  final String enText;
  final String title;
  final String image;
  dynamic object_id;

  factory Story.fromJson(String str) => Story.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Story.fromMap(Map<String, dynamic> json) => Story(
        id: json["id"],
        arText: json["ar_text"],
        enText: json["en_text"],
        title: json["title"],
        image: json["image"],
        object_id: json["object_id"] ?? '1',
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "ar_text": arText,
        "en_text": enText,
        "title": title,
        "image": image,
        "object_id": object_id,
      };
}
