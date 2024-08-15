import "package:flutter/foundation.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:storytext/models/message.dart";
import "package:storytext/static/keys.dart";
import "package:storytext/static/msg_delay.dart";
import "package:yaml/yaml.dart";

class ChatList with ChangeNotifier {
  final YamlMap setupDoc;
  final YamlMap storyDoc;
  final SharedPreferences sp;

  final List<MessageId> _messageIds; // newest first

  ChatList._({
    required this.setupDoc,
    required this.storyDoc,
    required this.sp,
  }) : _messageIds = [];

  static Future<ChatList> create({
    required YamlMap setupDoc,
    required YamlMap storyDoc,
  }) async {
    final sp = await SharedPreferences.getInstance();
    final chatList = ChatList._(setupDoc: setupDoc, storyDoc: storyDoc, sp: sp);

    final spHeadValue = chatList.sp.getString(SharedPreferencesKeys.head);
    final firstMessageId = storyDoc.entries.first.key;
    final head = spHeadValue ?? firstMessageId;
    if (spHeadValue == null) {
      await chatList.sp.setStringList(firstMessageId, []);
    }

    chatList._messageIds.add(head);
    await chatList._persistHead();

    chatList._scheduleNext();

    return chatList;
  }

  MessageId get head => _messageIds.first;

  MessageId? getMessageIdAt(int index) {
    var currentIndex = _messageIds.length - 1;
    while (index > currentIndex) {
      final current = _messageIds[currentIndex];
      final parents = sp.getStringList(current)!;
      if (parents.isEmpty) {
        return null;
      }
      _messageIds.add(parents.first);
      ++currentIndex;
    }

    return _messageIds[index];
  }

  Future<void> _persistHead() async {
    await sp.setString(SharedPreferencesKeys.head, _messageIds.first);
  }

  Future<void> _scheduleNext() async {
    final message = Message.fromDocument(storyDoc, head);
    final nextId = message.next;
    if (nextId != null) {
      await scheduleMsg(nextId);
    }
  }

  Future<void> scheduleMsg(MessageId id) async {
    final nextMessage = Message.fromDocument(storyDoc, id);
    final nextText = nextMessage.text;

    // TODO if already discovered don't wait ?
    final delay = nextText != null ? delayFromText(nextText) : pictureDelay;
    await Future.delayed(delay);

    write(id);
  }

  Future<void> clearFrom(int index) async {
    _messageIds.removeRange(0, index);
    await _persistHead();
    notifyListeners();
  }

  Future<void> write(MessageId messageId) async {
    final parent = _messageIds.first;
    final currentParents = sp.getStringList(messageId) ?? [];

    currentParents.remove(parent);
    currentParents.insert(0, parent);
    await sp.setStringList(messageId, currentParents);

    _messageIds.insert(0, messageId);

    await _persistHead();
    notifyListeners();

    _scheduleNext();
  }
}
