part of 'search_bloc.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}
class LoadedSearchImagesState extends SearchState{
  final List<UnsplashImageSearch?>? images;
  LoadedSearchImagesState({required this.images});
}
class LoadingSearchImagesState extends SearchState{
}