import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sabzi_app/components/custom_icon_button.dart';
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
          SafeArea(
            child: Container(
              // color: Colors.amber.shade100,
              // constraints: const BoxConstraints(minHeight: 50, maxHeight: 200),
              // height: 500,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ScaledTap(
                    onTap: () {},
                    child: Container(
                      // color: Colors.amber,
                      padding: const EdgeInsets.only(left: 15, right: 7),
                      child: Icon(
                        PhosphorIcons.plus(PhosphorIconsStyle.bold),
                        size: 27,
                        color: colors.secondary.withOpacity(0.4),
                      ),
                    ),
                  ),
                  // CustomIconButton(
                  //   icon: PhosphorIcons.plus(PhosphorIconsStyle.bold),
                  //   iconSize: 27,
                  //   color: colors.secondary.withOpacity(0.4),
                  // ),
                  Expanded(
                    child: TextField(
                      maxLines: null,
                      controller: _messageTextController,
                      focusNode: _focusNode,
                      style: const TextStyle(fontSize: 15),
                      textAlignVertical: TextAlignVertical.center,
                      cursorHeight: 18,
                      decoration: InputDecoration(
                        constraints: const BoxConstraints(minHeight: 0, maxHeight: 120),
                        contentPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),

                        // contentPadding: const EdgeInsets.all(0),
                        // contentPadding: EdgeInsets.zero,
                        // isDense: true,
                        isCollapsed: true,
                        fillColor: colors.secondary.withOpacity(0.07),
                        hintText: 'Search here',
                        hintStyle: TextStyle(
                          color: colors.secondary.withOpacity(0.3),
                          fontSize: 15,
                        ),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
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
                  ),
                  Container(
                    // color: Colors.amber,
                    padding: const EdgeInsets.only(right: 15, left: 7),
                    child: Icon(
                      PhosphorIcons.paperPlaneRight(PhosphorIconsStyle.fill),
                      size: 27,
                      color: _messageTextController.text.isNotEmpty ? colors.main : colors.secondary.withOpacity(0.4),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
