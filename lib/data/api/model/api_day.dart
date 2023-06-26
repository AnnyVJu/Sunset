class ApiDay {
  final num dayLength;
  final String sunset;
  final String sunrise;
  final String solarNoon;

  ApiDay.fromApi(Map<String, dynamic> map)
      : dayLength = map['results']['day_length'],
        sunset = map['results']['sunset'],
        sunrise = map['results']['sunrise'],
        solarNoon = map['results']['solar_noon'];
}
