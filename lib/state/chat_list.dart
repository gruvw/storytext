import "package:flutter/foundation.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:storytext/models/choice.dart";
import "package:storytext/models/message.dart";
import "package:storytext/models/persona.dart";
import "package:storytext/static/keys.dart";
import "package:storytext/static/message_duration.dart";
import "package:storytext/utils/dart.dart";
import "package:yaml/yaml.dart";

/// Observable, range resettable, cached, multi-parent,
/// path persisted, schedulable dispatch, linked list data structure
class ChatList with ChangeNotifier {
  static const _choiceSuffix = "-2fH2yo";

  // persistent storage
  final SharedPreferences _sp;

  // cached linked message ids, newest first
  final List<MessageId> _messageIds;

  Future<void>? _scheduledMessage;
  bool _cancelled = false;
  bool get cancelled => _cancelled;

  final YamlMap setupDoc;
  final YamlMap storyDoc;

  Persona? _typingPersona;
  Persona? get typingPersona => _typingPersona;

  ChatList._({
    required this.setupDoc,
    required this.storyDoc,
    required SharedPreferences sp,
  })  : _sp = sp,
        _messageIds = [],
        _typingPersona = null;

  static Future<ChatList> create({
    required YamlMap setupDoc,
    required YamlMap storyDoc,
  }) async {
    final sp = await SharedPreferences.getInstance();
    final chatList = ChatList._(setupDoc: setupDoc, storyDoc: storyDoc, sp: sp);

    final spHeadValue = chatList._sp.getString(SharedPreferencesKeys.head);
    if (spHeadValue == null) {
      // empty state, first launch
      chatList.scheduleAsRoot(chatList.storyRoot);
    } else {
      chatList._messageIds.add(spHeadValue);
      await chatList._persistHead();

      chatList._scheduleNext();
    }

    return chatList;
  }

  MessageId get storyRoot => storyDoc.entries.first.key;
  bool get isEmpty => _messageIds.isEmpty;
  bool get isNotEmpty => !isEmpty;
  MessageId get head => _messageIds.first;

  MessageId? getMessageIdAt(int index) {
    var currentIndex = _messageIds.length - 1;
    if (currentIndex < 0) {
      return null;
    }

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
    final mcqIndex = _messageIds.indexOf(messageId);
    if (mcqIndex != -1) {
      _clearSince(mcqIndex);
    }

    await _sp.setString(messageId + _choiceSuffix, nextId);

    notifyListeners();

    if (mcqIndex != -1) {
      _scheduleNext();
    }
  }

  MessageId? getChosenPath(MessageId messageId) {
    return _sp.getString(messageId + _choiceSuffix);
  }

  bool isMessageExplored(MessageId messageId) {
    return _sp.containsKey(messageId);
  }

  Future<void> scheduleAsRoot(MessageId firstId) async {
    // cancel further scheduling, break messages scheduling chain
    _cancelled = true;
    notifyListeners();
    await _scheduledMessage;
    _cancelled = false;

    // reset state
    await _sp.clear();
    _messageIds.clear();

    // root has no parent, set to empty list
    await _sp.setStringList(firstId, []);

    await _scheduleWrite(firstId);
  }

  Future<void> _persistHead() async {
    await _sp.setString(SharedPreferencesKeys.head, head);
  }

  Future<void> _scheduleMessage(MessageId id) async {
    // TODO if already explored don't wait ?

    // time for receiving persona to read
    // read wait either on head text when it has next message
    // or on selected answer when it was MCQ
    final headMessage = Message.fromDocument(storyDoc, head);
    final mcqPath = getChosenPath(head);
    final readMessage = mcqPath == null
        ? headMessage.text
        : headMessage.mcq!.withNext(mcqPath).answer;
    await Future.delayed(
      _messageDuration(
        messageText: readMessage,
        hasImage: mcqPath == null && headMessage.image != null,
      ),
    );

    await _scheduleWrite(id);
  }

  Future<void> _scheduleNext() async {
    final message = Message.fromDocument(storyDoc, head);

    // last interaction requiring scheduling
    // was either an MCQ answer or next message
    final mcqPath = getChosenPath(head);
    final scheduleMessageId = mcqPath ?? message.next;

    // schedule next message
    scheduleMessageId.nMap((m) {
      _scheduledMessage = _scheduleMessage(m);
    });
  }

  Duration _messageDuration({
    required String? messageText,
    required bool hasImage,
  }) {
    final textDelay = messageText.nMap(
          (t) => durationFromText(t),
        ) ??
        Duration.zero;
    final imgDelay = hasImage ? imageDelay : Duration.zero;
    return textDelay + imgDelay;
  }

  Future<void> _scheduleWrite(MessageId id) async {
    final writeMessage = Message.fromDocument(storyDoc, id);

    // apply typing indicator for replying persona
    _typingPersona = Persona.fromDocument(
      setupDoc,
      writeMessage.personaId,
    );
    notifyListeners();

    // time for replying persona to write
    await Future.delayed(
      _messageDuration(
        messageText: writeMessage.text,
        hasImage: writeMessage.image != null,
      ),
    );

    if (_cancelled) {
      return;
    }

    await _write(id);
  }

  Future<void> _clearSince(int index) async {
    _messageIds.removeRange(0, index);
    await _persistHead();
    notifyListeners();
  }

  Future<void> _write(MessageId messageId) async {
    final activeParent = _messageIds.firstOrNull;
    final currentParents = _sp.getStringList(messageId) ?? [];

    if (activeParent != null) {
      // set active parent, top of the list
      currentParents.remove(activeParent);
      currentParents.insert(0, activeParent);
    }
    await _sp.setStringList(messageId, currentParents);

    _messageIds.insert(0, messageId);
    await _persistHead();

    _typingPersona = null;

    notifyListeners();

    _scheduleNext();
  }
}
