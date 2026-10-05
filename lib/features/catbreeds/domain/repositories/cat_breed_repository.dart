import '../entities/cat_breed.dart';

abstract class CatBreedRepository {
  Future<List<CatBreed>> getCatBreeds();
}