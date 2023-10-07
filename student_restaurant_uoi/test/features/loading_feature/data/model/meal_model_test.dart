import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:student_restaurant_uoi/features/loading_feature/data/model/meal_model.dart';

import '../../../../fixture/fixture.dart';

class MockMealModel extends Mock implements MealModel {}

void main() {
  late MockMealModel mockMealModel;
  setUp(() {
    mockMealModel = MockMealModel();
  });

  test('should be a subclass of Meal entity', () async {
    // assert
    expect(mockMealModel, isA<MealModel>());
  });

  test('should return a valid MealModel from Json', () async {
    // arrange
    final Map<String, dynamic> jsonMap = jsonDecode(fixture('meal.json'));
    // act
    final result = MealModel.fromJson(jsonMap);
    // assert
    expect(result, MealModel.testData());
  });

  test('should return a json from the MealModel', () {
    // arrange
    final Map<String, dynamic> jsonMap = jsonDecode(fixture('meal.json'));
    // act
    final result = MealModel.testData().toJson();
    // assert
    expect(jsonMap, equals(result));
  });
}
