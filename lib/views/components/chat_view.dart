import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:storytext/state/chat_list.dart";
import "package:storytext/state/hooks.dart";
import "package:storytext/utils/dart.dart";
import "package:storytext/views/components/message_ui.dart";
import "package:storytext/views/components/persona_typing.dart";

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
        if (chatList.cancelled) {
          // hide chat while waiting for cancelation to complete
          return null;
        }

        // first element eaten by typing indicator
        if (index == 0) {
          return chatList.typingPersona.nMap(
                (p) => PersonaTyping(persona: p),
              ) ??
              const SizedBox();
        }
        --index;

        final messageId = chat.getMessageIdAt(index);

        return messageId.nMap(
          (m) => MessageUi(
            key: ValueKey(m),
            chatList: chatList,
            messageId: m,
          ),
        );
      },
    );
  }
}
