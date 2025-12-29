import 'package:equatable/equatable.dart';

class Contact extends Equatable {
  final String id;
  final String name;
  final String? avatarUrl;
  final bool isOnline;

  const Contact({
    required this.id,
    required this.name,
    this.avatarUrl,
    required this.isOnline,
  });

  /// Creates a copy of this contact with the given fields replaced with new values
  Contact copyWith({
    String? id,
    String? name,
    String? avatarUrl,
    bool? isOnline,
  }) {
    return Contact(
      id: id ?? this.id,
      name: name ?? this.name,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isOnline: isOnline ?? this.isOnline,
    );
  }

  /// Creates a Contact from a JSON map
  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'] as String,
      name: json['name'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      isOnline: json['isOnline'] as bool,
    );
  }

  /// Converts this Contact to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'avatarUrl': avatarUrl,
      'isOnline': isOnline,
    };
  }

  @override
  List<Object?> get props => [id, name, avatarUrl, isOnline];

  @override
  String toString() {
    return 'Contact(id: $id, name: $name, avatarUrl: $avatarUrl, isOnline: $isOnline)';
  }
}
