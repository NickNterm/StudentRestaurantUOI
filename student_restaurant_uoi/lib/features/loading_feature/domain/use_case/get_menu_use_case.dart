import 'package:dartz/dartz.dart';
import 'package:student_restaurant_uoi/core/failure/failure.dart';
import 'package:student_restaurant_uoi/features/loading_feature/data/model/menu_model.dart';
import 'package:student_restaurant_uoi/features/loading_feature/domain/repository/loading_repository.dart';

class GetMenuUseCase {
  final LoadingRepository loadingRepository;

  GetMenuUseCase({
    required this.loadingRepository,
  });

  Future<Either<Failure, MenuModel>> call() async {
    return await loadingRepository.getMenu();
  }
}
