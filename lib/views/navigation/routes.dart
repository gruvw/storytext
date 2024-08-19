import "package:flutter/material.dart";
import "package:storytext/views/routes/chat/chat_page.dart";

enum Routes {
  chat("chat");

  final String name;

  const Routes(this.name);

  static Routes parse(String name) {
    return Routes.values.firstWhere((r) => r.name == name);
  }

  Widget page(Object? args) {
    switch (this) {
      case chat:
        return const ChatPage();
    }
  }
}

Route generateRoute(RouteSettings settings) {
  final route = Routes.parse(settings.name ?? Routes.chat.name);
  return MaterialPageRoute(builder: (_) => route.page(settings.arguments));
}
