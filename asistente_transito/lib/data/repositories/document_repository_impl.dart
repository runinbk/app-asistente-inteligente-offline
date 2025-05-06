import 'package:asistente_transito/domain/entities/document.dart';
import 'package:asistente_transito/domain/entities/document_chunk.dart';
import 'package:asistente_transito/domain/repositories/document_repository.dart';
import 'package:asistente_transito/data/datasources/local/isar_database.dart';
import 'package:asistente_transito/data/datasources/local/models/document_model.dart';
import 'package:asistente_transito/data/datasources/local/models/chunk_model.dart';
import 'package:asistente_transito/data/mappers/document_mapper.dart';

class DocumentRepositoryImpl implements DocumentRepository {
  final IsarDatabase _database;

  DocumentRepositoryImpl(this._database);

  @override
  Future<Document> saveDocument(Document document) async {
    final documentModel = DocumentMapper.toModel(document);
    final savedId = await _database.saveDocument(documentModel);

    // Actualizar el ID y devolver la entidad actualizada
    return document.copyWith(id: savedId);
  }

  @override
  Future<List<Document>> getAllDocuments() async {
    final documentModels = await _database.getAllDocuments();
    return documentModels.map(DocumentMapper.fromModel).toList();
  }

  @override
  Future<Document?> getDocumentById(int id) async {
    final documentModel = await _database.getDocumentById(id);
    if (documentModel == null) return null;
    return DocumentMapper.fromModel(documentModel);
  }

  @override
  Future<bool> deleteDocument(int id) async {
    return await _database.deleteDocument(id);
  }

  @override
  Future<List<DocumentChunk>> saveDocumentChunks(
      int documentId, List<DocumentChunk> chunks) async {
    final chunkModels = chunks
        .map((chunk) => DocumentMapper.chunkToModel(chunk, documentId))
        .toList();

    final savedChunks = await _database.saveDocumentChunks(chunkModels);

    return savedChunks
        .map((chunkModel) => DocumentMapper.chunkFromModel(chunkModel))
        .toList();
  }

  @override
  Future<List<DocumentChunk>> getChunksByDocumentId(int documentId) async {
    final chunkModels = await _database.getChunksByDocumentId(documentId);
    return chunkModels.map(DocumentMapper.chunkFromModel).toList();
  }
}
