import 'package:activ/core/models/api_response/api_response_model.dart';
import 'package:activ/core/models/api_response/base_api_response.dart';
import 'package:activ/core/models/chats/chat_model.dart';
import 'package:activ/utils/helpers/logger_helper.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class ChatResponseModel extends Equatable {
  const ChatResponseModel({
    required this.chats,
  });

  factory ChatResponseModel.fromJson(Map<String, dynamic> json) {
    AppLogger.info('ChatResponseModel: $json');
    return ChatResponseModel(
      chats: (json['channels'] as List<dynamic>?)
              ?.map(
                (chatJson) =>
                    ChatModel.fromJson(chatJson as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
  }

  static ResponseModel<BaseApiResponse<ChatResponseModel>> parseResponse(
    Response response,
  ) {
    return ResponseModel.fromApiResponse<BaseApiResponse<ChatResponseModel>>(
      response,
      (json) => BaseApiResponse<ChatResponseModel>.fromJson(
        json,
        ChatResponseModel.fromJson,
      ),
    );
  }

  final List<ChatModel> chats;

  ChatResponseModel copyWith({
    List<ChatModel>? chats,
  }) {
    return ChatResponseModel(
      chats: chats ?? this.chats,
    );
  }

  @override
  List<Object?> get props => [
        chats,
      ];
}
