part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}
class LoadedSearchImagesEvent extends SearchEvent{
  final List<UnsplashImageSearch?>? images;
  LoadedSearchImagesEvent( this.images);
}
