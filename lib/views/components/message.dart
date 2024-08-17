import "package:flutter/material.dart";
import "package:flutter_markdown/flutter_markdown.dart";
import "package:storytext/models/message.dart";
import "package:storytext/state/chat_list.dart";
import "package:storytext/views/components/mcq.dart";
import "package:storytext/views/components/persona.dart";
import "package:url_launcher/url_launcher.dart";

class MessageUi extends StatelessWidget {
  final ChatList chatList;
  final MessageId messageId;

  const MessageUi({
    super.key,
    required this.chatList,
    required this.messageId,
  });

  @override
  Widget build(BuildContext context) {
    final message = Message.fromDocument(chatList.storyDoc, messageId);
    final content = message.text != null
        ? MarkdownBody(
            data: message.text!,
            selectable: true,
            onTapLink: (text, url, title) {
              launchUrl(Uri.parse(url!));
            },
          )
        : null;
    // TODO message UI widget
    // TODO picture field integration

    final mcq = message.mcq != null
        ? McqUi(
            chatList: chatList,
            messageId: messageId,
            mcq: message.mcq!,
          )
        : null;

    return Column(
      children: [
        PersonaUI(
          chatList: chatList,
          personaId: message.personaId,
        ),
        if (content != null) content,
        if (mcq != null) mcq,
      ],
    );
  }
}
