import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:catbreeds_app/features/catbreeds/domain/entities/cat_breed.dart';
import 'package:catbreeds_app/features/catbreeds/domain/usecases/get_cat_breeds.dart';
import 'package:catbreeds_app/features/catbreeds/presentation/providers/cat_breeds_provider.dart';

class MockGetCatBreeds extends Mock implements GetCatBreeds {}

void main() {
  late MockGetCatBreeds mockGetCatBreeds;
  late CatBreedsProvider provider;

  setUp(() {
    mockGetCatBreeds = MockGetCatBreeds();
    provider = CatBreedsProvider(mockGetCatBreeds);
  });

  group('CatBreedsProvider', () {
    test(
      '5. Debe cargar las razas correctamente cuando se llama al provider.',
      () async {
        // Arrange
        final breeds = [
          CatBreed(
            id: 'abys',
            name: 'Abyssinian',
            lifeSpan: '14 - 17',
            temperament: 'Active, Energetic',
            origin: 'Egypt',
            description: 'A friendly cat.',
          ),
          CatBreed(
            id: 'beng',
            name: 'Bengal',
            lifeSpan: '12 - 16',
            temperament: 'Active, Alert',
            origin: 'United States',
            description: 'An active cat.',
          ),
        ];

        when(() => mockGetCatBreeds()).thenAnswer((_) async => breeds);

        // Act
        await provider.loadBreeds();

        // Assert
        expect(provider.isLoading, false);
        expect(provider.errorMessage, isNull);
        expect(provider.listBreeds, hasLength(2));
        expect(provider.filteredBreeds, hasLength(2));

        expect(provider.listBreeds[0].name, 'Abyssinian');
        expect(provider.listBreeds[1].name, 'Bengal');

        verify(() => mockGetCatBreeds()).called(1);
      },
    );

    test('filtra las razas de acuerdo al nombre', () async {
      final breeds = [
        CatBreed(
          id: 'abys',
          name: 'Abyssinian',
          lifeSpan: '14 - 17',
          temperament: 'Active, Energetic',
          origin: 'Egypt',
          description: 'A friendly cat.',
        ),
        CatBreed(
          id: 'beng',
          name: 'Bengal',
          lifeSpan: '12 - 16',
          temperament: 'Active, Alert',
          origin: 'United States',
          description: 'An active cat.',
        ),
        CatBreed(
          id: 'sibe',
          name: 'Siberian',
          lifeSpan: '12 - 15',
          temperament: 'Affectionate, Curious',
          origin: 'Russia',
          description: 'A friendly cat.',
        ),
      ];

      when(() => mockGetCatBreeds()).thenAnswer((_) async => breeds);

      await provider.loadBreeds();

      provider.searchBreeds('aby');

      ///Compara cuántos elementos hay en la lista filtrada y el nombre del primer elemento
      expect(provider.filteredBreeds, hasLength(1));
      ///El primer elemento de la lista filtrada debe ser Abyssinian
      expect(provider.filteredBreeds.first.name, 'Abyssinian');

      provider.searchBreeds('');


      expect(provider.filteredBreeds, hasLength(3));
    });
  });
}
