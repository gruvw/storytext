import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_markdown/flutter_markdown.dart";
import "package:url_launcher/url_launcher.dart";
import "package:yaml/yaml.dart";

class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    rootBundle
        .loadString("assets/content.yaml")
        .then((data) => print(loadYamlDocuments(data)));

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
