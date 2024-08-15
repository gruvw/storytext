import "package:flutter/material.dart";
import "package:flutter_markdown/flutter_markdown.dart";
import "package:storytext/models/message.dart";
import "package:storytext/views/components/story_loader.dart";
import "package:url_launcher/url_launcher.dart";

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("StoryText")),
      body: Center(
        child: StoryLoader(
          builder: (context, setupDoc, storyDoc) {
            return MarkdownBody(
              data: Message.fromDocument(storyDoc, "1").text!,
              selectable: true,
              onTapLink: (text, url, title) {
                launchUrl(Uri.parse(url!));
              },
            );
          },
        ),
      ),
    );
  }
}
