import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../entities/chat.dart';
import '../entities/message.dart';
import '../repositories/chat_repository.dart';

class ChatUseCases {
  final ChatRepository repository;

  ChatUseCases(this.repository);

  // Operaciones de chat
  Future<Chat> createChat(String title) async {
    final now = DateTime.now();
    final chat = Chat(
      title: title,
      createdAt: now,
      lastUpdated: now,
    );
    return await repository.saveChat(chat);
  }

  Future<List<Chat>> getAllChats() async {
    return await repository.getAllChats();
  }

  Future<Chat?> getChatById(int id) async {
    return await repository.getChatById(id);
  }

  Future<void> deleteChat(int id) async {
    await repository.deleteChat(id);
  }

  // Operaciones de mensajes
  Future<Message> addMessage(Message message) async {
    final savedMessage = await repository.saveMessage(message);

    // Actualizar la fecha de último acceso del chat
    final chat = await repository.getChatById(message.chatId);
    if (chat != null) {
      await repository.saveChat(
        chat.copyWith(lastUpdated: DateTime.now()),
      );
    }

    return savedMessage;
  }

  Future<List<Message>> getMessagesByChatId(int chatId) async {
    return await repository.getMessagesByChatId(chatId);
  }
}

final chatUseCasesProvider = Provider<ChatUseCases>((ref) {
  final repository = ref.watch(chatRepositoryProvider);
  return ChatUseCases(repository);
});

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  throw UnimplementedError();
});
