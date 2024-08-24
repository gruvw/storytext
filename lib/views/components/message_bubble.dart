import "package:flutter/material.dart";
import "package:storytext/static/styles.dart";

class MessageBubble extends StatelessWidget {
  static const _contentPadding = 6.0;

  final Widget? child;
  final bool topBorder;
  final bool bottomBorder;

  const MessageBubble({
    super.key,
    this.topBorder = true,
    this.bottomBorder = true,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(20);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Styles.messageBubbleColor,
            borderRadius: BorderRadius.only(
              topLeft: topBorder ? radius : Radius.zero,
              topRight: topBorder ? radius : Radius.zero,
              bottomLeft: bottomBorder ? radius : Radius.zero,
              bottomRight: bottomBorder ? radius : Radius.zero,
            ),
          ),
          padding: const EdgeInsets.all(_contentPadding),
          child: child,
        ),
      ],
    );
  }
}
