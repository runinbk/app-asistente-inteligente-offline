import 'package:asistente_transito/domain/entities/chat.dart';
import 'package:asistente_transito/domain/entities/message.dart';
import 'package:asistente_transito/data/datasources/local/models/chat_model.dart';
import 'package:asistente_transito/data/datasources/local/models/message_model.dart';

class ChatMapper {
  // Convertir de Entidad a Modelo
  static ChatModel toModel(Chat chat) {
    return ChatModel()
      ..id = chat.id ?? 0
      ..title = chat.title
      ..createdAt = chat.createdAt
      ..lastUpdated = chat.lastUpdated
      ..summary = chat.summary ?? '';
  }

  // Convertir de Modelo a Entidad
  static Chat fromModel(ChatModel model) {
    return Chat(
      id: model.id,
      title: model.title,
      createdAt: model.createdAt,
      lastUpdated: model.lastUpdated,
      summary: model.summary,
    );
  }

  // Convertir Message de Entidad a Modelo
  static MessageModel messageToModel(Message message, int chatId) {
    return MessageModel()
      ..id = message.id ?? 0
      ..chatId = chatId
      ..content = message.content
      ..isUser = message.isUser
      ..timestamp = message.timestamp
      ..metadata = message.metadata ?? '';
  }

  // Convertir Message de Modelo a Entidad
  static Message messageFromModel(MessageModel model) {
    return Message(
      id: model.id,
      content: model.content,
      isUser: model.isUser,
      timestamp: model.timestamp,
      metadata: model.metadata,
      chatId: model.chatId,
    );
  }
}
