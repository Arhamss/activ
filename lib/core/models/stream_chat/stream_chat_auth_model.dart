import 'package:equatable/equatable.dart';

class StreamChatAuthModel extends Equatable {
  const StreamChatAuthModel({
    required this.token,
    required this.userId,
    required this.apiKey,
  });

  factory StreamChatAuthModel.fromJson(Map<String, dynamic> json) {
    return StreamChatAuthModel(
      token: json['token'] as String,
      userId: json['userId'] as String,
      apiKey: json['apiKey'] as String,
    );
  }

  final String token;
  final String userId;
  final String apiKey;

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'userId': userId,
      'apiKey': apiKey,
    };
  }

  StreamChatAuthModel copyWith({
    String? token,
    String? userId,
    String? apiKey,
  }) {
    return StreamChatAuthModel(
      token: token ?? this.token,
      userId: userId ?? this.userId,
      apiKey: apiKey ?? this.apiKey,
    );
  }

  @override
  List<Object?> get props => [
        token,
        userId,
        apiKey,
      ];
}
