import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_markdown/flutter_markdown.dart";
import "package:storytext/models/message.dart";
import "package:storytext/models/persona.dart";
import "package:url_launcher/url_launcher.dart";
import "package:yaml/yaml.dart";

class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    rootBundle.loadString("assets/content.yaml").then((data) {
      var doc1 = loadYamlDocuments(data)[0].contents.value as YamlMap;
      var doc2 = loadYamlDocuments(data)[1].contents.value as YamlMap;
      var t = Persona.fromDocument(doc1, "1");
      var s = Message.fromDocument(doc2, "1");
      var u = Message.fromDocument(doc2, "2");
      print(doc1);
    });

    return Scaffold(
      appBar: AppBar(title: const Text("StoryText")),
      body: Center(
        child: MarkdownBody(
          data: "Hello <https://youtu.be/TBikbn5XJhg>! **hey**",
          selectable: true,
          onTapLink: (text, url, title) {
            launchUrl(Uri.parse(url!));
          },
        ),
      ),
    );
  }
}
