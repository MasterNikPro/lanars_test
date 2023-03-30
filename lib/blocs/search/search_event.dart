part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}
class LoadedSearchImagesEvent extends SearchEvent{
  final List<UnsplashImageSearch?>? images;
  final String keyword;
  LoadedSearchImagesEvent( this.images,this.keyword);
}
