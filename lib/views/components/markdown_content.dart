import "package:flutter/material.dart";
import "package:flutter_markdown/flutter_markdown.dart";
import "package:url_launcher/url_launcher.dart";

class MarkdownContent extends StatelessWidget {
  final String content;

  const MarkdownContent({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      data: content,
      selectable: true,
      onTapLink: (text, url, title) {
        launchUrl(Uri.parse(url!));
      },
    );
  }
}
