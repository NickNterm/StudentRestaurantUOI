import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:student_restaurant_uoi/core/constants/urls.dart';
import 'package:student_restaurant_uoi/features/loading_feature/data/local_data/loading_local_data_source.dart';
import 'package:student_restaurant_uoi/features/loading_feature/data/model/menu_model.dart';
import 'package:student_restaurant_uoi/features/loading_feature/data/model/special_day_model.dart';
import 'package:student_restaurant_uoi/features/loading_feature/data/remote_data/loading_remote_data_source.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late MockHttpClient mockHttpClient;
  late LoadingRemoteDataSourceImpl remoteDataSource;
  setUp(() {
    mockHttpClient = MockHttpClient();
    remoteDataSource = LoadingRemoteDataSourceImpl(
      client: mockHttpClient,
    );
  });

  group('getMenu', () {
    test('should perform a GET request on a URL', () async {
      // arrange
      when(
        () => mockHttpClient.get(
          Uri.parse('$baseUrl/ioannina/menu/'),
          headers: any(named: 'headers'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          jsonEncode(
            MenuModel.testData().toJson(),
          ),
          200,
        ),
      );
      // act
      final result = await remoteDataSource.getMenu();
      // assert
      verify(
        () => mockHttpClient.get(
          Uri.parse('$baseUrl/ioannina/menu/'),
          headers: <String, String>{
            'Accept': '*/*',
            'Accept-Encoding': 'gzip, deflate, br',
            'Connection': 'keep-alive',
            'Content-Type': 'application/json; charset=utf-8',
          },
        ),
      );
      expect(result, equals(MenuModel.testData()));
      verifyNoMoreInteractions(mockHttpClient);
    });
    test('should throw an exception if the response code is not 200', () async {
      // arrange
      when(
        () => mockHttpClient.get(
          Uri.parse('$baseUrl/ioannina/menu/'),
          headers: any(named: 'headers'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          'Something went wrong',
          404,
        ),
      );
      // act
      final call = remoteDataSource.getMenu;
      // assert
      expect(() => call(), throwsException);
    });
  });

  group('get Special Days', () {
    List<SpecialDayModel> specialDays = [
      SpecialDayModel.testData(),
    ];
    test('should return a list of special days with the request', () async {
      // arrange
      when(
        () => mockHttpClient.get(
          Uri.parse('$baseUrl/ioannina/specialDays/'),
          headers: any(named: 'headers'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          jsonEncode(specialDays),
          200,
        ),
      );
      // act
      final result = await remoteDataSource.getSpecialDays();
      // assert
      expect(result, equals(specialDays));
    });
    test('should throw an exception if the response code is not 200', () async {
      // arrange
      when(
        () => mockHttpClient.get(
          Uri.parse('$baseUrl/ioannina/specialDays/'),
          headers: any(named: 'headers'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          'Something went wrong',
          404,
        ),
      );
      // act
      final call = await remoteDataSource.getSpecialDays;
      // assert
      expect(() => call(), throwsException);
    });
  });
}
