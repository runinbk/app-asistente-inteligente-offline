class Document {
  final int? id;
  final String title;
  final String filename;
  final String filePath;
  final DateTime addedAt;
  final String documentType;
  final int totalChunks;

  Document({
    this.id,
    required this.title,
    required this.filename,
    required this.filePath,
    required this.addedAt,
    required this.documentType,
    this.totalChunks = 0,
  });

  Document copyWith({
    int? id,
    String? title,
    String? filename,
    String? filePath,
    DateTime? addedAt,
    String? documentType,
    int? totalChunks,
  }) {
    return Document(
      id: id ?? this.id,
      title: title ?? this.title,
      filename: filename ?? this.filename,
      filePath: filePath ?? this.filePath,
      addedAt: addedAt ?? this.addedAt,
      documentType: documentType ?? this.documentType,
      totalChunks: totalChunks ?? this.totalChunks,
    );
  }
}
