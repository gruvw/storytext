import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:storytext/state/chat_list.dart";
import "package:yaml/yaml.dart";

class ContentLoader extends StatelessWidget {
  static const _contentLocation = "assets/content/content.yaml";

  final Function(BuildContext context, ChatList chatList) builder;

  const ContentLoader({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: rootBundle
          .loadString(_contentLocation)
          .then((content) => loadYamlDocuments(content))
          .then((documents) {
        final setupDoc = documents[0].contents.value as YamlMap;
        final storyDoc = documents[1].contents.value as YamlMap;
        return ChatList.create(setupDoc: setupDoc, storyDoc: storyDoc);
      }),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        return builder(context, snapshot.data!);
      },
    );
  }
}
