part of 'unsplash_bloc.dart';

@immutable
abstract class UnsplashState {}

class UnsplashInitial extends UnsplashState {}

class UnsplashLoadedState extends UnsplashState{
  final List<UnsplashImage> images;
  UnsplashLoadedState({required this.images});
}
class UnsplashErrorState extends UnsplashState{
}
class UnsplashRefreshState  extends UnsplashState{}
