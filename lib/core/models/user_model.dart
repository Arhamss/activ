import 'package:equatable/equatable.dart';

class NotificationPreferences extends Equatable {
  const NotificationPreferences({
    required this.gameInvites,
    required this.messages,
  });

  factory NotificationPreferences.fromJson(Map<String, dynamic> json) {
    return NotificationPreferences(
      gameInvites: json['gameInvites'] as bool,
      messages: json['messages'] as bool,
    );
  }

  final bool gameInvites;
  final bool messages;

  Map<String, dynamic> toJson() => {
        'gameInvites': gameInvites,
        'messages': messages,
      };

  @override
  List<Object?> get props => [gameInvites, messages];
}

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

class UserModel extends Equatable {
  const UserModel({
    required this.id,
    required this.onboarded,
    required this.email,
    required this.notificationPreferences,
    required this.locationEnabled,
    required this.firstName,
    required this.lastName,
    required this.sports,
    this.imageUrl,
    this.dob,
    this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      onboarded: json['onboarded'] as bool,
      email: json['email'] as String,
      notificationPreferences: NotificationPreferences.fromJson(
        json['notificationPreferences'] as Map<String, dynamic>,
      ),
      imageUrl: json['imageUrl'] as String?,
      locationEnabled: json['locationEnabled'] as bool,
      dob: json['dob'] == null ? null : DateTime.parse(json['dob'] as String),
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      phone: json['phone'] as String?,
      sports: (json['sports'] as List<dynamic>)
          .map((e) => UserSport.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  final String id;
  final bool onboarded;
  final String email;
  final NotificationPreferences notificationPreferences;
  final String? imageUrl;
  final bool locationEnabled;
  final DateTime? dob;
  final String firstName;
  final String lastName;
  final String? phone;
  final List<UserSport> sports;

  Map<String, dynamic> toJson() => {
        'id': id,
        'onboarded': onboarded,
        'email': email,
        'notificationPreferences': notificationPreferences.toJson(),
        'imageUrl': imageUrl,
        'locationEnabled': locationEnabled,
        'dob': dob?.toIso8601String(),
        'firstName': firstName,
        'lastName': lastName,
        'phone': phone,
        'sports': sports.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props => [
        id,
        onboarded,
        email,
        notificationPreferences,
        imageUrl,
        locationEnabled,
        dob,
        firstName,
        lastName,
        phone,
        sports,
      ];

  UserModel copyWith({
    String? id,
    bool? onboarded,
    String? email,
    NotificationPreferences? notificationPreferences,
    String? imageUrl,
    bool? locationEnabled,
    DateTime? dob,
    String? firstName,
    String? lastName,
    String? phone,
    List<UserSport>? sports,
  }) {
    return UserModel(
      id: id ?? this.id,
      onboarded: onboarded ?? this.onboarded,
      email: email ?? this.email,
      notificationPreferences:
          notificationPreferences ?? this.notificationPreferences,
      imageUrl: imageUrl ?? this.imageUrl,
      locationEnabled: locationEnabled ?? this.locationEnabled,
      dob: dob ?? this.dob,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      sports: sports ?? this.sports,
    );
  }
}
