class InspirationCard {
  final String id;
  final String content;
  final List<String> tags;
  final DateTime createdAt;

  InspirationCard({
    required this.id,
    required this.content,
    List<String>? tags,
    DateTime? createdAt,
  }) : 
    tags = tags ?? [],
    createdAt = createdAt ?? DateTime.now();

  InspirationCard copyWith({
    String? id,
    String? content,
    List<String>? tags,
    DateTime? createdAt,
  }) {
    return InspirationCard(
      id: id ?? this.id,
      content: content ?? this.content,
      tags: tags ?? this.tags,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

List<String> predefinedTags = [
  '工作',
  '生活',
  '创意',
  '学习',
  '健康',
  '其他',
];
