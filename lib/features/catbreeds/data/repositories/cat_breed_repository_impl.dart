import '../../domain/entities/cat_breed.dart';
import '../../domain/repositories/cat_breed_repository.dart';
import '../datasources/cat_breed_remote_datasource.dart';

class CatBreedRepositoryImpl implements CatBreedRepository {
  final CatBreedRemoteDataSource remoteDataSource;

  CatBreedRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<CatBreed>> getCatBreeds() async {
    final models = await remoteDataSource.getCatBreeds();

    return models.map((model) => model.toEntity()).toList();
  }
}