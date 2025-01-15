class Quiz {
  final String quizId;
  final String content;
  final List<Option> options;

  Quiz({
    required this.quizId,
    required this.content,
    required this.options,
  });

  // Ghi đè phương thức toString để in thông tin chi tiết của Quiz
  @override
  String toString() {
    return 'Quiz{quizId: $quizId, content: $content, options: ${options.map((option) => option.toString()).join(', ')}}';
  }

  // Factory để chuyển từ JSON sang object Quiz
  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      quizId: json['quizId'] as String,
      content: json['content'] as String,
      options: (json['options'] as List<dynamic>)
          .map((option) => Option.fromJson(option))
          .toList(),
    );
  }
}

class Option {
  final String content;
  final bool isCorrect;

  Option({
    required this.content,
    required this.isCorrect,
  });

  // Ghi đè phương thức toString để in thông tin chi tiết của Option
  @override
  String toString() {
    return 'Option{content: $content, isCorrect: $isCorrect}';
  }

  // Factory để chuyển từ JSON sang object Option
  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      content: json['content'] as String,
      isCorrect: json['isCorrect'] as bool,
    );
  }
}
