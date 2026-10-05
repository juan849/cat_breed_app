import '../entities/cat_breed.dart';
import '../repositories/cat_breed_repository.dart';

class GetCatBreeds {
  final CatBreedRepository repository;

  GetCatBreeds(this.repository);

  Future<List<CatBreed>> call() {
    return repository.getCatBreeds();
  }
}