import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:student_restaurant_uoi/features/loading_feature/data/model/dish_model.dart';
import 'package:student_restaurant_uoi/features/loading_feature/domain/entities/dish.dart';

import '../../../../fixture/fixture.dart';

class MockDishModel extends Mock implements DishModel {}

void main() {
  late MockDishModel mockDishModel;
  setUp(() {
    mockDishModel = MockDishModel();
  });

  test('should be a subclass of Dish entity', () async {
    // assert
    expect(mockDishModel, isA<Dish>());
  });

  test('should return a valid  DishModel from Json', () async {
    // arrange
    final Map<String, dynamic> jsonMap = jsonDecode(fixture('dish.json'));
    // act
    final result = DishModel.fromJson(jsonMap);
    // assert
    expect(result, DishModel.testModel());
  });

  test('should return a json from the DishModel', () {
    // arrange
    final Map<String, dynamic> jsonMap = jsonDecode(fixture('dish.json'));
    // act
    final result = DishModel.testModel().toJson();
    // assert
    expect(jsonMap, equals(result));
  });
}
