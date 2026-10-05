import 'package:catbreeds_app/core/theme/app_colors.dart';
import 'package:catbreeds_app/features/catbreeds/presentation/widgets/cat_breed_card.dart';
import 'package:catbreeds_app/features/catbreeds/presentation/screens/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cat_breeds_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (!mounted) return;

      context.read<CatBreedsProvider>().loadBreeds();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CatBreedsProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Catbreeds'),
      ),
      body: _buildBody(provider),
    );
  }

  Widget _buildBody(CatBreedsProvider provider) {
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.errorMessage != null) {
      return _buildErrorState(
        context,
        provider.errorMessage!,
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            onChanged: (value) {
              context.read<CatBreedsProvider>().searchBreeds(value);
            },
            decoration: InputDecoration(
              hintText: 'Search breed...',
              prefixIcon: const Icon(Icons.search),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: provider.filteredBreeds.isEmpty
                ? _buildEmptyState(context)
                : ListView.builder(
                    itemCount: provider.filteredBreeds.length,
                    itemBuilder: (context, index) {
                      final breed = provider.filteredBreeds[index];

                      return CatBreedCard(
                        breed: breed,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailScreen(breed: breed),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  // ?Widget que se despliega cuando no hay resultados de búsqueda
  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.search_off_rounded,
            size: 56,
            color: AppColors.primary,
          ),
          const SizedBox(height: 12),
          Text(
            'No breeds found',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 6),
          Text(
            'Try another search.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  // ?Widget que se despliega cuando hay un error en la carga de datos
  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.cloud_off_rounded,
            size: 56,
            color: AppColors.primary,
          ),
          const SizedBox(height: 12),
          Text(
            'Something went wrong',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}