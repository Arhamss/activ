import 'package:activ/core/models/api_response/api_response_model.dart';
import 'package:activ/core/models/api_response/base_api_response.dart';
import 'package:activ/core/models/chats/chat_model.dart';
import 'package:activ/core/models/games/game_model.dart';
import 'package:activ/utils/helpers/logger_helper.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class GameResponseModel extends Equatable {
  const GameResponseModel({
    required this.games,
  });

  factory GameResponseModel.fromJson(Map<String, dynamic> json) {
    AppLogger.info('GameResponseModel: $json');
    return GameResponseModel(
      games: (json['games'] as List<dynamic>?)
              ?.map(
                (gameJson) =>
                    GameModel.fromJson(gameJson as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
  }

  static ResponseModel<BaseApiResponse<GameResponseModel>> parseResponse(
    Response response,
  ) {
    return ResponseModel.fromApiResponse<BaseApiResponse<GameResponseModel>>(
      response,
      (json) => BaseApiResponse<GameResponseModel>.fromJson(
        json,
        GameResponseModel.fromJson,
      ),
    );
  }

  final List<GameModel> games;

  GameResponseModel copyWith({
    List<GameModel>? games,
  }) {
    return GameResponseModel(
      games: games ?? this.games,
    );
  }

  @override
  List<Object?> get props => [
        games,
      ];
}
