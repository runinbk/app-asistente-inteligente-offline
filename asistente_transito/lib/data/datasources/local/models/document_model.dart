import 'package:isar/isar.dart';

part 'document_model.g.dart';

@collection
class Document {
  Id id = Isar.autoIncrement;

  String title;
  String filename;
  String? filePath;
  DateTime addedAt;
  int pageCount;
  String documentType; // pdf, docx, txt, etc.

  // Estadísticas
  int? totalTokens;
  int? totalChunks;

  // Metadatos adicionales (opcional)
  String? metadata;

  Document({
    required this.title,
    required this.filename,
    this.filePath,
    required this.addedAt,
    required this.pageCount,
    required this.documentType,
    this.totalTokens,
    this.totalChunks,
    this.metadata,
  });
}
