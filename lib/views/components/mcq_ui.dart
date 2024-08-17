import "package:flutter/material.dart";
import "package:storytext/models/choice.dart";
import "package:storytext/models/message.dart";
import "package:storytext/state/chat_list.dart";

class McqUi extends StatelessWidget {
  final ChatList chatList;
  final MessageId messageId;
  final List<Choice> mcq;

  const McqUi({
    super.key,
    required this.chatList,
    required this.messageId,
    required this.mcq,
  });

  @override
  Widget build(BuildContext context) {
    // TODO mcq UI
    return Column(
      children: [
        for (final choice in mcq)
          ElevatedButton(
            onPressed: () {
              chatList.scheduleMsg(choice.next);
            },
            child: Text(choice.answer),
          ),
      ],
    );
  }
}
