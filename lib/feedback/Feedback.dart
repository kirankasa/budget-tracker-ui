class ExpenseFeedback {
  final String message;

  const ExpenseFeedback({
    this.message,
  });

  factory ExpenseFeedback.fromJson(Map<String, dynamic> json) {
    return ExpenseFeedback(
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
      };
}
