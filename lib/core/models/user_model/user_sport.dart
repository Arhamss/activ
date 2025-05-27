import 'package:equatable/equatable.dart';

class UserSport extends Equatable {
  const UserSport({
    required this.sport,
    required this.rating,
    required this.id,
  });

  factory UserSport.fromJson(Map<String, dynamic> json) {
    return UserSport(
      sport: Sport.fromJson(json['sport'] as Map<String, dynamic>),
      rating: json['rating'] as int,
      id: json['id'] as String,
    );
  }

  final Sport sport;
  final int rating;
  final String id;

  Map<String, dynamic> toJson() => {
        'sport': sport.toJson(),
        'rating': rating,
        'id': id,
      };

  @override
  List<Object?> get props => [sport, rating, id];
}

class Sport extends Equatable {
  const Sport({
    required this.id,
    required this.name,
    required this.svgUrl,
  });

  factory Sport.fromJson(Map<String, dynamic> json) {
    return Sport(
      id: json['id'] as String,
      name: json['name'] as String,
      svgUrl: json['svgUrl'] as String,
    );
  }

  final String id;
  final String name;
  final String svgUrl;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'svgUrl': svgUrl,
      };

  @override
  List<Object?> get props => [id, name, svgUrl];
}