import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:catbreeds_app/features/catbreeds/data/datasources/cat_breed_remote_datasource.dart';
import 'package:catbreeds_app/features/catbreeds/data/models/cat_breed_model.dart';
import 'package:catbreeds_app/features/catbreeds/data/repositories/cat_breed_repository_impl.dart';

class MockCatBreedRemoteDataSource extends Mock
    implements CatBreedRemoteDataSource {}

void main() {
  late MockCatBreedRemoteDataSource mockDataSource;
  late CatBreedRepositoryImpl repository;

  setUp(() {
    mockDataSource = MockCatBreedRemoteDataSource();
    repository = CatBreedRepositoryImpl(mockDataSource);
  });

  group('CatBreedRepositoryImpl', () {
    test('3. Convierte los modelos del origen de datos (CatBreedModel) en entidades (CatBreed)', () async {
      
      final models = [
        const CatBreedModel(
          id: 'abys',
          name: 'Abyssinian',
          lifeSpan: '14 - 17',
          temperament: 'Active, Energetic, Independent',
          origin: 'Egypt',
          description: 'A friendly and active cat breed.',
        ),
        const CatBreedModel(
          id: 'beng',
          name: 'Bengal',
          lifeSpan: '12 - 16',
          temperament: 'Alert, Agile, Energetic',
          origin: 'United States',
          description: 'An active and intelligent cat breed.',
        ),
      ];

      when(() => mockDataSource.getCatBreeds())
          .thenAnswer((_) async => models);

      
      final result = await repository.getCatBreeds();

      
      expect(result, hasLength(2));

      expect(result[0].id, 'abys');
      expect(result[0].name, 'Abyssinian');
      expect(result[0].origin, 'Egypt');

      expect(result[1].id, 'beng');
      expect(result[1].name, 'Bengal');
      expect(result[1].origin, 'United States');

      verify(() => mockDataSource.getCatBreeds()).called(1);
    });
  });
}