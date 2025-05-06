import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:asistente_transito/data/datasources/local/isar_database.dart';
import 'package:asistente_transito/data/repositories/document_repository_impl.dart';
import 'package:asistente_transito/data/repositories/chat_repository_impl.dart';
import 'package:asistente_transito/data/repositories/vector_repository_impl.dart';
import 'package:asistente_transito/domain/repositories/document_repository.dart';
import 'package:asistente_transito/domain/repositories/chat_repository.dart';
import 'package:asistente_transito/domain/repositories/vector_repository.dart';

// Provider para la base de datos
final isarDatabaseProvider = Provider<IsarDatabase>((ref) {
  return IsarDatabase();
});

// Providers para los repositorios
final documentRepositoryProvider = Provider<DocumentRepository>((ref) {
  final database = ref.watch(isarDatabaseProvider);
  return DocumentRepositoryImpl(database);
});

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  final database = ref.watch(isarDatabaseProvider);
  return ChatRepositoryImpl(database);
});

final vectorRepositoryProvider = Provider<VectorRepository>((ref) {
  final database = ref.watch(isarDatabaseProvider);
  return VectorRepositoryImpl(database);
});
