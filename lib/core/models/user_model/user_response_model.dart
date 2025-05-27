import 'package:activ/core/models/api_response/api_response_model.dart';
import 'package:activ/core/models/api_response/base_api_response.dart';
import 'package:activ/core/models/sport_model.dart';
import 'package:activ/core/models/user_model/user_model.dart';
import 'package:activ/utils/helpers/logger_helper.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class UserResponseModel extends Equatable {
  const UserResponseModel({
    required this.user,
  });

  factory UserResponseModel.fromJson(Map<String, dynamic> json) {
    return UserResponseModel(
      user: UserModel.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  static ResponseModel<BaseApiResponse<UserResponseModel>> parseResponse(
    Response response,
  ) {
    AppLogger.info('response.data: ${response.data}');
    return ResponseModel.fromApiResponse<BaseApiResponse<UserResponseModel>>(
      response,
      (json) => BaseApiResponse<UserResponseModel>.fromJson(
        json,
        UserResponseModel.fromJson,
      ),
    );
  }

  final UserModel user;

  UserResponseModel copyWith({
    UserModel? user,
  }) {
    return UserResponseModel(
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [
        user,
      ];
}
