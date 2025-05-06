import 'package:equatable/equatable.dart';

class DocumentChunk extends Equatable {
  final int? id;
  final int documentId;
  final String text;
  final int chunkIndex;
  final List<double>? embedding;
  final int tokenCount;

  const DocumentChunk({
    this.id,
    required this.documentId,
    required this.text,
    required this.chunkIndex,
    this.embedding,
    this.tokenCount = 0,
  });

  DocumentChunk copyWith({
    int? id,
    int? documentId,
    String? text,
    int? chunkIndex,
    List<double>? embedding,
    int? tokenCount,
  }) {
    return DocumentChunk(
      id: id ?? this.id,
      documentId: documentId ?? this.documentId,
      text: text ?? this.text,
      chunkIndex: chunkIndex ?? this.chunkIndex,
      embedding: embedding ?? this.embedding,
      tokenCount: tokenCount ?? this.tokenCount,
    );
  }

  @override
  List<Object?> get props => [
        id,
        documentId,
        text,
        chunkIndex,
        embedding,
        tokenCount,
      ];
}
