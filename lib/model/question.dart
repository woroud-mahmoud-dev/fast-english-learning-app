class Question {
  final String correctWord;
  final String? createdAt;
  final int id;
  final String level;
  final String text;
  final String? updatedAt;
  final String word1;
  final String word2;
  final String word3;
  List<String> answers  = [];
  int? numberAnswers;

  Question({required this.correctWord, this.createdAt, required this.id, required this.level, required this.text, this.updatedAt, required this.word1, required this.word2, required this.word3}){
    answers.add(word1);
    answers.add(word2);
    answers.add(word3);
    numberAnswers = answers.indexOf(correctWord);
  }

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      correctWord: json['correct_word'],
      createdAt: json['created_at'] != null ? (json['created_at'].toString()) : null,
      id: json['id'],
      level: json['level'],
      text: json['ques'],
      updatedAt: json['updated_at'] != null ? (json['updated_at'].toString()) : null,
      word1: json['word1'],
      word2: json['word2'],
      word3: json['word3'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['correct_word'] = correctWord;
    data['id'] = id;
    data['level'] = level;
    data['ques'] = text;
    data['word1'] = word1;
    data['word2'] = word2;
    data['word3'] = word3;
    if (createdAt != null) {
      data['created_at'] = createdAt;
    }
    if (updatedAt != null) {
      data['updated_at'] = updatedAt;
    }
    return data;
  }
}