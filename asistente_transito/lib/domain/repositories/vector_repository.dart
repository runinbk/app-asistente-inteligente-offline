import '../entities/document_chunk.dart';

abstract class VectorRepository {
  // Operaciones vectoriales
  Future<void> indexVector(int chunkId, List<double> embedding);
  Future<List<DocumentChunk>> searchSimilar(List<double> queryVector,
      {int limit = 5});
  Future<void> deleteVectorsByDocumentId(int documentId);
}
