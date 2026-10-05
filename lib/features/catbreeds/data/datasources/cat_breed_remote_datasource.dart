import 'package:catbreeds_app/core/error/app_exception.dart';
import 'package:dio/dio.dart';

import '../models/cat_breed_model.dart';

abstract class CatBreedRemoteDataSource {
  Future<List<CatBreedModel>> getCatBreeds();
}

class CatBreedRemoteDataSourceImpl implements CatBreedRemoteDataSource {
  final Dio dio;

  CatBreedRemoteDataSourceImpl(this.dio);

  @override
  Future<List<CatBreedModel>> getCatBreeds() async {
    try {
      final response = await dio.get('/breeds');

      if (response.data is! List) {
        throw const UnexpectedException();
      }

      final data = response.data as List<dynamic>;

      return data
          .map((json) => CatBreedModel.fromJson(json as Map<String, dynamic>))
          .toList();
          
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        throw const NetworkException();
      }

      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw const TimeoutException();
      }

      final statusCode = e.response?.statusCode;

      switch (statusCode) {
        case 401:
          throw const UnauthorizedException();

        case 403:
          throw const ForbiddenException();

        case 404:
          throw const NotFoundException();

        default:
          if (statusCode != null && statusCode >= 500) {
            throw ServerException(statusCode);
          }

          throw const UnexpectedException();
      }
    } on AppException {
      rethrow;
    } catch (_) {
      throw const UnexpectedException();
    }
  }
}
