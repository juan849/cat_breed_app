import 'package:catbreeds_app/core/error/app_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:catbreeds_app/features/catbreeds/data/datasources/cat_breed_remote_datasource.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MockDio mockDio;
  late CatBreedRemoteDataSourceImpl dataSource;

  setUp(() {
    mockDio = MockDio();
    dataSource = CatBreedRemoteDataSourceImpl(mockDio);
  });

  group('CatBreedRemoteDataSourceImpl', () {
    test('4. Convierte la respuesta de la API en una lista de modelos (CatBreedModel) correctamente.',
        () async {
      
      final responseData = [
        {
          'id': 'abys',
          'name': 'Abyssinian',
          'life_span': '14 - 17',
          'temperament': 'Active, Energetic, Independent',
          'origin': 'Egypt',
          'description': 'A friendly and active cat breed.',
        },
        {
          'id': 'beng',
          'name': 'Bengal',
          'life_span': '12 - 16',
          'temperament': 'Alert, Agile, Energetic',
          'origin': 'United States',
          'description': 'An active and intelligent cat breed.',
        },
      ];

      when(() => mockDio.get('/breeds')).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/breeds'),
          data: responseData,
          statusCode: 200,
        ),
      );

      // Act
      final result = await dataSource.getCatBreeds();

      // Assert
      expect(result, hasLength(2));

      expect(result[0].id, 'abys');
      expect(result[0].name, 'Abyssinian');

      expect(result[1].id, 'beng');
      expect(result[1].name, 'Bengal');

      verify(() => mockDio.get('/breeds')).called(1);
    });


    test('7. Lanza la excepción UnauthorizedException cuando la API key no es válida',
    () async {
      // Arrange
      when(() => mockDio.get('/breeds')).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/breeds'),
          response: Response(
            requestOptions: RequestOptions(path: '/breeds'),
            statusCode: 401,
          ),
        ),
      );

      // Act
      final call = dataSource.getCatBreeds();

      // Assert
      expect(
        call,
        throwsA(isA<UnauthorizedException>()),
      );
    });
  });
}