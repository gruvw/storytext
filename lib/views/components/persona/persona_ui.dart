import "package:flutter/material.dart";
import "package:storytext/models/persona.dart";
import "package:storytext/state/chat_list.dart";
import "package:storytext/views/components/persona/persona_avatar.dart";

class PersonaUI extends StatelessWidget {
  static const nameStyle = TextStyle(fontWeight: FontWeight.w500);
  static const _pictureNameSpacing = 6.0;
  static const _bottomSpacing = 2.0;

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

    return Padding(
      padding: const EdgeInsets.only(bottom: _bottomSpacing),
      child: Row(
        children: [
          PersonaAvatar(persona: persona),
          const SizedBox(width: _pictureNameSpacing),
          Text(persona.name, style: nameStyle),
        ],
      ),
    );
  }
}
