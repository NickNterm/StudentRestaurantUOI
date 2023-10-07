import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:student_restaurant_uoi/features/loading_feature/data/model/program_model.dart';
import 'package:student_restaurant_uoi/features/loading_feature/domain/entities/program.dart';

import '../../../../fixture/fixture.dart';

class MockProgramModel extends Mock implements ProgramModel {}

void main() {
  late MockProgramModel mockProgramModel;
  setUp(() {
    mockProgramModel = MockProgramModel();
  });

  test('should be a subclass of Program entity', () {
    // assert
    expect(mockProgramModel, isA<Program>());
  });

  test('should return a valid Program from JSON', () {
    // arrange
    final Map<String, dynamic> jsonMap = jsonDecode(
      fixture("program.json"),
    );
    // act
    final result = ProgramModel.fromJson(jsonMap);
    // assert
    expect(result, ProgramModel.testData());
  });

  test('should return a valide JSON from the Model', () {
    // arrange
    final Map<String, dynamic> jsonMap = jsonDecode(
      fixture("program.json"),
    );
    // act
    final result = ProgramModel.testData().toJson();
    // assert
    expect(result, jsonMap);
  });
}
