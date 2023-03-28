part of 'unsplash_bloc.dart';

@immutable
abstract class UnsplashEvent {}

class LoadUnsplashEvent extends UnsplashState{}
class LoadUnsplashDetailEvent extends UnsplashEvent{
final String id;
LoadUnsplashDetailEvent({required this.id});
}

class RefreshUnsplashEvent extends UnsplashEvent {}