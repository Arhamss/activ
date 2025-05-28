import 'package:equatable/equatable.dart';

class NotificationPreferences extends Equatable {
  const NotificationPreferences({
    required this.gameInvites,
    required this.messages,
  });

  factory NotificationPreferences.fromJson(Map<String, dynamic> json) {
    return NotificationPreferences(
      gameInvites: json['gameInvites'] as bool,
      messages: json['messages'] as bool,
    );
  }

  final bool gameInvites;
  final bool messages;

  Map<String, dynamic> toJson() => {
        'gameInvites': gameInvites,
        'messages': messages,
      };

  @override
  List<Object?> get props => [gameInvites, messages];
}
