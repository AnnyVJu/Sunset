import 'package:sunset/data/api/api_util.dart';

import '../../data/api/service/sunrise_service.dart';

class ApiModule {
  //static ApiUtil _apiUtil;

  static ApiUtil apiUtil() {
    ApiUtil? apiUtil;
    apiUtil ??= ApiUtil(SunriseService());
    return apiUtil;
  }
}