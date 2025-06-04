import 'package:equatable/equatable.dart';

class ChatModel extends Equatable {
  const ChatModel({
    required this.id,
    required this.name,
    required this.gameId,
    required this.gameAddress,
    required this.gameSport,
    required this.gameDatetime,
    required this.memberCount,
    required this.unreadCount,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'] as String,
      name: json['name'] as String,
      gameId: json['gameId'] as String,
      gameAddress: json['gameAddress'] as String,
      gameSport: json['gameSport'] as String,
      gameDatetime: DateTime.parse(json['gameDatetime'] as String),
      memberCount: json['memberCount'] as int,
      unreadCount: json['unreadCount'] as int,
    );
  }
  final String id;
  final String name;
  final String gameId;
  final String gameAddress;
  final String gameSport;
  final DateTime gameDatetime;
  final int memberCount;
  final int unreadCount;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'gameId': gameId,
      'gameAddress': gameAddress,
      'gameSport': gameSport,
      'gameDatetime': gameDatetime.toIso8601String(),
      'memberCount': memberCount,
      'unreadCount': unreadCount,
    };
  }

  ChatModel copyWith({
    String? id,
    String? name,
    String? gameId,
    String? gameAddress,
    String? gameSport,
    DateTime? gameDatetime,
    int? memberCount,
    int? unreadCount,
  }) {
    return ChatModel(
      id: id ?? this.id,
      name: name ?? this.name,
      gameId: gameId ?? this.gameId,
      gameAddress: gameAddress ?? this.gameAddress,
      gameSport: gameSport ?? this.gameSport,
      gameDatetime: gameDatetime ?? this.gameDatetime,
      memberCount: memberCount ?? this.memberCount,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        gameId,
        gameAddress,
        gameSport,
        gameDatetime,
        memberCount,
        unreadCount,
      ];
}
