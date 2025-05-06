import 'package:isar/isar.dart';
import 'chat_model.dart';
import 'chunk_model.dart';

part 'message_model.g.dart';

@collection
class ChatMessage {
  Id id = Isar.autoIncrement;

  String content;
  bool isUser;
  DateTime timestamp;

  // Relación con chat
  final chat = IsarLink<Chat>();

  // Referencias a chunks usados para responder (opcional)
  final referencedChunks = IsarLinks<DocumentChunk>();

  // Metadatos adicionales
  String? metadata;

  ChatMessage({
    required this.content,
    required this.isUser,
    required this.timestamp,
    this.metadata,
  });
}
