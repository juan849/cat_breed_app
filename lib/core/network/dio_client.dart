import 'package:dio/dio.dart';

class DioClient {
  static const String _baseUrl = 'https://api.thecatapi.com/v1';


  static const String _apiKey = String.fromEnvironment('CAT_API_KEY');
  static Dio create() {
    return Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        headers: {
          'x-api-key': _apiKey,
          'Content-Type': 'application/json',
        },
      ),
    );
  }
}