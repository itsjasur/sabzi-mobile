import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/core/widgets/primary_button.dart';
import 'package:flutter_sabzi/core/widgets/scaled_tap.dart';
import 'package:flutter_sabzi/pages/chat/chat_page_provider.dart';
import 'package:flutter_sabzi/pages/chat/chatroom_card.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(chatProvider);
    final notifier = ref.read(chatProvider.notifier);

    return Scaffold(
      appBar: AppBar(),
      body: ListView.separated(
        padding: const EdgeInsets.only(bottom: 50),
        separatorBuilder: (context, index) => Divider(
          height: 5,
          indent: 90,
          thickness: 1,
          color: Theme.of(context).colorScheme.onSurface.withAlpha(10),
        ),
        itemCount: state.chats.length,
        itemBuilder: (context, index) {
          return ChatroomCard(
            key: ValueKey(state.chats[index].id),
            id: state.chats[index].id,
          );
        },
      ),
    );
  }
}






// child: Align(
//   alignment: Alignment.bottomCenter,
//   child: Image.asset(
//     "assets/user.png",
//     height: 43,
//     color: Theme.of(context).colorScheme.onSurface.withAlpha(80),
//   ),
// ),



// separatorBuilder: (context, index) => Divider(
//   height: 25,
//   indent: 60,
//   thickness: 1,
//   color: Theme.of(context).colorScheme.onSurface.withAlpha(10),
// ),