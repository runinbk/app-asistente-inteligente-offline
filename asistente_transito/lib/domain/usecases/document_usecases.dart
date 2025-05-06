import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../entities/document.dart';
import '../entities/document_chunk.dart';
import '../repositories/document_repository.dart';

class DocumentUseCases {
  final DocumentRepository repository;

  DocumentUseCases(this.repository);

  // Operaciones básicas de documentos
  Future<Document> addDocument(Document document) async {
    return await repository.saveDocument(document);
  }

  Future<List<Document>> getAllDocuments() async {
    return await repository.getAllDocuments();
  }

  Future<Document?> getDocumentById(int id) async {
    return await repository.getDocumentById(id);
  }

  Future<void> deleteDocument(int id) async {
    await repository.deleteDocument(id);
  }

  // Operaciones de chunks
  Future<DocumentChunk> addChunk(DocumentChunk chunk) async {
    return await repository.saveChunk(chunk);
  }

  Future<List<DocumentChunk>> getChunksByDocumentId(int documentId) async {
    return await repository.getChunksByDocumentId(documentId);
  }
}

final documentUseCasesProvider = Provider<DocumentUseCases>((ref) {
  final repository = ref.watch(documentRepositoryProvider);
  return DocumentUseCases(repository);
});

final documentRepositoryProvider = Provider<DocumentRepository>((ref) {
  throw UnimplementedError();
});
