import "package:flutter/material.dart";
import "package:storytext/models/persona.dart";
import "package:storytext/state/chat_list.dart";
import "package:storytext/views/components/persona/persona_avatar.dart";

class PersonaUI extends StatelessWidget {
  final ChatList chatList;
  final PersonaId personaId;

  const PersonaUI({
    super.key,
    required this.chatList,
    required this.personaId,
  });

  @override
  Widget build(BuildContext context) {
    final persona = Persona.fromDocument(chatList.setupDoc, personaId);

    // TODO persona UI
    return Row(
      children: [
        PersonaAvatar(persona: persona),
        const SizedBox(width: 6),
        Text(persona.name),
      ],
    );
  }
}
