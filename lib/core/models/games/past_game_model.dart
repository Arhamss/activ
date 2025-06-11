import 'package:activ/core/models/games/game_model.dart';
import 'package:equatable/equatable.dart';

class PastGameModel extends Equatable {
  const PastGameModel({
    required this.id,
    required this.address,
    required this.sport,
    required this.datetime,
    required this.level,
    required this.ownerHasRatedUsers,
    required this.owner,
    required this.name,
    required this.feeCents,
  });

  factory PastGameModel.fromJson(Map<String, dynamic> json) {
    return PastGameModel(
      id: json['id'] as String,
      address: json['address'] as String,
      sport: json['sport'] as String,
      datetime: DateTime.parse(json['datetime'] as String),
      level: json['level'] as String,
      ownerHasRatedUsers: json['ownerHasRatedUsers'] as bool,
      owner: GameOwner.fromJson(json['owner'] as Map<String, dynamic>),
      name: json['name'] as String,
      feeCents: json['feeCents'] as int,
    );
  }

  final String id;
  final String address;
  final String sport;
  final DateTime datetime;
  final String level;
  final bool ownerHasRatedUsers;
  final GameOwner owner;
  final String name;
  final int feeCents;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'address': address,
      'sport': sport,
      'datetime': datetime.toIso8601String(),
      'level': level,
      'ownerHasRatedUsers': ownerHasRatedUsers,
      'owner': owner.toJson(),
      'name': name,
      'feeCents': feeCents,
    };
  }

  PastGameModel copyWith({
    String? id,
    String? address,
    String? sport,
    DateTime? datetime,
    String? level,
    bool? ownerHasRatedUsers,
    GameOwner? owner,
    String? name,
    int? feeCents,
  }) {
    return PastGameModel(
      id: id ?? this.id,
      address: address ?? this.address,
      sport: sport ?? this.sport,
      datetime: datetime ?? this.datetime,
      level: level ?? this.level,
      ownerHasRatedUsers: ownerHasRatedUsers ?? this.ownerHasRatedUsers,
      owner: owner ?? this.owner,
      name: name ?? this.name,
      feeCents: feeCents ?? this.feeCents,
    );
  }

  @override
  List<Object?> get props => [
        id,
        address,
        sport,
        datetime,
        level,
        ownerHasRatedUsers,
        owner,
        name,
        feeCents,
      ];
}
