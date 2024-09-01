import "package:flutter/material.dart";
import "package:storytext/models/message.dart";
import "package:storytext/state/chat_list.dart";
import "package:storytext/static/styles.dart";
import "package:storytext/utils/dart.dart";
import "package:storytext/views/components/markdown_content.dart";
import "package:storytext/views/components/message/image_ui.dart";
import "package:storytext/views/components/message/mcq_ui.dart";
import "package:storytext/views/components/message_bubble.dart";
import "package:storytext/views/components/persona/persona_ui.dart";

class MessageUi extends StatelessWidget {
  static const _storyAssetsPath = "assets/images/story/";
  static const _imageSpacing = 4.0;
  static const _mcqSpacing = 8.0;

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

    final image = message.image.nMap(
      (p) => ImageUi(
        path: _storyAssetsPath + p,
        source: message.imageSource,
      ),
    );

    final mcq = message.mcq.nMap(
      (m) => Center(
        child: McqUi(
          chatList: chatList,
          messageId: messageId,
          mcq: message.mcq!,
        ),
      ),
    );

    final body = Container(
      padding: const EdgeInsets.only(right: Styles.senderPadding),
      constraints: const BoxConstraints(maxWidth: Styles.senderMaxWidth),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PersonaUI(
            chatList: chatList,
            personaId: message.personaId,
          ),
          if (content != null)
            MessageBubble(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Styles.textBubbleHorizontalPadding,
                ),
                child: content,
              ),
            ),
          if (image != null) ...[
            Padding(
              padding: const EdgeInsets.only(top: _imageSpacing),
              child: image,
            ),
          ],
        ],
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        body,
        if (mcq != null) ...[
          const SizedBox(height: _mcqSpacing),
          mcq,
        ],
        if (message.next == null && message.mcq == null)
          const Padding(
            padding: EdgeInsets.only(
              top: Styles.messageBottomSpacing,
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text("END"),
            ),
          ),
      ],
    );
  }
}
