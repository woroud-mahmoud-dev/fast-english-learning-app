class Policy {
    String body;
    String? created_at;
    int id;
    String title;
    String? updated_at;

    Policy({required this.body, this.created_at, required this.id, required this.title, this.updated_at});

    factory Policy.fromJson(Map<String, dynamic> json) {
        return Policy(
            body: json['body'], 
            created_at: json['created_at'] ,
            id: json['id'],
            title: json['title'], 
            updated_at: json['updated_at'],
        );
    }

}