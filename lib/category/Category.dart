class TransactionCategory {
  final String id;
  final String category;

  const TransactionCategory({this.id, this.category});

  factory TransactionCategory.fromJson(Map<String, dynamic> json) {
    return TransactionCategory(id: json['id'], category: json['category']);
  }

  Map<String, dynamic> toJson() => {'category': category, 'id': id};

  @override
  bool operator ==(other) {
    return (other is TransactionCategory && other.id == id);
  }

  @override
  int get hashCode => id.hashCode;
}
