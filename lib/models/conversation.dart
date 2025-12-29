import 'package:equatable/equatable.dart';

class Conversation extends Equatable {
  final String id;
  final String title;
  final String lastMessage;
  final DateTime lastMessageTime;
  final int unreadCount;
  final List<String> participantIds;
  final String? avatarUrl;

  const Conversation({
    required this.id,
    required this.title,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.unreadCount,
    required this.participantIds,
    this.avatarUrl,
  });

  /// Creates a copy of this conversation with the given fields replaced with new values
  Conversation copyWith({
    String? id,
    String? title,
    String? lastMessage,
    DateTime? lastMessageTime,
    int? unreadCount,
    List<String>? participantIds,
    String? avatarUrl,
  }) {
    return Conversation(
      id: id ?? this.id,
      title: title ?? this.title,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      unreadCount: unreadCount ?? this.unreadCount,
      participantIds: participantIds ?? this.participantIds,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  /// Creates a Conversation from a JSON map
  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      id: json['id'] as String,
      title: json['title'] as String,
      lastMessage: json['lastMessage'] as String,
      lastMessageTime: DateTime.parse(json['lastMessageTime'] as String),
      unreadCount: json['unreadCount'] as int,
      participantIds: List<String>.from(json['participantIds'] as List),
      avatarUrl: json['avatarUrl'] as String?,
    );
  }

  /// Converts this Conversation to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime.toIso8601String(),
      'unreadCount': unreadCount,
      'participantIds': participantIds,
      'avatarUrl': avatarUrl,
    };
  }

  @override
  List<Object?> get props => [
    id,
    title,
    lastMessage,
    lastMessageTime,
    unreadCount,
    participantIds,
    avatarUrl,
  ];

  @override
  String toString() {
    return 'Conversation(id: $id, title: $title, lastMessage: $lastMessage, '
        'lastMessageTime: $lastMessageTime, unreadCount: $unreadCount, '
        'participantIds: $participantIds, avatarUrl: $avatarUrl)';
  }
}
