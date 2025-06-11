import 'package:equatable/equatable.dart';

class GameOwner extends Equatable {
  const GameOwner({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.imageUrl,
  });

  factory GameOwner.fromJson(Map<String, dynamic> json) {
    return GameOwner(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      imageUrl: json['imageUrl'] as String?,
    );
  }

  final String id;
  final String firstName;
  final String lastName;
  final String? imageUrl;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'imageUrl': imageUrl,
    };
  }

  @override
  List<Object?> get props => [id, firstName, lastName, imageUrl];
}

class GameModel extends Equatable {
  const GameModel({
    required this.id,
    required this.address,
    required this.sport,
    required this.datetime,
    required this.level,
    required this.maxPlayers,
    required this.currentPlayers,
    required this.feeCents,
    required this.owner,
    required this.name,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
      id: json['id'] as String,
      address: json['address'] as String,
      sport: json['sport'] as String,
      datetime: DateTime.parse(json['datetime'] as String),
      level: json['level'] as String,
      maxPlayers: json['maxPlayers'] as int,
      currentPlayers: json['currentPlayers'] as int,
      feeCents: json['feeCents'] as int,
      owner: GameOwner.fromJson(json['owner'] as Map<String, dynamic>),
      name: json['name'] as String,
    );
  }

  final String id;
  final String address;
  final String sport;
  final DateTime datetime;
  final String level;
  final int maxPlayers;
  final int currentPlayers;
  final int feeCents;
  final GameOwner owner;
  final String name;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'address': address,
      'sport': sport,
      'datetime': datetime.toIso8601String(),
      'level': level,
      'maxPlayers': maxPlayers,
      'currentPlayers': currentPlayers,
      'feeCents': feeCents,
      'owner': owner.toJson(),
      'name': name,
    };
  }

  GameModel copyWith({
    String? id,
    String? address,
    String? sport,
    DateTime? datetime,
    String? level,
    int? maxPlayers,
    int? currentPlayers,
    int? feeCents,
    GameOwner? owner,
    String? name,
  }) {
    return GameModel(
      id: id ?? this.id,
      address: address ?? this.address,
      sport: sport ?? this.sport,
      datetime: datetime ?? this.datetime,
      level: level ?? this.level,
      maxPlayers: maxPlayers ?? this.maxPlayers,
      currentPlayers: currentPlayers ?? this.currentPlayers,
      feeCents: feeCents ?? this.feeCents,
      owner: owner ?? this.owner,
      name: name ?? this.name,
    );
  }

  @override
  List<Object?> get props => [
        id,
        address,
        sport,
        datetime,
        level,
        maxPlayers,
        currentPlayers,
        feeCents,
        owner,
        name,
      ];
}
