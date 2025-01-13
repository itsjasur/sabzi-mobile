import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/pages/chat/chat_page_state.dart';

class ChatProvider extends Notifier<ChatState> {
  @override
  build() {
    return ChatState(chats: [
      ChatRoom(id: 12123, receiver: 'Junhong', lastMessage: 'Hi there', date: DateTime.now()),
      ChatRoom(id: 34453, receiver: 'Timothy', lastMessage: 'Hi there', date: DateTime.now()),
    ]);
  }

  void deleteChat(ChatRoom chatroom) {
    final chats = state.chats;
    chats.removeWhere((element) => element.id == chatroom.id);
    state = state.copyWith(chats: chats);
  }

  void enableNotification(ChatRoom chatroom) {
    final chats = [...state.chats];
    final index = chats.indexWhere((element) => element.id == chatroom.id);

    if (index != -1) {
      chats[index] = chatroom.copyWith(isNotificationEnabled: !chatroom.isNotificationEnabled);
      state = state.copyWith(chats: chats);
    }
  }
}

final chatProvider = NotifierProvider<ChatProvider, ChatState>(() => ChatProvider());
