class EWasteItem {
  final String name;
  final String category;
  final int baseCredit;
  int count;

  EWasteItem({
    required this.name,
    required this.category,
    required this.baseCredit,
    this.count = 0,
  });

  factory EWasteItem.fromMap(Map<String, dynamic> map) {
    return EWasteItem(
      name: map['name'],
      category: map['category'],
      baseCredit: map['baseCredit'],
      count: 0,
    );
  }
  EWasteItem copyWith({int? count}) {
    return EWasteItem(
      name: name,
      category: category,
      baseCredit: baseCredit ?? this.baseCredit,
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'category': category,
      'baseCredit': baseCredit,
      'count': count,
    };
  }
}
