// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required  this.id,
    required this.firstName,

    required    this.email,

    required  this.apiToken,


  });

  int id;
  String firstName;

  String email;
  dynamic issocial;

  String apiToken;



  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    firstName: json["firstName"],

    email: json["email"],

    apiToken: json["api_token"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstName": firstName,
    "email": email,
    "issocial": issocial,

    "api_token": apiToken,

  };
}
