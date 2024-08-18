import "package:flutter/material.dart";
import "package:storytext/models/persona.dart";

class PersonaAvatar extends StatelessWidget {
  static const _personasAssetsPath = "images/personas/";

  final Persona persona;

  const PersonaAvatar({
    super.key,
    required this.persona,
  });

  @override
  Widget build(BuildContext context) {
    final imagePath = _personasAssetsPath + persona.picture;

    return CircleAvatar(
      foregroundImage: AssetImage(imagePath),
      child: Text(persona.name[0]),
    );
  }
}
