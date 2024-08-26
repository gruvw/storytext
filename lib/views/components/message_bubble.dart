import "package:flutter/material.dart";
import "package:storytext/static/styles.dart";

class MessageBubble extends StatelessWidget {
  static const _contentPadding = 6.0;

  final Widget? child;
  final Color color;
  final bool topBorder;
  final bool bottomBorder;

  const MessageBubble({
    super.key,
    this.color = Styles.messageBubbleColor,
    this.topBorder = true,
    this.bottomBorder = true,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(Styles.roundedRadius);

    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          topLeft: topBorder ? radius : Radius.zero,
          topRight: topBorder ? radius : Radius.zero,
          bottomLeft: bottomBorder ? radius : Radius.zero,
          bottomRight: bottomBorder ? radius : Radius.zero,
        ),
      ),
      padding: const EdgeInsets.all(_contentPadding),
      child: child,
    );
  }
}
