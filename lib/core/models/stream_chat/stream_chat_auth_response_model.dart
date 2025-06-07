import 'package:activ/core/models/api_response/api_response_model.dart';
import 'package:activ/core/models/api_response/base_api_response.dart';
import 'package:activ/core/models/stream_chat/stream_chat_auth_model.dart';
import 'package:activ/utils/helpers/logger_helper.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class StreamChatAuthResponseModel extends Equatable {
  const StreamChatAuthResponseModel({
    required this.streamChatAuth,
  });

  factory StreamChatAuthResponseModel.fromJson(Map<String, dynamic> json) {
    AppLogger.info('StreamChatAuthResponseModel: $json');
    return StreamChatAuthResponseModel(
      streamChatAuth: StreamChatAuthModel.fromJson(json),
    );
  }

  static ResponseModel<BaseApiResponse<StreamChatAuthResponseModel>>
      parseResponse(
    Response response,
  ) {
    return ResponseModel.fromApiResponse<
        BaseApiResponse<StreamChatAuthResponseModel>>(
      response,
      (json) => BaseApiResponse<StreamChatAuthResponseModel>.fromJson(
        json,
        StreamChatAuthResponseModel.fromJson,
      ),
    );
  }

  final StreamChatAuthModel streamChatAuth;

  StreamChatAuthResponseModel copyWith({
    StreamChatAuthModel? streamChatAuth,
  }) {
    return StreamChatAuthResponseModel(
      streamChatAuth: streamChatAuth ?? this.streamChatAuth,
    );
  }

  @override
  List<Object?> get props => [
        streamChatAuth,
      ];
}
