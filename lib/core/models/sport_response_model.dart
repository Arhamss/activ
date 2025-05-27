import 'package:activ/core/models/api_response/api_response_model.dart';
import 'package:activ/core/models/api_response/base_api_response.dart';
import 'package:activ/core/models/sport_model.dart';
import 'package:activ/utils/helpers/logger_helper.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class SportsResponseModel extends Equatable {
  const SportsResponseModel({
    required this.sports,
  });

  factory SportsResponseModel.fromJson(Map<String, dynamic> json) {
    return SportsResponseModel(
      sports: (json['sports'] as List<dynamic>?)
              ?.map((e) => SportModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  static ResponseModel<BaseApiResponse<SportsResponseModel>> parseResponse(
    Response response,
  ) {
    AppLogger.info('response.data: ${response.data}');
    return ResponseModel.fromApiResponse<BaseApiResponse<SportsResponseModel>>(
      response,
      (json) => BaseApiResponse<SportsResponseModel>.fromJson(
        json,
        SportsResponseModel.fromJson,
      ),
    );
  }

  final List<SportModel> sports;

  SportsResponseModel copyWith({
    List<SportModel>? sports,
  }) {
    return SportsResponseModel(
      sports: sports ?? this.sports,
    );
  }

  @override
  List<Object?> get props => [
        sports,
      ];
}
