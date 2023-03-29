part of 'unsplash_bloc.dart';

@immutable
abstract class UnsplashEvent {}

class UnsplashGetPhotos extends UnsplashEvent{
  final List<UnsplashImage> images;
  UnsplashGetPhotos(this.images);
}
class UnsplashUpdatePhotos extends UnsplashEvent{
  final List<UnsplashImage> images;
  UnsplashUpdatePhotos(this.images);
}

