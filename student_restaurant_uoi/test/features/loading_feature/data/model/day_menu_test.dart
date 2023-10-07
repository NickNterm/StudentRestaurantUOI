import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:student_restaurant_uoi/features/loading_feature/data/model/day_menu_model.dart';

import '../../../../fixture/fixture.dart';

class MockDayMenuModel extends Mock implements DayMenuModel {}

void main() {
  late MockDayMenuModel mockDayMenuModel;

  setUp(() {
    mockDayMenuModel = MockDayMenuModel();
  });

  test('should be a subclass of DayMenu entity', () async {
    // assert
    expect(mockDayMenuModel, isA<DayMenuModel>());
  });

  test('should return a valid DayMenuModel from JSON', () async {
    // arrange
    final Map<String, dynamic> jsonMap =
        jsonDecode(fixture('day_menu.json'));
    // act
    final result = DayMenuModel.fromJson(jsonMap);
    // assert
    expect(result, DayMenuModel.testData());
  });

  test('should return a JSON map containing the proper data', () async {
    // arrange

    final Map<String, dynamic> jsonMap = jsonDecode(fixture('day_menu.json'));
    // act
    final result = DayMenuModel.testData().toJson();
    // assert
    expect(result, jsonMap);
  });
}
