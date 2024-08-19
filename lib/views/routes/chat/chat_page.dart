import "package:flutter/material.dart";
import "package:storytext/static/values.dart";
import "package:storytext/views/components/chat_view.dart";
import "package:storytext/views/components/content_loader.dart";
import "package:storytext/views/components/story_jumping_dialog.dart";

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ContentLoader(
      builder: (context, chatList) {
        return Scaffold(
          appBar: AppBar(
            title: GestureDetector(
              child: const Text(Values.applicationTitle),
              onLongPressStart: (_) {
                showDialog(
                  context: context,
                  builder: (context) => StoryJumpingDialog(
                    chatList: chatList,
                  ),
                );
              },
            ),
          ),
          body: ChatView(chatList: chatList),
        );
      },
    );
  }
}
