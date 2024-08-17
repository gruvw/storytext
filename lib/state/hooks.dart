import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";

T useListenableState<T extends ChangeNotifier>(T data) {
  final state = useState<T>(data);
  return useListenable(state.value);
}
