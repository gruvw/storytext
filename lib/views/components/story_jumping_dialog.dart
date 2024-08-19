import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:storytext/models/message.dart";
import "package:storytext/state/chat_list.dart";
import "package:storytext/static/styles.dart";

class StoryJumpingDialog extends HookWidget {
  final ChatList chatList;

  const StoryJumpingDialog({
    super.key,
    required this.chatList,
  });

  @override
  Widget build(BuildContext context) {
    final targetIdController = useTextEditingController();
    final errorText = useState("");

    String? validTarget() {
      final targetId = targetIdController.text;
      if (!Message.existsInDocument(
        chatList.storyDoc,
        targetId,
      )) {
        return null;
      }

      return targetId;
    }

    return AlertDialog(
      title: const Text("Story Jumping"),
      content: TextField(
        decoration: InputDecoration(
          label: const Text("Message ID"),
          hintText: chatList.isNotEmpty ? chatList.head : chatList.storyRoot,
          errorText: errorText.value.isEmpty ? null : errorText.value,
        ),
        controller: targetIdController,
        onChanged: (_) {
          if (validTarget() == null && targetIdController.text.isNotEmpty) {
            errorText.value = "Invalid target message ID.";
          } else {
            errorText.value = "";
          }
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (chatList.isEmpty) {
              return;
            }

            chatList.scheduleAsRoot(chatList.storyRoot);
            Navigator.pop(context);
          },
          style: TextButton.styleFrom(
            overlayColor: Styles.colorDanger,
            foregroundColor: Styles.colorDanger,
          ),
          child: const Text("Restart"),
        ),
        OutlinedButton(
          onPressed: () {
            final targetId = validTarget();
            if (targetId == null || chatList.isEmpty) {
              return;
            }

            chatList.scheduleAsRoot(targetId);
            Navigator.pop(context);
          },
          style: OutlinedButton.styleFrom(
            foregroundColor: Styles.colorDanger,
            overlayColor: Styles.colorDanger,
            side: const BorderSide(color: Styles.colorDanger),
          ),
          child: const Text("Go To"),
        ),
      ],
    );
  }
}
