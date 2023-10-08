import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:student_restaurant_uoi/features/loading_feature/data/model/menu_model.dart';
import 'package:student_restaurant_uoi/features/loading_feature/domain/repository/loading_repository.dart';
import 'package:student_restaurant_uoi/features/loading_feature/domain/use_case/get_menu_use_case.dart';

class MockLoadingRepository extends Mock implements LoadingRepository {}

void main() {
  late MockLoadingRepository mockLoadingRepository;
  late GetMenuUseCase getMenuUseCase;
  setUp(() {
    mockLoadingRepository = MockLoadingRepository();
    getMenuUseCase = GetMenuUseCase(
      loadingRepository: mockLoadingRepository,
    );
  });

  test('should return MenuModel from repository', () async {
    // arrange
    when(() => mockLoadingRepository.getMenu()).thenAnswer(
      (_) async => Right(MenuModel.testData()),
    );
    // act
    final result = await getMenuUseCase();
    // assert
    verify(() => mockLoadingRepository.getMenu());
    expect(result, equals(Right(MenuModel.testData())));
    verifyNoMoreInteractions(mockLoadingRepository);
  });
}
