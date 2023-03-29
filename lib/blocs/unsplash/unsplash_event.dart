part of 'unsplash_bloc.dart';

@immutable
abstract class UnsplashEvent {}

class UnsplashGetPhotos extends UnsplashEvent{
  final List<UnsplashImage> images;
  UnsplashGetPhotos(this.images);

}