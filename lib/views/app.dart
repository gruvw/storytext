import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:storytext/views/navigation/routes.dart";

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: "StoryText",
        onGenerateRoute: generateRoute,
        initialRoute: Routes.overview.name,
      ),
    );
  }
}
