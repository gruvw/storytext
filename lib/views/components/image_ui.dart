import "package:flutter/material.dart";
import "package:storytext/utils/dart.dart";
import "package:storytext/views/components/markdown_content.dart";

class ImageUi extends StatelessWidget {
  static const _sourcePrefix = "Source: ";

  final String path;
  final String? source;

  const ImageUi({
    super.key,
    required this.path,
    required this.source,
  });

  @override
  Widget build(BuildContext context) {
    final imageSource = source.nMap(
      (s) => MarkdownContent(content: _sourcePrefix + s),
    );

    final image = ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 350,
        maxHeight: 150,
      ),
      child: Image.asset(path),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          image,
          if (imageSource != null) imageSource,
        ],
      ),
    );
  }
}
