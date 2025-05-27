import 'package:activ/core/models/api_response/api_response_model.dart';
import 'package:activ/core/models/api_response/base_api_response.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class AuthData extends Equatable {
  const AuthData({
    required this.id,
    required this.refreshToken,
    required this.email,
    required this.token,
  });
  factory AuthData.fromJson(Map<String, dynamic> json) {
    return AuthData(
      id: json['id'] as String,
      refreshToken: json['refreshToken'] as String,
      email: json['email'] as String,
      token: json['accessToken'] as String,
    );
  }

  static ResponseModel<BaseApiResponse<AuthData>> parseResponse(
    Response response,
  ) {
    return ResponseModel.fromApiResponse<BaseApiResponse<AuthData>>(
      response,
      (json) => BaseApiResponse<AuthData>.fromJson(json, AuthData.fromJson),
    );
  }

  final String id;
  final String refreshToken;
  final String email;
  final String token;

  Map<String, dynamic> toJson() => {
        'id': id,
        'refreshToken': refreshToken,
        'email': email,
        'accessToken': token,
      };

  AuthData copyWith({
    String? id,
    String? refreshToken,
    String? email,
    String? token,
  }) {
    return AuthData(
      id: id ?? this.id,
      refreshToken: refreshToken ?? this.refreshToken,
      email: email ?? this.email,
      token: token ?? this.token,
    );
  }

  @override
  List<Object?> get props => [id, refreshToken, email, token];
}
