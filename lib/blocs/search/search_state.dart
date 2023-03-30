part of 'search_bloc.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}
class LoadedSearchImagesState extends SearchState{
  final List<UnsplashImageSearch?>? images;
  final String keyword;
  LoadedSearchImagesState({required this.images,required this.keyword});
}
class LoadingSearchImagesState extends SearchState{
}