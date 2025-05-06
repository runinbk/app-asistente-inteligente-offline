class Chat {
  final int? id;
  final String title;
  final DateTime createdAt;
  final DateTime lastUpdated;
  final String? summary;

  Chat({
    this.id,
    required this.title,
    required this.createdAt,
    required this.lastUpdated,
    this.summary,
  });

  Chat copyWith({
    int? id,
    String? title,
    DateTime? createdAt,
    DateTime? lastUpdated,
    String? summary,
  }) {
    return Chat(
      id: id ?? this.id,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      summary: summary ?? this.summary,
    );
  }
}
