class Option {
  final int id;
  final String description;
  final bool isCorrect;

  //state variable
  bool isSelected = false;

  void resetState() {
    isSelected = false;
  }

  Option({
    required this.id,
    required this.description,
    this.isCorrect = false,
  });

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      id: json['id'],
      description: json['description'],
      isCorrect: json['is_correct'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'is_correct': isCorrect,
    };
  }
}
