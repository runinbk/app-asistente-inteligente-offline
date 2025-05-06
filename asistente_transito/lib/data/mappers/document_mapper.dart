import 'package:asistente_transito/domain/entities/document.dart';
import 'package:asistente_transito/domain/entities/document_chunk.dart';
import 'package:asistente_transito/data/datasources/local/models/document_model.dart';
import 'package:asistente_transito/data/datasources/local/models/chunk_model.dart';

class DocumentMapper {
  // Convertir de Entidad a Modelo
  static DocumentModel toModel(Document document) {
    return DocumentModel()
      ..id = document.id ?? 0
      ..title = document.title
      ..filename = document.filename
      ..filePath = document.filePath
      ..addedAt = document.addedAt
      ..documentType = document.documentType
      ..totalChunks = document.totalChunks;
  }

  // Convertir de Modelo a Entidad
  static Document fromModel(DocumentModel model) {
    return Document(
      id: model.id,
      title: model.title,
      filename: model.filename,
      filePath: model.filePath,
      addedAt: model.addedAt,
      documentType: model.documentType,
      totalChunks: model.totalChunks,
    );
  }

  // Convertir Chunk de Entidad a Modelo
  static ChunkModel chunkToModel(DocumentChunk chunk, int documentId) {
    return ChunkModel()
      ..id = chunk.id ?? 0
      ..documentId = documentId
      ..text = chunk.text
      ..chunkIndex = chunk.chunkIndex
      ..embedding = chunk.embedding
      ..tokenCount = chunk.tokenCount;
  }

  // Convertir Chunk de Modelo a Entidad
  static DocumentChunk chunkFromModel(ChunkModel model) {
    return DocumentChunk(
      id: model.id,
      text: model.text,
      chunkIndex: model.chunkIndex,
      embedding: model.embedding,
      tokenCount: model.tokenCount,
      documentId: model.documentId,
    );
  }
}
