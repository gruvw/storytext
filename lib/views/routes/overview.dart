import "package:flutter/material.dart";

class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("StoryText")),
      body: const Center(child: Text("Hello World")),
    );
  }
}
