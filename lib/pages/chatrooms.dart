import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sabzi_app/components/icon_buttons/notifications.dart';
import 'package:sabzi_app/components/icon_buttons/theme_toggle.dart';
import 'package:sabzi_app/models/chatroom.dart';
import 'package:sabzi_app/test/chatrooms.dart';
import 'package:sabzi_app/theme.dart';
import 'package:sabzi_app/utils/custom_localizers.dart';

class ChatRoomsPage extends StatefulWidget {
  const ChatRoomsPage({super.key});

  @override
  State<ChatRoomsPage> createState() => _ChatRoomsPageState();
}

class _ChatRoomsPageState extends State<ChatRoomsPage> {
  List<Chatroom> _chatrooms = chatroomslist;

  @override
  Widget build(BuildContext context) {
    final colors = AppColorPalette.of(context);

    return Scaffold(
      appBar: AppBar(
        actions: const [
          SizedBox(width: 15),
          Text(
            'Chats',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Spacer(),
          SizedBox(width: 15),
          ThemeToggleButton(),
          SizedBox(width: 15),
          NotificationsButton(),
          SizedBox(width: 15),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: _chatrooms.length,
                (context, index) {
                  Chatroom chatroom = _chatrooms[index];
                  return Column(
                    children: [
                      Slidable(
                        key: ValueKey(index),
                        endActionPane: ActionPane(
                          extentRatio: 0.4,
                          motion: const DrawerMotion(),
                          children: [
                            SlidableAction(
                              padding: EdgeInsets.zero,
                              spacing: 5,
                              onPressed: (context) {},
                              backgroundColor: colors.secondary.withOpacity(0.5),
                              foregroundColor: colors.onMain,
                              icon: Icons.notifications_off,
                            ),
                            SlidableAction(
                              padding: EdgeInsets.zero,
                              spacing: 5,
                              onPressed: (context) async {
                                return await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      actionsAlignment: MainAxisAlignment.spaceEvenly,
                                      contentPadding: const EdgeInsets.all(20),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Text("Even if you leave the chatroom the messages will not be deleted. Are you sure you want to leave the chatroom?"),
                                          const SizedBox(height: 20),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    elevation: 0,
                                                    backgroundColor: colors.secondary.withOpacity(0.5),
                                                  ),
                                                  onPressed: () => Navigator.of(context).pop(false),
                                                  child: const Text('Cancel'),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    elevation: 0,
                                                    backgroundColor: Colors.red,
                                                  ),
                                                  onPressed: () {
                                                    _chatrooms.removeAt(index);
                                                    setState(() {});
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text('Leave room'),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              backgroundColor: Colors.red,
                              foregroundColor: colors.onMain,
                              icon: Icons.delete_forever,
                            ),
                          ],
                        ),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: Image.network(
                                  chatroom.senderImageUrl,
                                  height: 65,
                                  width: 65,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      chatroom.senderName,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),

                                    Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            chatroom.location,
                                            style: TextStyle(
                                              color: colors.secondary.withOpacity(0.5),
                                              fontSize: 13,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Text(
                                          ' • ',
                                          style: TextStyle(
                                            color: colors.secondary.withOpacity(0.5),
                                            fontSize: 13,
                                          ),
                                        ),
                                        Text(
                                          CustomFormatters().getRelativeTime(chatroom.timestamp),
                                          style: TextStyle(
                                            color: colors.secondary.withOpacity(0.5),
                                            fontSize: 13,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),

                                    // RichText(
                                    //   text: TextSpan(
                                    //     style: TextStyle(
                                    //       color: colors.secondary.withOpacity(0.5),
                                    //       fontSize: 13,
                                    //     ),
                                    //     children: [
                                    //       TextSpan(
                                    //         // text: chatroom.location,
                                    //         text: chatroom.location.length > 15 ? chatroom.location.substring(0, 15) : chatroom.location,
                                    //       ),
                                    //       const TextSpan(text: ' • '),
                                    //       TextSpan(
                                    //         text: CustomFormatters().getRelativeTime(chatroom.timestamp),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                    // if (chatroom.latestMessage != null)
                                    //   Padding(
                                    //     padding: const EdgeInsets.only(top: 5),
                                    //     child: Text(
                                    //       chatroom.latestMessage!,
                                    //       style: TextStyle(
                                    //         color: colors.secondary.withOpacity(0.6),
                                    //         fontSize: 14,
                                    //       ),
                                    //       maxLines: 1,
                                    //       overflow: TextOverflow.ellipsis,
                                    //     ),
                                    //   ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      // if (index < _chatrooms.length - 1)
                      //indent image + sizedbox after after
                      const Divider(height: 0, indent: 90, endIndent: 15),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
