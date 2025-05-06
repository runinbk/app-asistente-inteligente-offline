import '../entities/document.dart';
import '../entities/document_chunk.dart';

abstract class DocumentRepository {
  // Operaciones de documentos
  Future<Document> saveDocument(Document document);
  Future<List<Document>> getAllDocuments();
  Future<Document?> getDocumentById(int id);
  Future<void> deleteDocument(int id);

  // Operaciones de chunks
  Future<DocumentChunk> saveChunk(DocumentChunk chunk);
  Future<List<DocumentChunk>> getChunksByDocumentId(int documentId);
  Future<List<DocumentChunk>> searchChunks(String query);
}
