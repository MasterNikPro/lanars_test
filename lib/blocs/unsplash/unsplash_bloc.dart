import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/unsplash_image.dart';
import '../../sevices/unsplash_api_service.dart';

part 'unsplash_event.dart';

part 'unsplash_state.dart';

class UnsplashBloc extends Bloc<UnsplashEvent, UnsplashState> {
  final UnsplashService unsplashService;

  UnsplashBloc(this.unsplashService) : super(UnsplashInitial()) {
    on<UnsplashGetPhotos>(_onGetPhotos);
  }

  _onGetPhotos(UnsplashGetPhotos event, Emitter<UnsplashState> emit) async {
    emit(UnsplashLoadingState());
    emit(UnsplashLoadedState(images: event.images));
  }
}
