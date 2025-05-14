class TopicModel {
  final String titleKey;
  final String description;
  final List<String> keyConcepts;
  final List<String> formulas;
  final String funFact;
  final List<Question> questions;

  TopicModel({
    required this.titleKey,
    required this.description,
    required this.keyConcepts,
    required this.formulas,
    required this.funFact,
    required this.questions,
  });
}

class Question {
  final String questionKey;
  final List<String>? options; // Ko‘p tanlovli savollar uchun, null bo‘lsa ochiq savol
  final String correctAnswer; // To‘g‘ri javob (ochiq savollar uchun kalit, ko‘p tanlovli uchun indeks yoki matn)

  Question({
    required this.questionKey,
    this.options,
    required this.correctAnswer,
  });
}