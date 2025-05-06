import 'package:isar/isar.dart';
import 'message_model.dart';

part 'chat_model.g.dart';

@collection
class Chat {
  Id id = Isar.autoIncrement;

  String title;
  DateTime createdAt;
  DateTime lastUpdatedAt;

  // Opcional: un resumen generado del chat
  String? summary;

  // Relación con mensajes
  @Backlink(to: 'chat')
  final messages = IsarLinks<ChatMessage>();

  Chat({
    required this.title,
    required this.createdAt,
    required this.lastUpdatedAt,
    this.summary,
  });
}
