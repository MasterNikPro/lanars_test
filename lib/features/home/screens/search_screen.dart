import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lanars_test/blocs/search/search_bloc.dart';
import 'package:lanars_test/features/home/widgets/image_tile_search.dart';
import 'package:lanars_test/models/unsplash_api_search.dart';
import 'package:lanars_test/sevices/unsplash_api_search_service.dart';

import '../../../models/unsplash_image.dart';
import '../widgets/bottom_navigation_bar.dart';
import '../widgets/image_tile.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<UnsplashImageSearch> _photos = [];
  int _page = 1;
  final bloc = SearchBloc();
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  late String _keyword = "lol";
  late List<UnsplashImage> images;

  @override
  void initState() {
    // TODO: implement initState
    _fetchPhotos();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  void _fetchPhotos() async {

      List<UnsplashImageSearch?>? photos =
          await UnsplashServiceSearch().getPhotos(_page, 20, _keyword);

      _photos.addAll(photos as Iterable<UnsplashImageSearch>);
      bloc.add(LoadedSearchImagesEvent(
          await UnsplashServiceSearch().getPhotos(_page, 20, _keyword)));
      bloc.add(LoadedSearchImagesEvent(_photos));
      _page++;
      _isLoading = false;

  }

  void _scrollListener() {
    if (!_isLoading &&
        _scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
      _fetchPhotos();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(),
      child: Scaffold(
        appBar: AppBar(),
        bottomNavigationBar: BottomNavBar(),
        backgroundColor: Colors.grey[50],
        body: BlocBuilder<SearchBloc, SearchState>(
          bloc: bloc,
          builder: (context, state) {
            if (state is LoadedSearchImagesState) {
              return GridView.custom(
                  controller: _scrollController,
                  padding: const EdgeInsets.only(
                    bottom: 16,
                    left: 16,
                    right: 16,
                  ),
                  gridDelegate: SliverQuiltedGridDelegate(
                    crossAxisCount: 6,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    repeatPattern: QuiltedGridRepeatPattern.inverted,
                    pattern: const [
                      QuiltedGridTile(4, 4),
                      QuiltedGridTile(2, 2),
                      QuiltedGridTile(2, 2),
                    ],
                  ),
                  childrenDelegate: SliverChildBuilderDelegate(
                        (context, index) {
                      return ImageTileSearch(state.images![index]!);
                          //return Image.network(state.images![index]!.urls!.regular);
                    },
                    childCount: _photos.length,
                  ));
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
/*
  Widget _buildSearchAppBar() => Container(
        child: SliverAppBar(
          //Appbar Title
          title: _keyword != null

              // either search-field or just the title
              ? TextField(
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      hintText: 'Search...', border: InputBorder.none),
                  onSubmitted: (String keyword) {
                    _fetchPhotos();
                  }
                  // search and display images associated to the keyword

                  )
              : const Text('Flutter Unsplash',
                  style: TextStyle(color: Colors.black87)),

          //Appbar actions
          actions: <Widget>[
            //Search
            // either search oder clear button
            _keyword != null
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    color: Colors.black87,
                    onPressed: () {
                      // reset the state
                    },
                  )
                : IconButton(
                    icon: const Icon(Icons.search),
                    color: Colors.black87,
                    onPressed: () =>
                        // go into searching state
                        setState(() => _keyword = ""),
                  ),
          ],

          //Color
          backgroundColor: Colors.grey[50],
        ),
      );*/
}
