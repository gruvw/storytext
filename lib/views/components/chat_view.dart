import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:storytext/state/chat_list.dart";
import "package:storytext/state/hooks.dart";
import "package:storytext/views/components/message_ui.dart";

class ChatView extends HookWidget {
  final ChatList chatList;

  const ChatView({
    super.key,
    required this.chatList,
  });

  @override
  Widget build(BuildContext context) {
    final chat = useListenableState(chatList);

    return ListView.builder(
      reverse: true,
      itemBuilder: (context, index) {
        final messageId = chat.getMessageIdAt(index);

        if (messageId == null) {
          return null;
        }

        return MessageUi(
          chatList: chatList,
          messageId: messageId,
        );
      },
    );
  }
}
