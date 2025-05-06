import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:asistente_transito/data/datasources/local/isar_database.dart';
import 'package:asistente_transito/data/repositories/document_repository_impl.dart';
import 'package:asistente_transito/domain/entities/document.dart';
import 'package:asistente_transito/data/datasources/local/models/document_model.dart';

@GenerateMocks([IsarDatabase])
import 'document_repository_test.mocks.dart';

void main() {
  late MockIsarDatabase mockDatabase;
  late DocumentRepositoryImpl repository;

  setUp(() {
    mockDatabase = MockIsarDatabase();
    repository = DocumentRepositoryImpl(mockDatabase);
  });

  group('DocumentRepository', () {
    final testDocument = Document(
      title: 'Test Document',
      filename: 'test.pdf',
      filePath: '/path/to/test.pdf',
      addedAt: DateTime.now(),
      documentType: 'pdf',
    );

    test('saveDocument should return document with updated id', () async {
      // Arrange
      when(mockDatabase.saveDocument(any)).thenAnswer((_) async => 1);

      // Act
      final result = await repository.saveDocument(testDocument);

      // Assert
      expect(result.id, 1);
      verify(mockDatabase.saveDocument(any)).called(1);
    });

    test('getAllDocuments should return list of documents', () async {
      // Arrange
      final documentModel = DocumentModel()
        ..id = 1
        ..title = 'Test Document'
        ..filename = 'test.pdf'
        ..filePath = '/path/to/test.pdf'
        ..addedAt = DateTime.now()
        ..documentType = 'pdf'
        ..totalChunks = 0;

      when(mockDatabase.getAllDocuments())
          .thenAnswer((_) async => [documentModel]);

      // Act
      final result = await repository.getAllDocuments();

      // Assert
      expect(result.length, 1);
      expect(result.first.title, 'Test Document');
      verify(mockDatabase.getAllDocuments()).called(1);
    });
  });
}
