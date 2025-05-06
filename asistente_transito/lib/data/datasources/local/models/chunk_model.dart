import 'package:isar/isar.dart';
import 'document_model.dart';

part 'chunk_model.g.dart';

@collection
class DocumentChunk {
  Id id = Isar.autoIncrement;

  String text;
  int chunkIndex;
  int tokenCount;

  // Embedding como lista de flotantes
  List<double>? embedding;

  // Relaciones
  final document = IsarLink<Document>();

  // Metadatos de la posición en el documento original
  int? pageNumber;
  String? section;

  DocumentChunk({
    required this.text,
    required this.chunkIndex,
    required this.tokenCount,
    this.embedding,
    this.pageNumber,
    this.section,
  });
}
