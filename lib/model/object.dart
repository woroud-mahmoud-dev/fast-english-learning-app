
import 'dart:convert';

List<SubjectModel> objectFromJson(String str) => List<SubjectModel>.from(json.decode(str).map((x) => SubjectModel.fromJson(x)));

String objectToJson(List<SubjectModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubjectModel {
  bool isSelected = false;
  int id;
  String ar_title;
  String en_title;
  String image;

  SubjectModel({
    required this.id,
    required this.ar_title,
    required this.en_title,
    required this.image,
  });

  void toggleIsSelected() {
    isSelected = !isSelected;
  }

  factory SubjectModel.fromJson(Map<String, dynamic> json) => SubjectModel(
    id: json["id"],
    ar_title: json["ar_title"],
    en_title: json["en_title"],
    image: json["image"],
  );
  Map<String, dynamic> toJson() => {
    "id": id,
    "ar_title": ar_title,
    "en_title": en_title,
    "image": image,
  };
}
