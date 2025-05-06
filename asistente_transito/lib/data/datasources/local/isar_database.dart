import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:asistente_transito/data/datasources/local/models/document_model.dart';
import 'package:asistente_transito/data/datasources/local/models/chunk_model.dart';
import 'package:asistente_transito/data/datasources/local/models/chat_model.dart';
import 'package:asistente_transito/data/datasources/local/models/message_model.dart';

class IsarDatabase {
  late final Future<Isar> _db;

  IsarDatabase() {
    _db = _initDb();
  }

  Future<Isar> _initDb() async {
    final dir = await getApplicationDocumentsDirectory();

    return await Isar.open(
      [
        DocumentModelSchema,
        ChunkModelSchema,
        ChatModelSchema,
        MessageModelSchema
      ],
      directory: dir.path,
    );
  }

  // Métodos para Document

  Future<int> saveDocument(DocumentModel document) async {
    final isar = await _db;
    return isar.writeTxn(() async {
      return await isar.documentModels.put(document);
    });
  }

  Future<List<DocumentModel>> getAllDocuments() async {
    final isar = await _db;
    return await isar.documentModels.where().sortByAddedAtDesc().findAll();
  }

  Future<DocumentModel?> getDocumentById(int id) async {
    final isar = await _db;
    return await isar.documentModels.get(id);
  }

  Future<bool> deleteDocument(int id) async {
    final isar = await _db;
    return await isar.writeTxn(() async {
      return await isar.documentModels.delete(id);
    });
  }

  // Métodos para Chunks

  Future<List<ChunkModel>> saveDocumentChunks(List<ChunkModel> chunks) async {
    final isar = await _db;
    await isar.writeTxn(() async {
      for (final chunk in chunks) {
        await isar.chunkModels.put(chunk);
      }
    });

    return chunks;
  }

  Future<List<ChunkModel>> getChunksByDocumentId(int documentId) async {
    final isar = await _db;
    return await isar.chunkModels
        .where()
        .documentIdEqualTo(documentId)
        .sortByChunkIndex()
        .findAll();
  }

  Future<void> deleteChunksByDocumentId(int documentId) async {
    final isar = await _db;
    await isar.writeTxn(() async {
      await isar.chunkModels.filter().documentIdEqualTo(documentId).deleteAll();
    });
  }

  Future<List<ChunkModel>> getRecentChunks(int limit) async {
    final isar = await _db;
    return await isar.chunkModels.where().limit(limit).findAll();
  }

  // Métodos para Chat

  Future<int> saveChat(ChatModel chat) async {
    final isar = await _db;
    return isar.writeTxn(() async {
      return await isar.chatModels.put(chat);
    });
  }

  Future<List<ChatModel>> getAllChats() async {
    final isar = await _db;
    return await isar.chatModels.where().sortByLastUpdatedDesc().findAll();
  }

  Future<ChatModel?> getChatById(int id) async {
    final isar = await _db;
    return await isar.chatModels.get(id);
  }

  Future<bool> deleteChat(int id) async {
    final isar = await _db;
    return await isar.writeTxn(() async {
      return await isar.chatModels.delete(id);
    });
  }

  Future<void> updateChatTitle(int chatId, String newTitle) async {
    final isar = await _db;
    await isar.writeTxn(() async {
      final chat = await isar.chatModels.get(chatId);
      if (chat != null) {
        chat.title = newTitle;
        chat.lastUpdated = DateTime.now();
        await isar.chatModels.put(chat);
      }
    });
  }

  // Métodos para Message

  Future<int> saveMessage(MessageModel message) async {
    final isar = await _db;
    return isar.writeTxn(() async {
      final messageId = await isar.messageModels.put(message);

      // Actualizar lastUpdated del chat
      final chat = await isar.chatModels.get(message.chatId);
      if (chat != null) {
        chat.lastUpdated = DateTime.now();
        await isar.chatModels.put(chat);
      }

      return messageId;
    });
  }

  Future<List<MessageModel>> getMessagesByChatId(int chatId) async {
    final isar = await _db;
    return await isar.messageModels
        .where()
        .chatIdEqualTo(chatId)
        .sortByTimestamp()
        .findAll();
  }
}
