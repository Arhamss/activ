import 'package:activ/core/models/api_response/api_response_model.dart';
import 'package:activ/core/models/api_response/base_api_response.dart';
import 'package:activ/core/models/chats/chat_model.dart';
import 'package:activ/core/models/games/game_model.dart';
import 'package:activ/core/models/games/past_game_model.dart';
import 'package:activ/utils/helpers/logger_helper.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class PastGameResponseModel extends Equatable {
  const PastGameResponseModel({
    required this.games,
  });

  factory PastGameResponseModel.fromJson(Map<String, dynamic> json) {
    AppLogger.info('PastGameResponseModel: $json');
    return PastGameResponseModel(
      games: (json['games'] as List<dynamic>?)
              ?.map(
                (gameJson) =>
                    PastGameModel.fromJson(gameJson as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
  }

  static ResponseModel<BaseApiResponse<PastGameResponseModel>> parseResponse(
    Response response,
  ) {
    return ResponseModel.fromApiResponse<
        BaseApiResponse<PastGameResponseModel>>(
      response,
      (json) => BaseApiResponse<PastGameResponseModel>.fromJson(
        json,
        PastGameResponseModel.fromJson,
      ),
    );
  }

  final List<PastGameModel> games;

  PastGameResponseModel copyWith({
    List<PastGameModel>? games,
  }) {
    return PastGameResponseModel(
      games: games ?? this.games,
    );
  }

  @override
  List<Object?> get props => [
        games,
      ];
}
