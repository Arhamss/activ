import 'package:activ/utils/helpers/logger_helper.dart';
import 'package:equatable/equatable.dart';

class UserSport extends Equatable {
  const UserSport({
    required this.id,
    required this.name,
    required this.rating,
    required this.totalRatings,
    required this.averageRating,
  });

  factory UserSport.fromJson(Map<String, dynamic> json) {
    try {
      return UserSport(
        id: json['id'] as String,
        name: json['name'] as String,
        rating: json['rating'] as int,
        totalRatings: json['totalRatings'] as int,
        averageRating: AverageRating.fromJson(
          json['averageRating'] as Map<String, dynamic>,
        ),
      );
    } catch (e, s) {
      AppLogger.error('Error parsing UserSport: ', e, s);
      throw Exception(e);
    }
  }

  final String id;
  final String name;
  final int rating;
  final int totalRatings;
  final AverageRating averageRating;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'rating': rating,
        'totalRatings': totalRatings,
        'averageRating': averageRating.toJson(),
      };

  @override
  List<Object?> get props => [id, name, rating, totalRatings, averageRating];
}

class AverageRating extends Equatable {
  const AverageRating({
    required this.punctuality,
    required this.skill,
  });

  factory AverageRating.fromJson(Map<String, dynamic> json) {
    try {
      return AverageRating(
        punctuality: json['punctuality'] as int,
        skill: json['skill'] as int,
      );
    } catch (e, s) {
      AppLogger.error('Error parsing AverageRating: ', e, s);
      throw Exception(e);
    }
  }

  final int punctuality;
  final int skill;

  Map<String, dynamic> toJson() => {
        'punctuality': punctuality,
        'skill': skill,
      };

  @override
  List<Object?> get props => [punctuality, skill];
}
