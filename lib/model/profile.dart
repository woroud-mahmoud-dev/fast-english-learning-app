// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  Profile({
    required  this.id,
    required  this.type,
    required  this.firstName,
    required  this.lastName,
    required  this.userName,
    required  this.email,
    required  this.issocial,
    required  this.social_token,
    required  this.fcm,
    required  this.api_token,
    required  this.membership,
    required  this.expire_at,
    required  this.type_social,
    required  this.email_verified_at,
    required  this.blocked,
    required  this.state,
    required  this.points,
    required  this.level,
    required  this.rank,
    required  this.created_at,
    required  this.updated_at
  });

  int id;                  //1;
  String? firstName;        // "ola";
  String? lastName;         //"fa";
  String? userName;         // null;
  String? email;            // "olafa@gmail.com";
  String? issocial;         // null;
  String? social_token;     // null;
  String? fcm;              // null;
  String? api_token;        // "honanpzM6MMmIv4PM8LIwaE55By45ErLm9CyZfTpydVMPanX3dr16AwwapSL";
  String? membership;       // "0";
  String? expire_at;        // null;
  String? type_social;      // "0";
  String? email_verified_at;// null;
  String? blocked;          // "0";
  String? state;            // "0";
  String? points ;          // "0";
  String? level;            // null;
  String? rank;             // null;
  String? type;             // null;
  String created_at;       // "2022-08-05T10:24:50.000000Z";
  String updated_at;       // "2022-08-14T08:23:42.000000Z";


  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    id: json["id"],
    firstName: json["firstName"],
    email: json["email"],
    api_token: json["api_token"],
    blocked: json['blocked'],
    rank: json['rank'],
    lastName: json['lastName'],
    issocial: json['issocial'],
    social_token: json['social_token'],
    userName: json['userName'],
    membership: json['membership'],
    expire_at: json['expire_at'],
    type_social: json['type_social'],
    level: json['level'],
    updated_at: json['updated_at'],
    email_verified_at: json['email_verified_at'],
    fcm: json['fcm'],
    created_at: json['created_at'],
    state: json['state'],
    points: json['points'],
    type: json['type'],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstName": firstName,
    "lastName": lastName,
    "userName": userName,
    "email": email,
    "issocial": issocial,
    "social_token": social_token,
    "fcm": fcm,
    "api_token": api_token,
    "membership":membership,
    "expire_at": expire_at,
    "type_social": type_social,
    "email_verified_at": email_verified_at,
    "blocked": blocked,
    "state": state,
    "points": points,
    "level": level,
    "rank": rank,
    "type": type,
    "created_at": created_at,
    "updated_at": updated_at
  };
}
