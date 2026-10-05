import 'package:flutter/material.dart';

import 'package:catbreeds_app/core/theme/app_colors.dart';

import '../../domain/entities/cat_breed.dart';

class CatBreedCard extends StatelessWidget {
  final CatBreed breed;
  final VoidCallback onTap;

  const CatBreedCard({super.key, required this.breed, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: _buildInformation(context),
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
        height: 200,
        alignment: Alignment.center,
        color: AppColors.placeholder,
        child: const Icon(Icons.pets, size: 64, color: AppColors.textSecondary),
      );
    }

    return Image.network(
      breed.image!.url,
      width: double.infinity,
      height: 200,
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
                  height: 200,
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
  }

  Widget _buildInformation(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(breed.name, style: textTheme.titleLarge),
        const SizedBox(height: 6),
        Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              size: 18,
              color: textTheme.bodyMedium?.color,
            ),
            const SizedBox(width: 4),
            Expanded(child: Text(breed.origin, style: textTheme.bodyMedium)),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          breed.temperament,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: textTheme.bodyMedium,
        ),
      ],
    );
  }
}
