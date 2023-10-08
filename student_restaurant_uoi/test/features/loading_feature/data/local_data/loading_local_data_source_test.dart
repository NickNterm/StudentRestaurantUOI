import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_restaurant_uoi/core/constants/keys.dart';
import 'package:student_restaurant_uoi/features/loading_feature/data/local_data/loading_local_data_source.dart';
import 'package:student_restaurant_uoi/features/loading_feature/data/model/menu_model.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockSharedPreferences;
  late LoadingLocalDataSource localDataSource;
  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    localDataSource = LoadingLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  test('should return MenuModel from SharedPreferences', () async {
    // arrange
    when(() => mockSharedPreferences.getString(any())).thenReturn(
      jsonEncode(
        MenuModel.testData().toJson(),
      ),
    );
    // act
    final result = await localDataSource.getMenu();
    // assert
    verify(() => mockSharedPreferences.getString(menuKey));
    expect(result, equals(MenuModel.testData()));
    verifyNoMoreInteractions(mockSharedPreferences);
  });
  test('should throw exception if the data is null of empty', () async {
    // arrange
    when(() => mockSharedPreferences.getString(any())).thenReturn(null);
    // act
    final call = localDataSource.getMenu;
    // assert
    expect(() => call(), throwsA(isA<Exception>()));
    verify(() => mockSharedPreferences.getString(menuKey));
    verifyNoMoreInteractions(mockSharedPreferences);
  });
  test('should return the MenuModel while caching', () async {
    // arrange
    when(() => mockSharedPreferences.setString(any(), any())).thenAnswer(
      (_) async => true,
    );
    // act
    final result = await localDataSource.cacheMenu(
      MenuModel.testData(),
    );
    // assert
    verify(
      () => mockSharedPreferences.setString(
        menuKey,
        jsonEncode(
          MenuModel.testData().toJson(),
        ),
      ),
    );
    expect(result, equals(MenuModel.testData()));
    verifyNoMoreInteractions(mockSharedPreferences);
  });
}
