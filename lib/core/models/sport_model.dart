import 'package:activ/core/models/api_response/api_response_model.dart';
import 'package:activ/core/models/api_response/base_api_response.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class SportModel extends Equatable {
  const SportModel({
    required this.id,
    required this.name,
    required this.iconUrl,
    required this.illustrationUrl,
  });

  factory SportModel.fromJson(Map<String, dynamic> json) {
    return SportModel(
      id: json['id'] as String,
      name: json['name'] as String,
      iconUrl: json['iconUrl'] as String,
      illustrationUrl: json['illustrationUrl'] as String,
    );
  }

  static ResponseModel<BaseApiResponse<List<SportModel>>> parseResponse(
      Response response) {
    return ResponseModel.fromApiResponse<BaseApiResponse<List<SportModel>>>(
      response,
      (json) => BaseApiResponse<List<SportModel>>.fromJson(
        json,
        (data) => (data as List)
            .map((e) => SportModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
    );
  }

  final String id;
  final String name;
  final String iconUrl;
  final String illustrationUrl;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'iconUrl': iconUrl,
        'illustrationUrl': illustrationUrl,
      };

  SportModel copyWith({
    String? id,
    String? name,
    String? iconUrl,
    String? illustrationUrl,
  }) {
    return SportModel(
      id: id ?? this.id,
      name: name ?? this.name,
      iconUrl: iconUrl ?? this.iconUrl,
      illustrationUrl: illustrationUrl ?? this.illustrationUrl,
    );
  }

  @override
  List<Object?> get props => [id, name, iconUrl, illustrationUrl];

  @override
  String toString() => 'Sport(id: $id, name: $name)';
}
