import "package:flutter/material.dart";
import "package:storytext/models/choice.dart";
import "package:storytext/models/message.dart";
import "package:storytext/state/chat_list.dart";
import "package:storytext/utils/dart.dart";

enum ChoiceType {
  unexplored(Colors.blue),
  explored(Colors.purple),
  path(Colors.green);
  // TODO UI, better colors

  final Color color;

  const ChoiceType(this.color);

  static ChoiceType fromChoice({
    required Choice choice,
    required MessageId? chosenPath,
    required ChatList chatList,
  }) {
    if (chosenPath == null) {
      // not path chosen yet
      return unexplored;
    }

    if (choice.next == chosenPath) {
      // current path chosen
      return path;
    }

    if (chatList.isMessageExplored(choice.next)) {
      // not current path chosen but already chosen in the past
      return explored;
    }

    // path not explored yet but some other path were
    return unexplored;
  }
}

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
    final chosenPath = chatList.getChosenPath(messageId);
    final chosenPathText = chosenPath.nMap((c) => mcq.withNext(c).answer);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final choice in mcq)
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              disabledBackgroundColor: ChoiceType.path.color,
              backgroundColor: ChoiceType.fromChoice(
                choice: choice,
                chosenPath: chosenPath,
                chatList: chatList,
              ).color,
            ),
            onPressed: choice.next != chosenPath
                ? () => chatList.setChoice(messageId, choice.next)
                : null,
            child: Text(choice.answer),
          ),
        if (chosenPathText != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(chosenPathText),
            ],
          ),
      ],
    );
  }
}
