import 'package:meta/meta.dart';

class Day {
  final int dayLength;
  final DateTime? sunset;
  final DateTime? sunrise;
  final DateTime? solarNoon;

  Day({
    required this.dayLength,
    required this.sunset,
    required this.sunrise,
    required this.solarNoon,
});
}