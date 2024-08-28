import "package:flutter/material.dart";
import "package:storytext/static/styles.dart";
import "package:storytext/static/values.dart";
import "package:storytext/views/navigation/routes.dart";

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Values.applicationTitle,
      theme: ThemeData(
        fontFamily: "Noto",
        colorSchemeSeed: Styles.answerBubbleColor,
      ),
      onGenerateRoute: generateRoute,
      initialRoute: Routes.chat.name,
    );
  }
}
