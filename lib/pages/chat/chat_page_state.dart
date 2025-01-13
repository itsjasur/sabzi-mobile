class ChatRoom {
  final int id;
  final String receiver;
  final String lastMessage;
  final DateTime date;
  final bool isNotificationEnabled;

  ChatRoom({
    required this.id,
    required this.receiver,
    required this.lastMessage,
    required this.date,
    this.isNotificationEnabled = false,
  });

  ChatRoom copyWith({
    String? lastMessage,
    DateTime? date,
    bool? isNotificationEnabled,
  }) {
    return ChatRoom(
      id: id,
      receiver: receiver,
      lastMessage: lastMessage ?? this.lastMessage,
      date: date ?? this.date,
      isNotificationEnabled: isNotificationEnabled ?? this.isNotificationEnabled,
    );
  }
}

class ChatState {
  final List<ChatRoom> chats;

  ChatState({required this.chats});

  ChatState copyWith({List<ChatRoom>? chats}) {
    return ChatState(chats: chats ?? this.chats);
  }
}
