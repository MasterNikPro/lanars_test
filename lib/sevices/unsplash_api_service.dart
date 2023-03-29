import 'package:dio/dio.dart';
import 'package:lanars_test/models/unsplash_image.dart';
class UnsplashService {
  final _dio = Dio(BaseOptions(baseUrl: 'https://api.unsplash.com'));
  final String _apiKey= "7Y9nimADYZuUc8ZO1CqaGTLGlc-_BGz71u6nXW9utAw";
  Future<List<UnsplashImage>> getPhotos(int page, int perPage) async {
    try {
      final response = await _dio.get('/photos', queryParameters: {
        "client_id": _apiKey,
        "page": page,
        "per_page": perPage,
      },);
      final data = response.data as List<dynamic>;
      return data.map((unsplashImage) => UnsplashImage.fromJson(unsplashImage)).toList();
    } on DioError catch (error) {
      throw error.message ?? "An error occurred while making the request";
    }
  }
}