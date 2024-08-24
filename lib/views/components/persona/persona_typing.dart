import "package:flutter/material.dart";
import "package:storytext/models/persona.dart";
import "package:storytext/views/components/persona/persona_avatar.dart";

class PersonaTyping extends StatelessWidget {
  static const _circleRadius = 5.0;
  static const _circleSpacing = 8.0;
  static const _circlePerIndicator = 3;

  final Persona persona;

  const PersonaTyping({
    super.key,
    required this.persona,
  });

  @override
  Widget build(BuildContext context) {
    // TODO typing indicator UI
    final avatar = PersonaAvatar(persona: persona);
    const typingCircle = CircleAvatar(
      backgroundColor: Colors.grey,
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
        const SizedBox(width: 1.5 * _circleSpacing),
        typingIndicator,
      ],
    );
  }
}
