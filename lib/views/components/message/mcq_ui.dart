import "package:flutter/material.dart";
import "package:storytext/models/choice.dart";
import "package:storytext/models/message.dart";
import "package:storytext/state/chat_list.dart";
import "package:storytext/static/styles.dart";
import "package:storytext/utils/dart.dart";
import "package:storytext/views/components/message_bubble.dart";

enum ChoiceType {
  unexplored(Styles.unexploredMcqColor),
  explored(Styles.exploredMcqColor),
  path(Styles.pathMcqColor);

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
  static const _answerSpacing = 8.0;
  static const _choiceSpacing = 6.0;

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

    // TODO use the same rounded factor on buttons
    // final choices = Wrap(
    //   direction: Axis.vertical,
    //   spacing: _choiceSpacing,
    //   children: [
    //   ],
    // );

    return Column(
      children: [
        for (final choice in mcq) ...[
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: Styles.senderPadding,
            ),
            constraints: const BoxConstraints(
              maxWidth: 0.8 * Styles.senderMaxWidth,
            ),
            child: MessageBubble(
              color: ChoiceType.fromChoice(
                choice: choice,
                chosenPath: chosenPath,
                chatList: chatList,
              ).color,
              onClick: choice.next != chosenPath
                  ? () => chatList.setChoice(messageId, choice.next)
                  : null,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Styles.textBubbleHorizontalPadding,
                ),
                child: Text(choice.answer),
              ),
            ),
          ),
          const SizedBox(height: _choiceSpacing),
        ],
        if (chosenPathText != null) ...[
          const SizedBox(height: _answerSpacing),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: const EdgeInsets.only(
                left: Styles.senderPadding,
              ),
              constraints: const BoxConstraints(
                maxWidth: Styles.senderMaxWidth,
              ),
              child: MessageBubble(
                color: Styles.answerBubbleColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Styles.textBubbleHorizontalPadding,
                  ),
                  child: Text(chosenPathText),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
