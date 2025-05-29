import 'package:activ/core/models/notification_preference.dart';
import 'package:activ/core/models/user_model/user_sport.dart';
import 'package:activ/utils/helpers/logger_helper.dart';
import 'package:equatable/equatable.dart';

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
    this.fcmToken,
    this.signupType,
    this.googleId,
    this.appleId,
    this.unratedGamesCount = 0,
    this.ratingAllowed = true,
    this.getstreamUserId,
    this.createdAt,
    this.updatedAt,
    this.gender,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    try {
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
        sports: (json['sports'] as List<dynamic>?)
                ?.map((e) => UserSport.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        fcmToken: json['fcmToken'] as String?,
        signupType: json['signupType'] as String?,
        googleId: json['googleId'] as String?,
        appleId: json['appleId'] as String?,
        unratedGamesCount: json['unratedGamesCount'] as int? ?? 0,
        ratingAllowed: json['ratingAllowed'] as bool? ?? true,
        getstreamUserId: json['getstreamUserId'] as String?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
        gender: json['gender'] as String?,
      );
    } catch (e, s) {
      AppLogger.error('Error parsing UserModel: ', e, s);
      throw Exception(e);
    }
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
  final String? fcmToken;
  final String? signupType;
  final String? googleId;
  final String? appleId;
  final int unratedGamesCount;
  final bool ratingAllowed;
  final String? getstreamUserId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? gender;

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
        'fcmToken': fcmToken,
        'signupType': signupType,
        'googleId': googleId,
        'appleId': appleId,
        'unratedGamesCount': unratedGamesCount,
        'ratingAllowed': ratingAllowed,
        'getstreamUserId': getstreamUserId,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'gender': gender,
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
        fcmToken,
        signupType,
        googleId,
        appleId,
        unratedGamesCount,
        ratingAllowed,
        getstreamUserId,
        createdAt,
        updatedAt,
        gender,
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
    String? fcmToken,
    String? signupType,
    String? googleId,
    String? appleId,
    int? unratedGamesCount,
    bool? ratingAllowed,
    String? getstreamUserId,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? gender,
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
      fcmToken: fcmToken ?? this.fcmToken,
      signupType: signupType ?? this.signupType,
      googleId: googleId ?? this.googleId,
      appleId: appleId ?? this.appleId,
      unratedGamesCount: unratedGamesCount ?? this.unratedGamesCount,
      ratingAllowed: ratingAllowed ?? this.ratingAllowed,
      getstreamUserId: getstreamUserId ?? this.getstreamUserId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      gender: gender ?? this.gender,
    );
  }
}
