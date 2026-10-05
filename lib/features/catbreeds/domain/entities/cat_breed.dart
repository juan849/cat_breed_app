class CatBreed {
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

  const CatBreed({
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
}

class Weight {
  final String imperial;
  final String metric;

  const Weight({
    required this.imperial,
    required this.metric,
  });
}

class Height {
  final String imperial;
  final String metric;

  const Height({
    required this.imperial,
    required this.metric,
  });
}

class CatBreedImage {
  final String id;
  final String url;
  final int width;
  final int height;

  const CatBreedImage({
    required this.id,
    required this.url,
    required this.width,
    required this.height,
  });
}