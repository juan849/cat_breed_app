import 'package:flutter/material.dart';

import 'package:catbreeds_app/core/theme/app_colors.dart';

import '../../domain/entities/cat_breed.dart';

class DetailScreen extends StatelessWidget {
  final CatBreed breed;

  const DetailScreen({super.key, required this.breed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(breed.name),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: AspectRatio(
                aspectRatio: 5 / 4,
                child: _buildImage(),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: _buildBreedInformation(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (breed.image == null) {
      return Container(
        width: double.infinity,
        alignment: Alignment.center,
        color: AppColors.placeholder,
        child: const Icon(
          Icons.pets,
          size: 80,
          color: AppColors.textSecondary,
        ),
      );
    }

    return Image.network(
      breed.image!.url,
      width: double.infinity,
      fit: BoxFit.cover,
      cacheWidth: 800,
      filterQuality: FilterQuality.low,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) {
          return child;
        }

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: frame == null
              ? Container(
                  key: const ValueKey('loading'),
                  width: double.infinity,
                  color: AppColors.placeholder,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                )
              : child,
        );
      },
      errorBuilder: (_, __, ___) {
        return Container(
          width: double.infinity,
          height: 200,
          alignment: Alignment.center,
          color: AppColors.placeholder,
          child: const Icon(
            Icons.pets,
            size: 64,
            color: AppColors.textSecondary,
          ),
        );
      },
    );
    /*     return Image.network(
      breed.image!.url,
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) {
        return Container(
          width: double.infinity,
          alignment: Alignment.center,
          color: Colors.grey.shade200,
          child: const Icon(
            Icons.pets,
            size: 80,
            color: Colors.grey,
          ),
        );
      },
    ); */
  }

  Widget _buildBreedInformation(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          breed.description,
          style: textTheme.bodyMedium,
        ),
        const SizedBox(height: 24),
        _InfoRow(label: 'Origin', value: breed.origin),
        _InfoRow(label: 'Life span', value: breed.lifeSpan),
        if (breed.breedGroup != null)
          _InfoRow(label: 'Breed group', value: breed.breedGroup!),
        if (breed.weight != null)
          _InfoRow(label: 'Weight', value: '${breed.weight!.metric} kg'),
        if (breed.height != null)
          _InfoRow(label: 'Height', value: '${breed.height!.metric} cm'),
        const SizedBox(height: 24),
        Text(
          'Temperament',
          style: textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        Text(
          breed.temperament,
          style: textTheme.bodyMedium,
        ),
        if (breed.history != null) ...[
          const SizedBox(height: 24),
          Text(
            'History',
            style: textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            breed.history!,
            style: textTheme.bodyMedium,
          ),
        ],
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}