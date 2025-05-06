class Message {
  final int? id;
  final String content;
  final bool isUser;
  final DateTime timestamp;
  final String? metadata;
  final int chatId;

  Message({
    this.id,
    required this.content,
    required this.isUser,
    required this.timestamp,
    this.metadata,
    required this.chatId,
  });

  Message copyWith({
    int? id,
    String? content,
    bool? isUser,
    DateTime? timestamp,
    String? metadata,
    int? chatId,
  }) {
    return Message(
      id: id ?? this.id,
      content: content ?? this.content,
      isUser: isUser ?? this.isUser,
      timestamp: timestamp ?? this.timestamp,
      metadata: metadata ?? this.metadata,
      chatId: chatId ?? this.chatId,
    );
  }
}
