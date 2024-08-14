import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:yaml/yaml.dart";

class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final data = rootBundle.loadString("assets/content.yaml");

    rootBundle
        .loadString("assets/content.yaml")
        .then((data) => print(loadYamlDocuments(data)));

    return Scaffold(
      appBar: AppBar(title: const Text("StoryText")),
      body: const Center(child: Text("Hello World")),
    );
  }
}
