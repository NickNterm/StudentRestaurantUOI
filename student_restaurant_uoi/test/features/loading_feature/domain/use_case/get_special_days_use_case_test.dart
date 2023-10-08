import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:student_restaurant_uoi/features/loading_feature/data/model/special_day_model.dart';
import 'package:student_restaurant_uoi/features/loading_feature/domain/repository/loading_repository.dart';
import 'package:student_restaurant_uoi/features/loading_feature/domain/use_case/get_special_days_use_case.dart';

class MockLoadingRepository extends Mock implements LoadingRepository {}

void main() {
  late MockLoadingRepository mockLoadingRepository;
  late GetSpecialDayUseCase getSpecialDayUseCase;
  setUp(() {
    mockLoadingRepository = MockLoadingRepository();
    getSpecialDayUseCase = GetSpecialDayUseCase(
      loadingRepository: mockLoadingRepository,
    );
  });

  List<SpecialDayModel> specialDays = [
    SpecialDayModel.testData(),
  ];

  test('should return List<SpecialDayModel> from repository', () async {
    // arrange
    when(() => mockLoadingRepository.getSpecialDays()).thenAnswer(
      (_) async => Right(specialDays),
    );
    // act
    final result = await getSpecialDayUseCase();
    // assert
    verify(() => mockLoadingRepository.getSpecialDays());
    expect(result, equals(Right(specialDays)));
    verifyNoMoreInteractions(mockLoadingRepository);
  });
}
