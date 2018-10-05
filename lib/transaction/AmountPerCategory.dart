class AmountPerCategory {
  final String category;
  final int totalAmount;

  AmountPerCategory({this.category, this.totalAmount});

  factory AmountPerCategory.fromJson(Map<String, dynamic> json) {
    return AmountPerCategory(
      category: json['category'],
      totalAmount: json['totalAmount'],
    );
  }

  Map<String, dynamic> toJson() => {
        'category': category,
        'totalAmount': totalAmount,
      };
}
