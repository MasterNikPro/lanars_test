
import 'package:dio/dio.dart';


import '../models/unsplash_api_search.dart';
class UnsplashServiceSearch {
  final _dio = Dio(BaseOptions(baseUrl: 'https://api.unsplash.com'));
  final String _apiKey= "7Y9nimADYZuUc8ZO1CqaGTLGlc-_BGz71u6nXW9utAw";
  Future<List<UnsplashImageSearch?>?> getPhotos(int page, int perPage,String keyword) async {
    try {
      final response = await _dio.get('/search/photos', queryParameters: {
        "client_id": _apiKey,
        "page": page,
        "query": keyword,
        "per_page": perPage,
        "order_by": "popular"
      },);
      final data = response.data;

     final result=data['results'];
     final main= result as List<dynamic>;
      return main.map((unsplashImage) => UnsplashImageSearch.fromJson(unsplashImage)).toList();
    } on DioError catch (error) {
      throw error.message ?? "An error occurred while making the request";
    }
  }
}