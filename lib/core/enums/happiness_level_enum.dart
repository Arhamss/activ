import 'package:hive_flutter/adapters.dart';

part 'happiness_level_enum.g.dart';

@HiveType(typeId: 1)
enum HappinessLevel {
  @HiveField(0)
  excellent,
  @HiveField(1)
  good,
  @HiveField(2)
  fair,
  @HiveField(3)
  poor,
  @HiveField(4)
  worst,
}

extension HappinessLevelExtensions on HappinessLevel {
  static const Map<HappinessLevel, String> _happinessLevelToString = {
    HappinessLevel.excellent: 'Excellent',
    HappinessLevel.good: 'Good',
    HappinessLevel.fair: 'Fair',
    HappinessLevel.poor: 'Poor',
    HappinessLevel.worst: 'Worst',
  };

  String get toName => _happinessLevelToString[this] ?? 'Fair';

  static HappinessLevel fromString(String value) {
    final normalized = value.toLowerCase();

    return _happinessLevelToString.entries
        .firstWhere(
          (entry) => entry.value.toLowerCase() == normalized,
          orElse: () => const MapEntry(HappinessLevel.fair, 'Fair'),
        )
        .key;
  }
}
