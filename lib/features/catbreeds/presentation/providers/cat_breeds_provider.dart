import 'package:catbreeds_app/core/error/app_exception.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/cat_breed.dart';
import '../../domain/usecases/get_cat_breeds.dart';

class CatBreedsProvider extends ChangeNotifier {
  final GetCatBreeds getCatBreeds;

  CatBreedsProvider(this.getCatBreeds);

  List<CatBreed> _listBreeds = [];
  List<CatBreed> _filteredBreeds = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<CatBreed> get listBreeds => _listBreeds;
  List<CatBreed> get filteredBreeds => _filteredBreeds;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

Future<void> loadBreeds() async {
  _isLoading = true;
  _errorMessage = null;
  notifyListeners();

  try {
    _listBreeds = await getCatBreeds();
    _filteredBreeds = _listBreeds;
  }on AppException catch (e) {
    _errorMessage = e.message;
  } catch (_) {
    _errorMessage = 'Ocurrió un error inesperado.';
  } finally {
    _isLoading = false;
    notifyListeners();
  }
}

  void searchBreeds(String query) {
    final normalquery = query.trim().toLowerCase();

    if (normalquery.isEmpty) {
      _filteredBreeds = _listBreeds;
    } else {
      _filteredBreeds = _listBreeds
          .where((breed) => breed.name.toLowerCase().contains(normalquery))
          .toList();
    }

    notifyListeners();
  }
}
