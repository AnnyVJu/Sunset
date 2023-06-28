import 'package:sunset/data/repository/day_data_repository.dart';
import 'package:sunset/domain/repository/day_repository.dart';
import 'package:sunset/internal/dependencies/api_module.dart';

class RepositoryModule {
 // static DayRepository _dayRepository;

  static DayRepository dayRepository() {
    DayRepository? dayRepository;
    dayRepository ??= DayDataRepository(
      ApiModule.apiUtil(),
    );
    return dayRepository;
  }
}
