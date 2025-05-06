import 'package:asistente_transito/domain/entities/chat.dart';
import 'package:asistente_transito/domain/entities/message.dart';
import 'package:asistente_transito/domain/repositories/chat_repository.dart';
import 'package:asistente_transito/data/datasources/local/isar_database.dart';
import 'package:asistente_transito/data/datasources/local/models/chat_model.dart';
import 'package:asistente_transito/data/datasources/local/models/message_model.dart';
import 'package:asistente_transito/data/mappers/chat_mapper.dart';

class ChatRepositoryImpl implements ChatRepository {
  final IsarDatabase _database;

  ChatRepositoryImpl(this._database);

  @override
  Future<Chat> createChat(Chat chat) async {
    final chatModel = ChatMapper.toModel(chat);
    final savedId = await _database.saveChat(chatModel);

    return chat.copyWith(id: savedId);
  }

  @override
  Future<List<Chat>> getAllChats() async {
    final chatModels = await _database.getAllChats();
    return chatModels.map(ChatMapper.fromModel).toList();
  }

  @override
  Future<Chat?> getChatById(int id) async {
    final chatModel = await _database.getChatById(id);
    if (chatModel == null) return null;
    return ChatMapper.fromModel(chatModel);
  }

  @override
  Future<bool> deleteChat(int id) async {
    return await _database.deleteChat(id);
  }

  @override
  Future<Message> addMessageToChat(int chatId, Message message) async {
    final messageModel = ChatMapper.messageToModel(message, chatId);
    final savedId = await _database.saveMessage(messageModel);

    return message.copyWith(id: savedId);
  }

  @override
  Future<List<Message>> getMessagesByChatId(int chatId) async {
    final messageModels = await _database.getMessagesByChatId(chatId);
    return messageModels.map(ChatMapper.messageFromModel).toList();
  }

  @override
  Future<Chat> updateChatTitle(int chatId, String newTitle) async {
    await _database.updateChatTitle(chatId, newTitle);
    final updatedChat = await _database.getChatById(chatId);
    return ChatMapper.fromModel(updatedChat!);
  }
}
