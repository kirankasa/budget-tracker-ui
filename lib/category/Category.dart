class TransactionCategory {
  final int id;
  final String category;

  const TransactionCategory({this.id, this.category});

  factory TransactionCategory.fromJson(Map<String, dynamic> json) {
    return new TransactionCategory(id: json['id'], category: json['category']);
  }

  Map<String, dynamic> toJson() => {'category': category};

  @override
  bool operator ==(other) {
    return (other is TransactionCategory && other.category == category);
  }

  @override
  int get hashCode => category.hashCode;
}
