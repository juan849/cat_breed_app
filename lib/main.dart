import 'package:catbreeds_app/core/network/dio_client.dart';
import 'package:catbreeds_app/core/theme/app_theme.dart';
import 'package:catbreeds_app/features/catbreeds/data/datasources/cat_breed_remote_datasource.dart';
import 'package:catbreeds_app/features/catbreeds/data/repositories/cat_breed_repository_impl.dart';
import 'package:catbreeds_app/features/catbreeds/domain/usecases/get_cat_breeds.dart';
import 'package:catbreeds_app/features/catbreeds/presentation/providers/cat_breeds_provider.dart';
import 'package:catbreeds_app/features/catbreeds/presentation/screens/splash_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();

  final dio = DioClient.create();

  final dataSource = CatBreedRemoteDataSourceImpl(dio);

  final repository = CatBreedRepositoryImpl(dataSource);

  final getCatBreeds = GetCatBreeds(repository);


  runApp(
    ChangeNotifierProvider(
      create: (_) => CatBreedsProvider(getCatBreeds),
      child: const CatbreedsApp(),
    )

  );

  
}

class CatbreedsApp extends StatelessWidget {
  const CatbreedsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Catbreeds',
      
      theme: AppTheme.light,
      home: const SplashScreen(),
    );
  }
  }