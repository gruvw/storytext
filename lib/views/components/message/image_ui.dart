import "package:flutter/material.dart";
import "package:storytext/utils/dart.dart";
import "package:storytext/views/components/markdown_content.dart";
import "package:widget_zoom/widget_zoom.dart";

class ImageUi extends StatelessWidget {
  static const _maxWidth = 350.0;
  static const _maxHeight = 150.0;

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

    final image = Container(
      constraints: const BoxConstraints(
        maxWidth: _maxWidth,
        maxHeight: _maxHeight,
      ),
      child: WidgetZoom(
        heroAnimationTag: path,
        zoomWidget: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(path),
        ),
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
