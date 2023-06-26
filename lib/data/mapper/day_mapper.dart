import '../../domain/model/day.dart';
import '../api/model/api_day.dart';

class DayMapper {
  static Day fromApi(ApiDay day) {
    return Day(
      dayLength: day.dayLength.toInt(),
      sunset: DateTime.tryParse(day.sunset),
      sunrise: DateTime.tryParse(day.sunrise),
      solarNoon: DateTime.tryParse(day.solarNoon),
    );
  }
}
