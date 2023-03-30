part of 'unsplash_bloc.dart';

@immutable
 class UnsplashState {}

class UnsplashInitial extends UnsplashState {

}

class UnsplashLoadedState extends UnsplashState {
  final List<UnsplashImage> images;

  UnsplashLoadedState({required this.images});

}

class UnsplashLoadingState extends UnsplashState {
}
