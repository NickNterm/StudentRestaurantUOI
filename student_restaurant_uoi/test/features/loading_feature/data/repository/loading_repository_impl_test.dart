import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:student_restaurant_uoi/core/failure/failure.dart';
import 'package:student_restaurant_uoi/core/network_info/network_info.dart';
import 'package:student_restaurant_uoi/features/loading_feature/data/local_data/loading_local_data_source.dart';
import 'package:student_restaurant_uoi/features/loading_feature/data/model/menu_model.dart';
import 'package:student_restaurant_uoi/features/loading_feature/data/model/special_day_model.dart';
import 'package:student_restaurant_uoi/features/loading_feature/data/remote_data/loading_remote_data_source.dart';
import 'package:student_restaurant_uoi/features/loading_feature/data/repository/loading_repository_impl.dart';

class MockLocalDataSource extends Mock implements LoadingLocalDataSource {}

class MockRemoteDataSource extends Mock implements LoadingRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late MockLocalDataSource mockLocalDataSource;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late LoadingRepositoryImpl repositoryImpl;

  setUp(() {
    mockLocalDataSource = MockLocalDataSource();
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repositoryImpl = LoadingRepositoryImpl(
      networkInfo: mockNetworkInfo,
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  group('Get Menu', () {
    group("When there is a network Connection", () {
      test('Should return a list of MealModel if everything goes perfect',
          () async {
        // arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(() => mockRemoteDataSource.getMenu()).thenAnswer(
          (_) async => MenuModel.testData(),
        );
        when(() => mockLocalDataSource.cacheMenu(MenuModel.testData()))
            .thenAnswer(
          (_) async => MenuModel.testData(),
        );
        // act
        final result = await repositoryImpl.getMenu();
        // assert
        verify(() => mockNetworkInfo.isConnected);
        verify(() => mockRemoteDataSource.getMenu());
        verify(() => mockLocalDataSource.cacheMenu(MenuModel.testData()));
        expect(result, equals(Right(MenuModel.testData())));
        verifyNoMoreInteractions(mockNetworkInfo);
        verifyNoMoreInteractions(mockRemoteDataSource);
        verifyNoMoreInteractions(mockLocalDataSource);
      });

      test(
          "If the remote data has a problem should thrown exception and should return the local data in the base",
          () async {
        // arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(() => mockRemoteDataSource.getMenu()).thenThrow(Exception());
        when(() => mockLocalDataSource.getMenu()).thenAnswer(
          (_) async => MenuModel.testData(),
        );
        // act
        final result = await repositoryImpl.getMenu();
        // assert
        verify(() => mockNetworkInfo.isConnected);
        verify(() => mockRemoteDataSource.getMenu());
        verify(() => mockLocalDataSource.getMenu());
        expect(result, equals(Right(MenuModel.testData())));
        verifyNoMoreInteractions(mockNetworkInfo);
        verifyNoMoreInteractions(mockRemoteDataSource);
        verifyNoMoreInteractions(mockLocalDataSource);
      });

      test(
          "if remote and local data can't return data then should return left with a failure",
          () async {
        // arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(() => mockRemoteDataSource.getMenu()).thenThrow(Exception());
        when(() => mockLocalDataSource.getMenu()).thenThrow(Exception());
        // act
        final result = await repositoryImpl.getMenu();
        // assert
        verify(() => mockNetworkInfo.isConnected);
        verify(() => mockRemoteDataSource.getMenu());
        verify(() => mockLocalDataSource.getMenu());
        expect(result, equals(const Left(CacheFailure())));
        verifyNoMoreInteractions(mockNetworkInfo);
        verifyNoMoreInteractions(mockRemoteDataSource);
        verifyNoMoreInteractions(mockLocalDataSource);
      });
    });
    group('When there is no Network Connection', () {
      test(
          "should fetch the data from the local data source and return the list of meals",
          () async {
        // arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        when(() => mockLocalDataSource.getMenu()).thenAnswer(
          (_) async => MenuModel.testData(),
        );
        // act
        final result = await repositoryImpl.getMenu();
        // assert
        verify(() => mockNetworkInfo.isConnected);
        verify(() => mockLocalDataSource.getMenu());
        expect(result, equals(Right(MenuModel.testData())));
        verifyNoMoreInteractions(mockNetworkInfo);
        verifyNoMoreInteractions(mockLocalDataSource);
        verifyZeroInteractions(mockRemoteDataSource);
      });
      test(
          'should return a Network error in case there is a problem in the local data',
          () async {
        // arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        when(() => mockLocalDataSource.getMenu()).thenThrow(Exception());
        // act
        final result = await repositoryImpl.getMenu();
        // assert
        verify(() => mockNetworkInfo.isConnected);
        verify(() => mockLocalDataSource.getMenu());
        expect(result, equals(const Left(NetworkFailure())));
        verifyNoMoreInteractions(mockNetworkInfo);
        verifyNoMoreInteractions(mockLocalDataSource);
        verifyZeroInteractions(mockRemoteDataSource);
      });
    });
  });

  group("Get Special Days", () {
    group("there is a Network connection", () {
      List<SpecialDayModel> specialDays = [
        SpecialDayModel.testData(),
      ];
      test(
          "if everything is okay then you should return a list of Special days",
          () async {
        // arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(() => mockRemoteDataSource.getSpecialDays()).thenAnswer(
          (_) async => specialDays,
        );
        // act
        final result = await repositoryImpl.getSpecialDays();
        // assert
        verify(() => mockNetworkInfo.isConnected);
        verify(() => mockRemoteDataSource.getSpecialDays());
        expect(result, equals(Right(specialDays)));
        verifyNoMoreInteractions(mockNetworkInfo);
        verifyNoMoreInteractions(mockRemoteDataSource);
        verifyZeroInteractions(mockLocalDataSource);
      });
      test(
          "if there is a problem fetch the data from the remote data then should return ServerFailure",
          () async {
        // arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(() => mockRemoteDataSource.getSpecialDays())
            .thenThrow(Exception());
        // act
        final result = await repositoryImpl.getSpecialDays();
        // assert
        verify(() => mockNetworkInfo.isConnected);
        verify(() => mockRemoteDataSource.getSpecialDays());
        expect(result, equals(const Left(ServerFailure())));
        verifyNoMoreInteractions(mockNetworkInfo);
        verifyNoMoreInteractions(mockRemoteDataSource);
        verifyZeroInteractions(mockLocalDataSource);
      });
    });
    group("There is not Network Connection", () {
      test('should just return an NetworkFailure', () async {
        // arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        // act
        final result = await repositoryImpl.getSpecialDays();
        // assert
        verify(() => mockNetworkInfo.isConnected);
        expect(result, equals(const Left(NetworkFailure())));
        verifyNoMoreInteractions(mockNetworkInfo);
        verifyZeroInteractions(mockRemoteDataSource);
        verifyZeroInteractions(mockLocalDataSource);
      });
    });
  });
}
