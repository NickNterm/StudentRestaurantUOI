import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:student_restaurant_uoi/features/loading_feature/data/model/special_day_model.dart';
import 'package:student_restaurant_uoi/features/loading_feature/domain/entities/special_day.dart';

import '../../../../fixture/fixture.dart';

class MockSpecialDayModel extends Mock implements SpecialDayModel {}

void main() {
  late MockSpecialDayModel mockSpecialDayModel;
  setUp(() {
    mockSpecialDayModel = MockSpecialDayModel();
  });

  test('should be a subclass of SpecialDay entity', () {
    // assert
    expect(mockSpecialDayModel, isA<SpecialDay>());
  });

  test('should return a valid SpecialDay from JSON', () {
    // arrange
    final Map<String, dynamic> jsonMap = jsonDecode(
      fixture("special_day.json"),
    );
    // act
    final result = SpecialDayModel.fromJson(jsonMap);
    // assert
    expect(result, SpecialDayModel.testData());
  });

  test('should return a valide JSON from the Model', () {
    // arrange
    final Map<String, dynamic> jsonMap = jsonDecode(
      fixture("special_day.json"),
    );
    // act
    final result = SpecialDayModel.testData().toJson();
    // assert
    expect(result, jsonMap);
  });
}
