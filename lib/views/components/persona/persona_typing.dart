import "package:flutter/material.dart";
import "package:storytext/models/persona.dart";
import "package:storytext/static/styles.dart";
import "package:storytext/views/components/message_bubble.dart";
import "package:storytext/views/components/persona/persona_avatar.dart";

class PersonaTyping extends StatelessWidget {
  static const _circleRadius = 5.0;
  static const _circleSpacing = 7.0;
  static const _indicatorPaddingFactor = 1.2;
  static const _circlePerIndicator = 3;
  static const _indicatorHeight = 26.0;

  final Persona persona;

  const PersonaTyping({
    super.key,
    required this.persona,
  });

  @override
  Widget build(BuildContext context) {
    final avatar = PersonaAvatar(persona: persona);
    const typingCircle = CircleAvatar(
      backgroundColor: Styles.typingCircleColor,
      minRadius: _circleRadius,
      maxRadius: _circleRadius,
    );
    final typingIndicator = Wrap(
      spacing: _circleSpacing,
      children: List.filled(_circlePerIndicator, typingCircle),
    );

    return Row(
      children: [
        avatar,
        const SizedBox(width: _circleSpacing),
        MessageBubble(
          child: Container(
            height: _indicatorHeight,
            padding: const EdgeInsets.symmetric(
              horizontal: _indicatorPaddingFactor * _circleSpacing,
            ),
            child: Center(
              child: typingIndicator,
            ),
          ),
        ),
      ],
    );
  }
}
