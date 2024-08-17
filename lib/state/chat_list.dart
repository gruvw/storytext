import "package:flutter/foundation.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:storytext/models/choice.dart";
import "package:storytext/models/message.dart";
import "package:storytext/static/keys.dart";
import "package:storytext/static/message_duration.dart";
import "package:yaml/yaml.dart";

/// Observable, range resettable, cached, multi-parent,
/// path persisted, linked list data structure
class ChatList with ChangeNotifier {
  static const _choiceSuffix = "-2fH2yo";

  final YamlMap setupDoc;
  final YamlMap storyDoc;

  // persistent storage
  final SharedPreferences _sp;

  // cached linked message ids, newest first
  final List<MessageId> _messageIds;

  ChatList._({
    required this.setupDoc,
    required this.storyDoc,
    required SharedPreferences sp,
  })  : _sp = sp,
        _messageIds = [];

  static Future<ChatList> create({
    required YamlMap setupDoc,
    required YamlMap storyDoc,
  }) async {
    final sp = await SharedPreferences.getInstance();
    final chatList = ChatList._(setupDoc: setupDoc, storyDoc: storyDoc, sp: sp);

    final spHeadValue = chatList._sp.getString(SharedPreferencesKeys.head);
    final firstMessageId = storyDoc.entries.first.key;
    final head = spHeadValue ?? firstMessageId;
    if (spHeadValue == null) {
      await chatList._sp.setStringList(firstMessageId, []);
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
      final parents = _sp.getStringList(current)!;
      if (parents.isEmpty) {
        return null;
      }
      _messageIds.add(parents.first);
      ++currentIndex;
    }

    return _messageIds[index];
  }

  Future<void> setChoice(MessageId messageId, MessageId nextId) async {
    await _sp.setString(messageId + _choiceSuffix, nextId);

    notifyListeners();

    await scheduleMsg(nextId);
  }

  MessageId? getChosenPath(MessageId messageId) {
    return _sp.getString(messageId + _choiceSuffix);
  }

  bool isMessageExplored(MessageId messageId) {
    return _sp.containsKey(messageId);
  }

  Future<void> _persistHead() async {
    await _sp.setString(SharedPreferencesKeys.head, _messageIds.first);
  }

  Future<void> _scheduleNext() async {
    final message = Message.fromDocument(storyDoc, head);

    // last interaction requiring scheduling
    // was either an MCQ answer or next message
    final mcqPath = getChosenPath(head);
    final nextId = mcqPath ?? message.next;

    if (nextId != null) {
      await scheduleMsg(nextId);
    }
  }

  Duration _messageDuration(String? messageText) {
    return messageText != null ? durationFromText(messageText) : pictureDelay;
  }

  Future<void> scheduleMsg(MessageId id) async {
    // TODO if already explored don't wait ?

    // time for receiving persona to read
    // read wait either on head text when it has next message
    // or on selected answer when it was MCQ
    final headMessage = Message.fromDocument(storyDoc, head);
    final mcqPath = getChosenPath(head);
    final readMessage = mcqPath == null
        ? headMessage.text
        : headMessage.mcq!.withNext(mcqPath).answer;
    await Future.delayed(_messageDuration(readMessage));

    // time for replying persona to write
    // TODO apply typing indicator for replying persona
    final writeMessage = Message.fromDocument(storyDoc, id);
    await Future.delayed(_messageDuration(writeMessage.text));

    write(id);
  }

  Future<void> clearFrom(int index) async {
    _messageIds.removeRange(0, index);
    await _persistHead();
    notifyListeners();
  }

  Future<void> write(MessageId messageId) async {
    final parent = _messageIds.first;
    final currentParents = _sp.getStringList(messageId) ?? [];

    currentParents.remove(parent);
    currentParents.insert(0, parent);
    await _sp.setStringList(messageId, currentParents);

    _messageIds.insert(0, messageId);

    await _persistHead();
    notifyListeners();

    _scheduleNext();
  }
}
