import "package:flutter/material.dart";
import "package:storytext/models/message.dart";
import "package:storytext/state/chat_list.dart";
import "package:storytext/utils/dart.dart";
import "package:storytext/views/components/image_ui.dart";
import "package:storytext/views/components/markdown_content.dart";
import "package:storytext/views/components/mcq_ui.dart";
import "package:storytext/views/components/persona_ui.dart";

class MessageUi extends StatelessWidget {
  static const _storyAssetsPath = "images/story/";

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
    final content = message.text.nMap((t) => MarkdownContent(content: t));
    // TODO message UI widget
    // TODO picture field integration
    final image = message.image.nMap(
      (p) => ImageUi(
        path: _storyAssetsPath + p,
        source: message.imageSource,
      ),
    );

    final mcq = message.mcq != null
        ? McqUi(
            chatList: chatList,
            messageId: messageId,
            mcq: message.mcq!,
          )
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PersonaUI(
          chatList: chatList,
          personaId: message.personaId,
        ),
        if (content != null) content,
        if (image != null) image,
        if (mcq != null) mcq,
      ],
    );
  }
}
