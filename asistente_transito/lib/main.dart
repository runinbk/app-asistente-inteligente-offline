import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:isar/isar.dart';

import 'app.dart';
import 'data/datasources/local/isar_database.dart';
import 'data/repositories/document_repository_impl.dart';
import 'data/repositories/chat_repository_impl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar la base de datos
  final dir = await getApplicationDocumentsDirectory();
  final isar = await openIsarDatabase(dir.path);

  // Inicializar repositorios
  final documentRepository = DocumentRepositoryImpl(isar);
  final chatRepository = ChatRepositoryImpl(isar);

  runApp(
    ProviderScope(
      overrides: [
        isarProvider.overrideWithValue(isar),
        documentRepositoryProvider.overrideWithValue(documentRepository),
        chatRepositoryProvider.overrideWithValue(chatRepository),
      ],
      child: const AsistenteTransitoApp(),
    ),
  );
}
