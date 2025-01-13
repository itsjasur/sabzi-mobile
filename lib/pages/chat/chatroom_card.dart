import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sabzi/core/widgets/primary_button.dart';
import 'package:flutter_sabzi/core/widgets/scaled_tap.dart';
import 'package:flutter_sabzi/pages/chat/chat_page_provider.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ChatroomCard extends ConsumerWidget {
  final int id;
  const ChatroomCard({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatroom = ref.watch(chatProvider.select((state) => state.chats.firstWhere((element) => element.id == id)));
    final notifier = ref.read(chatProvider.notifier);

    return SwipeActionCell(
      key: ObjectKey(chatroom),
      leadingActions: [
        SwipeAction(
          closeOnTap: true,
          color: Theme.of(context).colorScheme.primary,
          icon: const Icon(
            PhosphorIconsFill.pushPin,
            color: Colors.white,
            size: 24,
          ),
          onTap: (CompletionHandler handler) async {
            print(handler);
          },
        ),
      ],
      trailingActions: [
        SwipeAction(
          closeOnTap: true,
          color: Colors.red,
          icon: const Icon(
            PhosphorIconsFill.trash,
            color: Colors.white,
            size: 24,
          ),
          onTap: (CompletionHandler handler) async {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                contentPadding: const EdgeInsets.all(20),
                insetPadding: const EdgeInsets.symmetric(horizontal: 55),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Leaving the chat will permanently delete messages. Are you sure you want to leave the chat?',
                      style: TextStyle(
                        fontSize: 15.5,
                      ),
                    ),
                    const SizedBox(height: 15),
                    PrimaryButton(
                      backgroundColor: Colors.red,
                      onTap: () {
                        notifier.deleteChat(chatroom);
                      },
                      child: const Text(
                        'Yes, leave chat',
                        style: TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 7),
                    PrimaryButton(
                      backgroundColor: Theme.of(context).colorScheme.onSurface.withAlpha(150),
                      onTap: () {},
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        SwipeAction(
          closeOnTap: true,
          color: Colors.grey,
          icon: const Icon(
            PhosphorIconsFill.bellSlash,
            color: Colors.white,
            size: 24,
          ),
          onTap: (CompletionHandler handler) async {
            // list.removeAt(index);
            handler(false);
          },
        ),
      ],
      child: ScaledTap(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            spacing: 10,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  color: Theme.of(context).colorScheme.onSurface.withAlpha(40),
                  height: 65,
                  width: 65,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      spacing: 10,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            // state.chats[index].receiver,
                            chatroom.receiver,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                          ),
                        ),
                        Text(
                          '18:54',
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      // state.chats[index].lastMessage,
                      chatroom.lastMessage,
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
