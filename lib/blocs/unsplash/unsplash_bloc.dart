import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'unsplash_event.dart';
part 'unsplash_state.dart';

class UnsplashBloc extends Bloc<UnsplashEvent, UnsplashState> {
  UnsplashBloc() : super(UnsplashInitial()) {
    on<UnsplashEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
