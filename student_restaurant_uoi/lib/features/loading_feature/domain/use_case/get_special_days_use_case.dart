import 'package:dartz/dartz.dart';
import 'package:student_restaurant_uoi/features/loading_feature/domain/repository/loading_repository.dart';

import '../../../../core/failure/failure.dart';
import '../../data/model/special_day_model.dart';

class GetSpecialDayUseCase {
  final LoadingRepository loadingRepository;

  GetSpecialDayUseCase({
    required this.loadingRepository,
  });

  Future<Either<Failure, List<SpecialDayModel>>> call() async {
    return await loadingRepository.getSpecialDays();
  }
}
