import '../entities/chat.dart';
import '../entities/message.dart';

abstract class ChatRepository {
  // Operaciones de chat
  Future<Chat> saveChat(Chat chat);
  Future<List<Chat>> getAllChats();
  Future<Chat?> getChatById(int id);
  Future<void> deleteChat(int id);

  // Operaciones de mensajes
  Future<Message> saveMessage(Message message);
  Future<List<Message>> getMessagesByChatId(int chatId);
  Future<void> deleteMessage(int id);
}
