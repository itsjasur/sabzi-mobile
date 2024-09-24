import 'package:flutter/material.dart';
import 'package:sabzi_app/components/scaled_tap.dart';
import 'package:sabzi_app/theme.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatsPage> {
  final TextEditingController _messageTextController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final colors = AppColorPalette.of(context);

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              reverse: true,
              controller: _scrollController,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: 20,
                    (BuildContext context, int index) {
                      return Text('Message');
                    },
                  ),
                ),
              ],
            ),
          ),
          TextFormField(
            controller: _messageTextController,
            focusNode: _focusNode,
            style: const TextStyle(fontSize: 15),
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              isCollapsed: true,
              // isDense: true,
              fillColor: colors.secondary.withOpacity(0.07),

              hintText: 'Search here',
              hintStyle: TextStyle(
                color: colors.secondary.withOpacity(0.3),
                fontSize: 15,
              ),
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide.none,
              ),

              constraints: const BoxConstraints(maxHeight: 40),
              suffixIcon: ScaledTap(
                onTap: () {
                  setState(() {
                    _messageTextController.clear();
                  });
                },
                child: Icon(
                  Icons.cancel,
                  color: colors.secondary.withOpacity(0.3),
                  size: 20,
                ),
              ),
            ),
            onChanged: (value) {
              print(value);
              setState(() {});
            },
            onTap: () {
              print(_focusNode.hasFocus);
            },
          ),
        ],
      ),
    );
  }
}
