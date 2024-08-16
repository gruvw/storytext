import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:storytext/state/chat_list.dart";

T useListenableState<T extends ChangeNotifier>(T data) {
  final state = useState<T>(data);
  return useListenable(state.value);
}

class ChatView extends HookWidget {
  final ChatList chatList;

  const ChatView({
    super.key,
    required this.chatList,
  });

  @override
  Widget build(BuildContext context) {
    final chat = useListenableState(chatList);

    // final message = MarkdownBody(
    //   data: Message.fromDocument(storyDoc, "1").text!,
    //   selectable: true,
    //   onTapLink: (text, url, title) {
    //     launchUrl(Uri.parse(url!));
    //   },
    // );
    return ListView.builder(
      reverse: true,
      itemBuilder: (context, index) {
        final msgId = chat.getMessageIdAt(index);

        if (msgId == null) {
          return null;
        }

        return Text(msgId);
      },
    );
  }
}
