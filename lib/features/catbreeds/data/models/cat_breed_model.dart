import '../../domain/entities/cat_breed.dart';

class CatBreedModel {
  final String id;
  final String name;
  final String lifeSpan;
  final String temperament;
  final String origin;
  final String description;
  final String? breedGroup;
  final String? history;
  final Weight? weight;
  final Height? height;
  final CatBreedImage? image;

  const CatBreedModel({
    required this.id,
    required this.name,
    required this.lifeSpan,
    required this.temperament,
    required this.origin,
    required this.description,
    this.breedGroup,
    this.history,
    this.weight,
    this.height,
    this.image,
  });

  factory CatBreedModel.fromJson(Map<String, dynamic> json) {
    final imageJson = json['image'] as Map<String, dynamic>?;

    return CatBreedModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      lifeSpan: json['life_span'] as String? ?? '',
      temperament: json['temperament'] as String? ?? '',
      origin: json['origin'] as String? ?? '',
      description: json['description'] as String? ?? '',
      breedGroup: json['breed_group'] as String?,
      history: json['history'] as String?,
      weight: _parseWeight(json['weight']),
      height: _parseHeight(json['height']),
      image: imageJson == null ? null : _parseImage(imageJson),
    );
  }

  static Weight? _parseWeight(dynamic json) {
    if (json is! Map<String, dynamic>) {
      return null;
    }

    return Weight(
      imperial: json['imperial'] as String? ?? '',
      metric: json['metric'] as String? ?? '',
    );
  }

  static Height? _parseHeight(dynamic json) {
    if (json is! Map<String, dynamic>) {
      return null;
    }

    return Height(
      imperial: json['imperial'] as String? ?? '',
      metric: json['metric'] as String? ?? '',
    );
  }

  static CatBreedImage? _parseImage(Map<String, dynamic> json) {
    final url = json['url'] as String?;

    if (url == null || url.isEmpty) {
      return null;
    }

    return CatBreedImage(
      id: json['id'] as String? ?? '',
      url: url,
      width: json['width'] as int? ?? 0,
      height: json['height'] as int? ?? 0,
    );
  }

  CatBreed toEntity() {
    return CatBreed(
      id: id,
      name: name,
      lifeSpan: lifeSpan,
      temperament: temperament,
      origin: origin,
      description: description,
      breedGroup: breedGroup,
      history: history,
      weight: weight,
      height: height,
      image: image,
    );
  }
}