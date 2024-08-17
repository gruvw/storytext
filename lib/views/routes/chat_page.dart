import "package:flutter/material.dart";
import "package:storytext/static/values.dart";
import "package:storytext/views/components/chat_view.dart";
import "package:storytext/views/components/content_loader.dart";

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Values.applicationTitle),
      ),
      body: Center(
        child: ContentLoader(
          builder: (context, chatList) {
            return ChatView(chatList: chatList);
          },
        ),
      ),
    );
  }
}
