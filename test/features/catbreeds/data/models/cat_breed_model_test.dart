import 'package:flutter_test/flutter_test.dart';

import 'package:catbreeds_app/features/catbreeds/data/models/cat_breed_model.dart';

void main() {
  group('CatBreedModel.fromJson', () {
    test('1. Se verifica que se pueda crear un CatBreedModel a partir de JSON válido',
      () {
        final json = {
          'id': 'abys',
          'name': 'Abyssinian',
          'life_span': '14 - 17',
          'temperament':
              'Active, Energetic, Independent, Intelligent, Gentle, Curious, Playful',
          'origin': 'Egypt',
          'description':
              'Medium-sized, elegant cat with a distinctive ticked coat pattern.',
          'breed_group': 'Short-haired',
          'history': 'One of the oldest known cat breeds.',
          'weight': {'imperial': '8 - 12', 'metric': '3.6 - 5.4'},
          'height': {'imperial': '10 - 12', 'metric': '25 - 30'},
          'image': {
            'id': 'KWdLHmOqc',
            'url': 'https://cdn2.thecatapi.com/images/KWdLHmOqc.jpg',
            'width': 3114,
            'height': 2609,
          },
        };

        final model = CatBreedModel.fromJson(json);

        expect(model.id, 'abys');
        expect(model.name, 'Abyssinian');
        expect(model.lifeSpan, '14 - 17');
        expect(model.origin, 'Egypt');
        expect(model.breedGroup, 'Short-haired');
        expect(model.history, 'One of the oldest known cat breeds.');

        expect(model.weight, isNotNull);
        expect(model.weight!.metric, '3.6 - 5.4');

        expect(model.height, isNotNull);
        expect(model.height!.metric, '25 - 30');

        expect(model.image, isNotNull);
        expect(
          model.image!.url,
          'https://cdn2.thecatapi.com/images/KWdLHmOqc.jpg',
        );
      },
    );

    test('2. Convierte un JSON a CatBreedModel cuando la imagen no está presente',
      () {
        final json = {
          'id': 'amri',
          'name': 'American Ringtail',
          'life_span': '15 - 20',
          'temperament': 'Affectionate, Intelligent, Curious',
          'origin': 'United States',
          'description': 'A cat breed known for its distinctive curled tail.',
          'breed_group': null,
          'history': null,
          'weight': {'imperial': '7 - 10', 'metric': '3.2 - 4.5'},
          'height': {'imperial': '8 - 10', 'metric': '20 - 25'},
        };

        final model = CatBreedModel.fromJson(json);

        expect(model.id, 'amri');
        expect(model.name, 'American Ringtail');
        expect(model.image, isNull);
      },
    );



  });
}
