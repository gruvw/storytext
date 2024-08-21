import "package:flutter/material.dart";
import "package:storytext/utils/dart.dart";
import "package:storytext/views/components/markdown_content.dart";
import "package:widget_zoom/widget_zoom.dart";

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
      (s) => MarkdownContent(
        content: _sourcePrefix + s,
        scaleFactor: 1,
      ),
    );

    final image = ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 350,
        maxHeight: 150,
      ),
      child: WidgetZoom(
        heroAnimationTag: path,
        zoomWidget: Image.asset(path),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        image,
        if (imageSource != null) imageSource,
      ],
    );
  }
}
