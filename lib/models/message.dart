import 'package:equatable/equatable.dart';

enum MessageType {
  text,
  image,
  // Future message types can be added here
}

class Message extends Equatable {
  final String id;
  final String content;
  final String senderId;
  final DateTime timestamp;
  final bool isRead;
  final MessageType type;

  const Message({
    required this.id,
    required this.content,
    required this.senderId,
    required this.timestamp,
    required this.isRead,
    this.type = MessageType.text,
  });

  /// Creates a copy of this message with the given fields replaced with new values
  Message copyWith({
    String? id,
    String? content,
    String? senderId,
    DateTime? timestamp,
    bool? isRead,
    MessageType? type,
  }) {
    return Message(
      id: id ?? this.id,
      content: content ?? this.content,
      senderId: senderId ?? this.senderId,
      timestamp: timestamp ?? this.timestamp,
      isRead: isRead ?? this.isRead,
      type: type ?? this.type,
    );
  }

  /// Creates a Message from a JSON map
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'] as String,
      content: json['content'] as String,
      senderId: json['senderId'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      isRead: json['isRead'] as bool,
      type: MessageType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => MessageType.text,
      ),
    );
  }

  /// Converts this Message to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'senderId': senderId,
      'timestamp': timestamp.toIso8601String(),
      'isRead': isRead,
      'type': type.name,
    };
  }

  @override
  List<Object?> get props => [id, content, senderId, timestamp, isRead, type];

  @override
  String toString() {
    return 'Message(id: $id, content: $content, senderId: $senderId, '
        'timestamp: $timestamp, isRead: $isRead, type: $type)';
  }
}
