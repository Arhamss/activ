import 'package:activ/constants/asset_paths.dart';

class AppConstants {
  factory AppConstants() {
    return _singleton;
  }

  AppConstants._internal();

  static final AppConstants _singleton = AppConstants._internal();

  static const placeholderUserAvatar = 'assets/images/user_avatar.png';
  static const placeholderUserName = 'Unknown User';
  static const placeholderUserEmail = 'Unknown Email';
  static const restaurantPlaceHolder =
      'assets/images/placeholder_restaurant.png';
  static const paginationPageLimit = 5;

  static const interestAssets = [
    AssetPaths.runningIcon,
    AssetPaths.cyclingIcon,
    AssetPaths.swimmingIcon,
    AssetPaths.bowlingIcon,
    AssetPaths.tennisIcon,
    AssetPaths.basketballIcon,
    AssetPaths.footballIcon,
    AssetPaths.volleyballIcon,
    AssetPaths.badmintonIcon,
    AssetPaths.tableTennisIcon,
    AssetPaths.golfIcon,
    AssetPaths.cricketIcon,
    AssetPaths.fitnessIcon,
    AssetPaths.handBallIcon,
    AssetPaths.martialArtsIcon,
    AssetPaths.padelIcon,
  ];
}
