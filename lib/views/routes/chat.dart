import "package:flutter/material.dart";
import "package:storytext/views/components/chat_view.dart";
import "package:storytext/views/components/story_loader.dart";

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("StoryText")),
      body: Center(
        child: StoryLoader(
          builder: (context, chatList) {
            return ChatView(chatList: chatList);
          },
        ),
      ),
    );
  }
}
