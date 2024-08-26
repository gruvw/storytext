import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:storytext/state/chat_list.dart";
import "package:storytext/state/hooks.dart";
import "package:storytext/utils/dart.dart";
import "package:storytext/views/components/message/message_ui.dart";
import "package:storytext/views/components/persona/persona_typing.dart";

class ChatView extends HookWidget {
  static const _messageBottomSpacing = 10.0;
  static const _contentPadding = 8.0;

  final ChatList chatList;

  const ChatView({
    super.key,
    required this.chatList,
  });

  @override
  Widget build(BuildContext context) {
    final chat = useListenableState(chatList);

    return Padding(
      padding: const EdgeInsets.only(
        left: _contentPadding,
        bottom: _contentPadding,
        right: _contentPadding,
      ),
      child: ListView.builder(
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

          final messageUi = messageId.nMap(
            (m) => Padding(
              padding: const EdgeInsets.only(
                bottom: _messageBottomSpacing,
              ),
              child: MessageUi(
                key: ValueKey(m),
                chatList: chatList,
                messageId: m,
              ),
            ),
          );

          return messageUi;
        },
      ),
    );
  }
}
