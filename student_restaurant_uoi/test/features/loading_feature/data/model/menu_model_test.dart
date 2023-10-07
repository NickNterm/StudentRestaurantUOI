import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:student_restaurant_uoi/features/loading_feature/data/model/menu_model.dart';
import 'package:student_restaurant_uoi/features/loading_feature/domain/entities/menu.dart';

import '../../../../fixture/fixture.dart';

class MockMenuModel extends Mock implements MenuModel {}

void main() {
  late MockMenuModel mockMenuModel;
  setUp(() {
    mockMenuModel = MockMenuModel();
  });

  test('should be a subclass of Menu entity', () async {
    // assert
    expect(mockMenuModel, isA<Menu>());
  });

  test('should return a valid MenuModel from JSON', () async {
    // arrange
    final Map<String, dynamic> jsonMap = jsonDecode(fixture('menu.json'));
    // act
    final result = MenuModel.fromJson(jsonMap);
    // assert
    expect(result, MenuModel.testData());
  });

  test('should return a JSON map containing the proper data', () async {
    // arrange
    // act
    final Map<String, dynamic> jsonMap = jsonDecode(fixture('menu.json'));
    // act
    final result = MenuModel.testData().toJson();
    // assert
    expect(result, jsonMap);
  });
}
