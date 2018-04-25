class ExpenseFeedback {
  final String fromEmail;
  final String message;

  const ExpenseFeedback({
    this.fromEmail,
    this.message,
  });

  factory ExpenseFeedback.fromJson(Map<String, dynamic> json) {
    return new ExpenseFeedback(
      fromEmail: json['fromEmail'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() => {
        'fromEmail': fromEmail,
        'message': message,
      };
}
