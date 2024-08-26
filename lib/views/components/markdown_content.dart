import "package:flutter/material.dart";
import "package:flutter_markdown/flutter_markdown.dart";
import "package:url_launcher/url_launcher.dart";

class MarkdownContent extends StatelessWidget {
  static const _defaultMessageScale = 1.2;

  final String content;
  final double scaleFactor;

  const MarkdownContent({
    super.key,
    required this.content,
    this.scaleFactor = _defaultMessageScale,
  });

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      data: content,
      selectable: true,
      styleSheet: MarkdownStyleSheet(
        textScaler: TextScaler.linear(scaleFactor),
      ),
      onTapLink: (text, url, title) {
        launchUrl(Uri.parse(url!));
      },
    );
  }
}
