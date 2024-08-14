import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:yaml/yaml.dart";

class StoryLoader extends StatelessWidget {
  static const _storyLocation = "assets/content.yaml";

  final Function(
    BuildContext context,
    YamlMap setupDoc,
    YamlMap storyDoc,
  ) builder;

  const StoryLoader({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: rootBundle
          .loadString(_storyLocation)
          .then((content) => loadYamlDocuments(content)),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        final documents = snapshot.data!;
        final setupDoc = documents[0].contents.value as YamlMap;
        final storyDoc = documents[1].contents.value as YamlMap;

        return builder(context, setupDoc, storyDoc);
      },
    );
  }
}
