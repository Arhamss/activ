import 'package:hive_flutter/adapters.dart';

enum Sports {
  basketball,
  football,
  volleyball,
  tennis,
  tableTennis,
  cricket,
  golf,
  bowling,
  martialArts,
  fitnessWorkouts,
  running,
  cycling,
  swimming,
  badminton,
  handball,
  padel,
}

extension SportsExtensions on Sports {
  static const Map<Sports, String> _sportsToString = {
    Sports.basketball: 'Basketball',
    Sports.football: 'Football',
    Sports.volleyball: 'Volleyball',
    Sports.tennis: 'Tennis',
    Sports.tableTennis: 'Table Tennis',
    Sports.cricket: 'Cricket',
    Sports.golf: 'Golf',
    Sports.bowling: 'Bowling',
    Sports.martialArts: 'Martial Arts',
    Sports.fitnessWorkouts: 'Fitness Workouts',
    Sports.running: 'Running',
    Sports.cycling: 'Cycling',
    Sports.swimming: 'Swimming',
    Sports.badminton: 'Badminton',
    Sports.handball: 'Handball',
    Sports.padel: 'Padel',
  };

  String get name => _sportsToString[this] ?? 'Unknown';
  String get toName => _sportsToString[this] ?? 'Unknown';

  static Sports fromString(String value) {
    final normalized = value.toLowerCase();

    return _sportsToString.entries
        .firstWhere(
          (entry) => entry.value.toLowerCase() == normalized,
          orElse: () => const MapEntry(Sports.basketball, 'Basketball'),
        )
        .key;
  }
}
