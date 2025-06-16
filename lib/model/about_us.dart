

class AboutUs {
  // 1
  final int id;
  // عنوان
  final String title;
  // من نحن 
  final String about;
  // facebook
  final String facebook;
  // linked in
  final String linkedin;
  // insta
  final String instagram;
  // 0994944
  final String phone;
  // twitter
  final String twitter;
  // youtube
  final String youtube;
  // 2022-11-17T21:32:23.000000Z
  final String createdAt;

  AboutUs({
    required this.id ,
    required this.title ,
    required this.about ,
    required this.facebook ,
    required this.linkedin ,
    required this.instagram ,
    required this.phone ,
    required this.twitter ,
    required this.youtube ,
    required this.createdAt ,
  });

  factory AboutUs.fromJson(Map<String, dynamic> json) => AboutUs(
    id: json['id'],
    title: json['title'],
    about: json['about'],
    facebook: json['facebook'],
    linkedin: json['linkedin'],
    instagram: json['instagram'],
    phone: json['phone'],
    twitter: json['twitter'],
    youtube: json['youtube'],
    createdAt: json['created_at'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'about': about,
    'facebook': facebook,
    'linkedin': linkedin,
    'instagram': instagram,
    'phone': phone,
    'twitter': twitter,
    'youtube': youtube,
    'created_at': createdAt,
  };
}

