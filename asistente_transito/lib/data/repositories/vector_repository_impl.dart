import 'package:asistente_transito/domain/entities/document_chunk.dart';
import 'package:asistente_transito/domain/repositories/vector_repository.dart';
import 'package:asistente_transito/data/datasources/local/isar_database.dart';
import 'package:asistente_transito/data/mappers/document_mapper.dart';

class VectorRepositoryImpl implements VectorRepository {
  final IsarDatabase _database;

  // Esto es temporal hasta que integremos FAISS u otra solución de búsqueda vectorial
  // En una fase posterior, se reemplazará con una implementación más completa
  VectorRepositoryImpl(this._database);

  @override
  Future<void> indexChunk(DocumentChunk chunk) async {
    // Por ahora, solo aseguramos que el chunk esté almacenado en la base de datos
    // La indexación real se implementará en la Fase 3
    if (chunk.id == null || chunk.id == 0) {
      throw Exception(
          'El chunk debe estar guardado en la base de datos antes de indexarlo');
    }
  }

  @override
  Future<List<DocumentChunk>> searchSimilarChunks(
      List<double> queryVector, int limit) async {
    // Implementación provisional - en la Fase 3 usaremos búsqueda vectorial real
    // Por ahora, simplemente devolvemos los chunks más recientes
    final chunkModels = await _database.getRecentChunks(limit);
    return chunkModels.map(DocumentMapper.chunkFromModel).toList();
  }

  @override
  Future<void> deleteChunksForDocument(int documentId) async {
    await _database.deleteChunksByDocumentId(documentId);
  }
}
