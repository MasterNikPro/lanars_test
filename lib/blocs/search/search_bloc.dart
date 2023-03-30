import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:lanars_test/models/unsplash_api_search.dart';
import 'package:meta/meta.dart';

import '../../models/unsplash_image.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<LoadedSearchImagesEvent>(_onSearched);
  }
  _onSearched(LoadedSearchImagesEvent event,Emitter<SearchState> emit ){
    emit(LoadingSearchImagesState());
    emit(LoadedSearchImagesState(images:event.images, keyword: event.keyword));
  }
}
