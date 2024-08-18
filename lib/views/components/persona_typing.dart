import "package:flutter/material.dart";
import "package:storytext/models/persona.dart";
import "package:storytext/views/components/persona_avatar.dart";

class PersonaTyping extends StatelessWidget {
  final Persona persona;

  const PersonaTyping({
    super.key,
    required this.persona,
  });

  @override
  Widget build(BuildContext context) {
    // TODO typing indicator UI

    return Row(
      children: [
        PersonaAvatar(persona: persona),
        const Text("..."),
      ],
    );
  }
}
