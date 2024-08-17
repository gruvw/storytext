import "package:flutter/material.dart";
import "package:storytext/models/persona.dart";
import "package:storytext/state/chat_list.dart";

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
    // TODO persona widget with profile picture
    return Text(persona.name);
  }
}
