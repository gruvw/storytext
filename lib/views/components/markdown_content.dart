import "package:flutter/material.dart";
import "package:flutter_markdown/flutter_markdown.dart";
// ignore: depend_on_referenced_packages
import "package:markdown/markdown.dart" as md;
import "package:url_launcher/url_launcher.dart";

class MarkdownContent extends StatelessWidget {
  static const _defaultMessageScale = 1.2;

  final String content;
  final double scaleFactor;
  final bool selectable;
  final bool centerText;

  const MarkdownContent({
    super.key,
    required this.content,
    this.scaleFactor = _defaultMessageScale,
    this.centerText = false,
    this.selectable = true,
  });

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      data: content,
      selectable: selectable,
      styleSheet: MarkdownStyleSheet(
        textScaler: TextScaler.linear(scaleFactor),
        textAlign: centerText ? WrapAlignment.center : WrapAlignment.start,
      ),
      onTapLink: (text, url, title) {
        launchUrl(Uri.parse(url!));
      },
      extensionSet: md.ExtensionSet(
        md.ExtensionSet.gitHubFlavored.blockSyntaxes,
        [
          md.EmojiSyntax(),
          ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes,
        ],
      ),
    );
  }
}
