import 'package:equatable/equatable.dart';

class PastGameModel extends Equatable {
  const PastGameModel({
    required this.id,
    required this.address,
    required this.sport,
    required this.datetime,
    required this.level,
    required this.hasRatedUsers,
  });

  factory PastGameModel.fromJson(Map<String, dynamic> json) {
    return PastGameModel(
      id: json['id'] as String,
      address: json['address'] as String,
      sport: json['sport'] as String,
      datetime: DateTime.parse(json['datetime'] as String),
      level: json['level'] as String,
      hasRatedUsers: json['ownerHasRatedUsers'] as bool,
    );
  }

  final String id;
  final String address;
  final String sport;
  final DateTime datetime;
  final String level;
  final bool hasRatedUsers;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'address': address,
      'sport': sport,
      'datetime': datetime.toIso8601String(),
      'level': level,
    };
  }

  PastGameModel copyWith({
    String? id,
    String? address,
    String? sport,
    DateTime? datetime,
    String? level,
    bool? hasRastedUsers,
  }) {
    return PastGameModel(
      id: id ?? this.id,
      address: address ?? this.address,
      sport: sport ?? this.sport,
      datetime: datetime ?? this.datetime,
      level: level ?? this.level,
      hasRatedUsers: hasRastedUsers ?? this.hasRatedUsers,
    );
  }

  @override
  List<Object?> get props => [
        id,
        address,
        sport,
        datetime,
        level,
        hasRatedUsers,
      ];
}
