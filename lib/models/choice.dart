import "package:storytext/models/message.dart";
import "package:storytext/static/keys.dart";
import "package:yaml/yaml.dart";

class Choice {
  final String answer;
  final MessageId next;

  Choice({
    required this.answer,
    required this.next,
  });

  factory Choice.fromMap(YamlMap choice) {
    return Choice(
      answer: choice[YamlKeys.mcqAnswer],
      next: choice[YamlKeys.mcqNext],
    );
  }

  static List<Choice>? fromMcq(YamlList? mcq) {
    return mcq?.map((choice) => Choice.fromMap(choice)).toList();
  }
}

extension FindChoice on List<Choice> {
  Choice withNext(MessageId next) => where((c) => c.next == next).first;
}
