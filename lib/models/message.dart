import "package:storytext/models/choice.dart";
import "package:storytext/models/persona.dart";
import "package:storytext/static/keys.dart";
import "package:yaml/yaml.dart";

typedef MessageId = String;

class Message {
  final PersonaId personaId;
  final String? text;
  final String? picture;
  final String? next;
  final List<Choice>? mcq;

  Message({
    required this.personaId,
    required this.text,
    required this.picture,
    required this.next,
    required this.mcq,
  });

  factory Message.fromMap(YamlMap message) {
    return Message(
      personaId: message[YamlKeys.msgPersona],
      text: message[YamlKeys.msgText],
      picture: message[YamlKeys.msgPicture],
      next: message[YamlKeys.msgNext],
      mcq: Choice.fromMcq(message[YamlKeys.msgMcq]),
    );
  }

  factory Message.fromDocument(YamlMap document, MessageId id) {
    return Message.fromMap(document[id]);
  }
}
