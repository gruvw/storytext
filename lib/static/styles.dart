import "package:flutter/material.dart";

abstract class Styles {
  // TODO UI, better colors
  static const messageBubbleColor = Color(0xffdddddd);
  static const answerBubbleColor = Color(0xff55aaff);

  static const pathMcqColor = Color(0xff77B7F7);
  static const exploredMcqColor = Color(0xffAACBEA);
  static const unexploredMcqColor = Colors.transparent;

  static const typingCircleColor = Colors.black54;

  static const colorDanger = Colors.red;

  static const roundedRadius = 14.0;
  static const senderPadding = 20.0;
  static const senderMaxWidth = 900.0;
  static const mcqMaxWidthFactor = 0.7;

  static const textBubbleHorizontalPadding = 3.0;
  static const messageBottomSpacing = 10.0;
}
