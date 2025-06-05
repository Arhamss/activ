import 'package:activ/constants/constants.dart';
import 'package:equatable/equatable.dart';
import 'package:activ/core/models/user_model/user_sport.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

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
    required this.signupType,
    required this.unratedGamesCount,
    required this.ratingAllowed,
    required this.createdAt,
    required this.updatedAt,
    required this.getstreamUserId,
    this.imageUrl,
    this.dob,
    this.phone,
    this.fcmToken,
    this.googleId,
    this.appleId,
    this.gender,
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
      fcmToken: json['fcmToken'] as String?,
      signupType: json['signupType'] as String,
      googleId: json['googleId'] as String?,
      appleId: json['appleId'] as String?,
      unratedGamesCount: json['unratedGamesCount'] as int,
      ratingAllowed: json['ratingAllowed'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      getstreamUserId: json['getstreamUserId'] as String,
      gender: json['gender'] as String?,
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
  final String? fcmToken;
  final String signupType;
  final String? googleId;
  final String? appleId;
  final int unratedGamesCount;
  final bool ratingAllowed;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String getstreamUserId;
  final String? gender;
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
        'fcmToken': fcmToken,
        'signupType': signupType,
        'googleId': googleId,
        'appleId': appleId,
        'unratedGamesCount': unratedGamesCount,
        'ratingAllowed': ratingAllowed,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'getstreamUserId': getstreamUserId,
        'gender': gender,
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
        fcmToken,
        signupType,
        googleId,
        appleId,
        unratedGamesCount,
        ratingAllowed,
        createdAt,
        updatedAt,
        getstreamUserId,
        gender,
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
    String? fcmToken,
    String? signupType,
    String? googleId,
    String? appleId,
    int? unratedGamesCount,
    bool? ratingAllowed,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? getstreamUserId,
    String? gender,
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
      fcmToken: fcmToken ?? this.fcmToken,
      signupType: signupType ?? this.signupType,
      googleId: googleId ?? this.googleId,
      appleId: appleId ?? this.appleId,
      unratedGamesCount: unratedGamesCount ?? this.unratedGamesCount,
      ratingAllowed: ratingAllowed ?? this.ratingAllowed,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      getstreamUserId: getstreamUserId ?? this.getstreamUserId,
      gender: gender ?? this.gender,
      sports: sports ?? this.sports,
    );
  }
}

extension UserModelMapper on UserModel {
  User toStreamChatUser() {
    return User(
      id: id,
      extraData: {
        'name': '$firstName $lastName',
        'email': email,
        'image': imageUrl ?? AppConstants.placeholderUserAvatar,
      },
    );
  }
}
