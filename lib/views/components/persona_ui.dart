import "package:flutter/material.dart";
import "package:storytext/models/persona.dart";
import "package:storytext/state/chat_list.dart";

class PersonaUI extends StatelessWidget {
  static const _personasAssetsPath = "images/personas/";

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
        CircleAvatar(
          foregroundImage: AssetImage(_personasAssetsPath + persona.picture),
          child: Text(persona.name[0]),
        ),
        Text(persona.name),
      ],
    );
  }
}
